//
//  Theme.Supporting.swift
//  XZKit
//
//  Created by mlibai on 2018/5/2.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit


/// 默认为 NSObject 提供了 XZThemeSupporting 支持。
extension NSObject {
    
    /// 全局主题集，不带标识符的全局主题，懒加载。
    /// - Note: 修改全局主题集不会影响已应用主题的对象。
    /// - Note: 当应用主题时，样式检索顺序为：对象的主题集 -> 指定标识符的全局主题集 -> 全局主题集 。
    /// - Note: 本主题集将主题集标识符 Theme.Identifier.notAnIdentifier 作为存储标识符。
    @objc(xz_themes)
    open class var themes: Theme.Collection {
        return themes(forThemeIdentifier: .notAnIdentifier)
    }
    
    /// 全局主题集，不带标识符的全局主题，非懒加载。
    /// - Note: 修改全局主题集不会影响已应用主题的对象。
    /// - Note: 当应用主题时，样式检索顺序为：对象的主题集 -> 指定标识符的全局主题集 -> 全局主题集 。
    /// - Note: 本主题集将主题集标识符 Theme.Identifier.notAnIdentifier 作为存储标识符。
    @objc(xz_themesIfLoaded)
    open class var themesIfLoaded: Theme.Collection? {
        return themesIfLoaded(forThemeIdentifier: .notAnIdentifier)
    }
    
    /// 指定主题标识符的全局主题集，懒加载。
    ///
    /// - Parameter themeIdentifier: 主题标识符。
    /// - Returns: 主题集。
    @objc(xz_themesForThemeIdentifier:)
    open class func themes(forThemeIdentifier themeIdentifier: Theme.Identifier) -> Theme.Collection {
        if var themesDictionary = objc_getAssociatedObject(self, &AssociationKey.themes) as? [Theme.Identifier: Theme.Collection] {
            if let themes = themesDictionary[themeIdentifier] {
                return themes
            }
            let newThemes = Theme.Collection.init(for: self, themeIdentifier: themeIdentifier)
            themesDictionary[themeIdentifier] = newThemes
            objc_setAssociatedObject(self, &AssociationKey.themes, themesDictionary, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return newThemes
        }
        let newThemes = Theme.Collection.init(for: self, themeIdentifier: themeIdentifier)
        objc_setAssociatedObject(self, &AssociationKey.themes, [themeIdentifier: newThemes], .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return newThemes
    }
    
    /// 指定主题标识符的默认主题集，非懒加载。
    ///
    /// - Parameter themeIdentifier: 主题标识符。
    /// - Returns: 主题集。
    @objc(xz_themesIfLoadedForThemeIdentifier:)
    open class func themesIfLoaded(forThemeIdentifier themeIdentifier: Theme.Identifier) -> Theme.Collection? {
        return (objc_getAssociatedObject(self, &AssociationKey.themes) as? [Theme.Identifier: Theme.Collection])?[themeIdentifier]
    }
    
    /// 获取当前有效的全局主题集。
    /// - Note: 带标识符的全局主题集 -> 不带标识符的全局主题集 -> 父类不带标识符的全局主题集。
    /// - Note: 不带标识符的全局主题集 -> 父类不带标识符的全局主题集。
    ///
    /// - Parameter themeIdentifier: 主题标识符。
    /// - Returns: 主题集。
    @objc(xz_effectiveThemesForThemeIdentifier:)
    open class func effectiveThemes(forThemeIdentifier themeIdentifier: Theme.Identifier?) -> Theme.Collection? {
        if let themeIdentifier = themeIdentifier {
            // 获取 带标识符的主题集 并返回。
            if let effectiveThemes = self.themesIfLoaded(forThemeIdentifier: themeIdentifier) {
                return effectiveThemes
            }
            // 没有 带标识符的主题集，返回 不带标识符的主题集。
        }
        
        // 获取 不带标识符的全局主题集 并返回。
        if let effectiveThemes = self.themesIfLoaded {
            return effectiveThemes
        }
        
        // 没有 不带标识符的全局主题集，返回父类的全局主题集。
        // 查找父类。
        guard let superClsss = class_getSuperclass(self) as? NSObject.Type else { return nil }
        // 获取父类不带标识符的主题集。
        return superClsss.effectiveThemes(forThemeIdentifier: nil)
    }
    

}



extension NSObject {
    
    /// 主题集，懒加载。
    @objc(xz_themes)
    open var themes: Theme.Collection {
        if let themes = self.themesIfLoaded {
            return themes
        }
        let themes = Theme.Collection.init(for: self)
        objc_setAssociatedObject(self, &AssociationKey.themes, themes, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        /// 如果将通知添加到 NSObject 上，则释放通知是个问题。
        /// 如果将通知添加到 Theme.Collection 上，那么 Theme.Collection 对象的 object 应该改为 weak 。
        
        return themes
    }
    
    /// 主题集，如果已加载。
    @objc(xz_themesIfLoaded)
    open var themesIfLoaded: Theme.Collection? {
        return objc_getAssociatedObject(self, &AssociationKey.themes) as? Theme.Collection
    }
    
    /// 当前对象生效的主题集，可能是对象独立的主题集，也可能是全局默认的主题集，如果当前对象设置了标识符，可能是指定标识符的默认主题。
    open var effectiveThemes: Theme.Collection? {
        if let themes = self.themesIfLoaded {
            return themes
        }
        return type(of: self).effectiveThemes(forThemeIdentifier: self.themeIdentifier)
    }
    
    /// 主题标识符。
    @objc(xz_themeIdentifier)
    open var themeIdentifier: Theme.Identifier? {
        get { return objc_getAssociatedObject(self, &AssociationKey.themeIdentifier) as? Theme.Identifier }
        set { objc_setAssociatedObject(self, &AssociationKey.themeIdentifier, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    /// 当前已应用的主题。
    /// - Note: 已应用的主题不等于当前主题，特别是当控件未显示时。
    /// - Note: 如果为对象配置当前主题的主题样式，那么使用的是默认主题的主题样式。
    @objc(xz_appliedTheme)
    open internal(set) var appliedTheme: Theme? {
        get { return objc_getAssociatedObject(self, &AssociationKey.appliedTheme) as? Theme }
        set { objc_setAssociatedObject(self, &AssociationKey.appliedTheme, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    /// 是否已经被标记需要更新主题。
    @objc(xz_needsUpdateThemeAppearance)
    open internal(set) var needsUpdateThemeAppearance: Bool {
        get { return (objc_getAssociatedObject(self, &AssociationKey.needsUpdateThemeAppearance) as? Bool) == true }
        set { objc_setAssociatedObject(self, &AssociationKey.needsUpdateThemeAppearance, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    /// 在主题发生改变时，是否自动应用主题。默认 false 。
    /// - Note: 次方法已在 OC 中实现。即使使用了 `@objc` 标识，在 Swift 中定义的方法，与在 OC 中定义的方法，还是不完全一样。
    /// - Note: 对于所有 NSObject 子类，都可以通过重写此方法来启用由 XZTheme 框架默认实现的主题管理机制。
    /// - Note: 被管理的对象通过监听通知，在主题变更时，调用对象的 `setNeedsThemeAppearanceUpdate` 方法来切换主题。
    /// - Note: 如果对象的主题有其自己的管理机制（比如 `UIView`），重写此属性并返回 false ，以停用 XZTheme 的自动管理。
    //@objc(xz_shouldAutomaticallyUpdateThemeAppearance)
    //open var shouldAutomaticallyUpdateThemeAppearance: Bool {
    //    return false;
    //}
    
    /// 是否传递主题变更事件。
    /// - Note: 在 NSObject 实现中，该方法返回 true 。
    /// - Note: 在 UI 控件中，此属性会影响主题事件是否传递给其子视图。
    /// - Note: 在某些 UI 控件中，一般是独立的基础组件，该方法返回 NO 。
    @objc(xz_forwardsThemeAppearanceUpdate)
    open var forwardsThemeAppearanceUpdate: Bool {
        return true
    }
    
    /// 标记当前对象需要更新主题。
    /// - Note: 此方法主要目的是降低在更改主题样式时更新主题的频率，从而提高性能。
    /// - Note: 默认情况下，该方法将在下一 runloop 中调用 `-applyThemeIfNeeded` 方法，且在同一 runloop 中，多次调用，只会触发一次。
    /// - Note: 当 UI 控件初次配置主题时（调用 xz_themes 属性)，将自动地标记为需要更新主题。
    /// - Note: 当 UI 控件不显示时，更新其主题一般没有太大意义，所以在主题变更时，默认只向正在显示的视图发送了事件。
    /// - Note: 当 UI 控件添加到父视图时，其会自动检查自身主题与当前主题是否一致，并决定是否更新主题。
    /// - Note: 对于非 UIKit 控件对象，需要手动添加监听主题变更通知，并在合适的时机调用此方法。
    @objc(xz_setNeedsThemeAppearanceUpdate)
    open func setNeedsThemeAppearanceUpdate() {
        guard !self.needsUpdateThemeAppearance else {
            return
        }
        self.needsUpdateThemeAppearance = true
        DispatchQueue.main.async(execute: {
            self.updateThemeAppearanceIfNeeded()
        })
    }
    
    /// 如果已被标记为需要更新主题，调用此方法立即更新主题。
    /// - Note: 在 NSObject 默认实现中，此方法会调用 `-xz_updateAppearanceWithTheme:` 方法，并记录当前主题。
    /// - Note: <b>一般情况下，不需要重写此方法</b>。
    @objc(xz_updateThemeAppearanceIfNeeded)
    open func updateThemeAppearanceIfNeeded() {
        guard self.needsUpdateThemeAppearance else {
            return
        }
        self.needsUpdateThemeAppearance = false
        let newTheme = Theme.current
        self.updateAppearance(with: newTheme)
        self.appliedTheme = newTheme
    }
    
    /// 当需要应用主题时，此方法会被调用。
    /// - Note: 如果主题发生改变，则此方法一定会被调用（如果控件正在显示或将来会被显示）。
    /// - Note: 在 NSObject 默认实现中，当此方法执行时，属性 `xz_appliedTheme` 的值为旧的主题。
    /// - Note: 如果当前没有配置任何主题，则不会执行任何操作。
    /// - Note: 默认情况下此方法将检查是否已配置主题样式，并调用 `-xz_updateAppearanceWithThemeStyles:` 方法。
    /// - Note: 如果当前已配置主题，但是没有当前主题的样式，则尝试从默认主题配置中读取样式并应用。
    ///
    /// - Parameter newTheme: 待应用的主题。
    @objc(xz_updateAppearanceWithTheme:)
    open func updateAppearance(with newTheme: Theme) {
        // 如果当前已应用的主题与待应用的主题一致，不操作的话，那么修改主题配置后，可能导致无法应用新的配置。
        // 但是会不会造成某些情况下，主题被重复应用，有待验证。
        // guard newTheme != self.appliedTheme else {
        //     return
        // }
        // 如果没有配置主题，不执行操作。
        guard let themes = self.effectiveThemes else { return }
        
        // 获取当前主题的主题样式并应用。
        if let themeStyles = themes.effectiveThemeStyles(forTheme: newTheme) {
            self.updateAppearance(with: themeStyles)
            return;
        }

        // 当前无主题样式。配置了主题，但是无当前主题配置，应用默认主题，以避免控件没有样式。
        if let themeStyles = themes.effectiveThemeStyles(forTheme: .default) {
            self.updateAppearance(with: themeStyles)
        }
    }
    
    /// 当应用主题时，如果当前对象已配置了主题样式，则此方法会被调用。
    /// - Note: 当此方法执行时，属性 `xz_appliedTheme` 的值为旧的主题。
    /// - Note: 默认此方法不执行任何操作。
    /// - Note: 如果对象当前主题没有配置主题样式，则此处应用的样式为默认主题下配置的主题样式。
    ///
    /// - Parameter themeStyles: 主题样式。
    @objc(xz_updateAppearanceWithThemeStyles:)
    open func updateAppearance(with themeStyles: Theme.Style.Collection) {
        
    }
    
    /// **DO NOT use this property directly!!!**
    /// It's use for inspecting the object's `themeIdentifier` property into interface builder.
    @IBInspectable
    private var __themeIdentifier: String? {
        get {
            return self.themeIdentifier?.rawValue
        }
        set {
            if let newIdentifier = newValue {
                self.themeIdentifier = Theme.Identifier.init(newIdentifier)
            } else {
                self.themeIdentifier = nil
            }
        }
    }
    
}


extension UIView {
    
    /// UIView 控件拥有自己管理主题机制，此属性返回 false 。
    open override var shouldAutomaticallyUpdateThemeAppearance: Bool {
        return false
    }
    
    /// 当视图控件被标记为需要更新主题时，会同时标记其子视图。
    /// - Note: 子类可通过 forwardsThemeAppearanceUpdate 属性来控制该行为。
    /// - Note: 此方法会在以下情况自动调用：
    ///     - 添加到父视图，且已应用的主题与当前主题不一致时；
    ///     - 主题配置发生改变时；
    ///     - 新到主题应用时（如果 View 正在 window 上显示）；
    ///     - 父视图的此方法被调用时。
    open override func setNeedsThemeAppearanceUpdate() {
        guard !self.needsUpdateThemeAppearance else {
            return
        }
        super.setNeedsThemeAppearanceUpdate()
        guard self.forwardsThemeAppearanceUpdate else {
            return
        }
        for subview in self.subviews {
            subview.setNeedsThemeAppearanceUpdate()
        }
    }
    
}

extension UIViewController {
    
    /// UIViewController 拥有自己管理主题机制，此属性返回 false 。
    open override var shouldAutomaticallyUpdateThemeAppearance: Bool {
        return false
    }
    
    /// 当控制被标记为需要更新主题时，同时标记其 childViewControllers、presentedViewController、navigationItem、toolbarItems、tabBarItem 等属性。
    open override func setNeedsThemeAppearanceUpdate() {
        guard !self.needsUpdateThemeAppearance else {
            return
        }
        super.setNeedsThemeAppearanceUpdate()
        
        if navigationController != nil {
            self.navigationItem.setNeedsThemeAppearanceUpdate()
        }
        
        if tabBarController != nil {
            self.tabBarItem.setNeedsThemeAppearanceUpdate()
        }
        
        if let toolbarItems = self.toolbarItems {
            for toolbarItem in toolbarItems {
                toolbarItem.setNeedsThemeAppearanceUpdate()
            }
        }
        
        for childVC in self.childViewControllers {
            childVC.setNeedsThemeAppearanceUpdate()
        }
        
        self.presentedViewController?.setNeedsThemeAppearanceUpdate()
    }
}

extension UINavigationItem {
    
    /// UINavigationItem 拥有自己管理主题机制，此属性返回 false 。
    open override var shouldAutomaticallyUpdateThemeAppearance: Bool {
        return false
    }
    
    /// 当被标记为需要更新主题时，其 backBarButtonItem、leftBarButtonItems、rightBarButtonItems 会被标记为需要更新。
    open override func setNeedsThemeAppearanceUpdate() {
        if needsUpdateThemeAppearance {
            return
        }
        super.setNeedsThemeAppearanceUpdate()
        
        // self.titleView Will be called by it's superview.
        
        self.backBarButtonItem?.setNeedsThemeAppearanceUpdate()
        
        if let leftBarButtonItems = self.leftBarButtonItems {
            for barButtonItem in leftBarButtonItems {
                barButtonItem.setNeedsThemeAppearanceUpdate()
            }
        }
        
        if let rightBarButtonItems = self.rightBarButtonItems {
            for barButtonItem in rightBarButtonItems {
                barButtonItem.setNeedsThemeAppearanceUpdate()
            }
        }
        
    }
    
}


extension UIBarButtonItem {
    
    /// UIBarButtonItem 拥有自己管理主题机制，此属性返回 false 。
    open override var shouldAutomaticallyUpdateThemeAppearance: Bool {
        return false
    }
    
}


private struct AssociationKey {
    static var themes:                      Int = 0
    static var themeIdentifier:             Int = 1
    static var appliedTheme:                Int = 2
    static var needsUpdateThemeAppearance:  Int = 3
}



