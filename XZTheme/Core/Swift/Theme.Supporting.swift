//
//  Theme.Supporting.swift
//  XZKit
//
//  Created by mlibai on 2018/5/2.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit

extension NSObject {
    
    /// 私有样式集。与主题无关。
    /// - Note: 私有样式仅为当前对象所有，优先级最高。
    /// - Note: 当主题变更时，私有样式不会改变也不会清空。
    @objc(xz_themeStyles)
    open var themeStyles: Theme.Style.Collection {
        if let themeStyles = self.themeStylesIfLoaded {
            return themeStyles
        }
        let themeStyles = Theme.Style.Collection.init(for: self)
        objc_setAssociatedObject(self, &AssociationKey.themeStyles, themeStyles, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return themeStyles
    }
    
    @objc(xz_themesIfLoaded)
    open var themeStylesIfLoaded: Theme.Style.Collection? {
        return objc_getAssociatedObject(self, &AssociationKey.themeStyles) as? Theme.Style.Collection
    }
    
    /// 私有样式集，非懒加载。
    /// 主题标识符。
    @objc(xz_themeIdentifier)
    open var themeIdentifier: Theme.Identifier? {
        get { return objc_getAssociatedObject(self, &AssociationKey.themeIdentifier) as? Theme.Identifier }
        set { objc_setAssociatedObject(self, &AssociationKey.themeIdentifier, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
   
    /// 当前已应用的主题。
    /// - Note: 已应用的主题不等于当前主题，特别是当控件未显示时。
    /// - Note: 如果为对象配置当前主题的主题样式，那么使用的是默认主题的主题样式。
    @objc(xz_appliedTheme)
    open private(set) var appliedTheme: Theme? {
        get { return objc_getAssociatedObject(self, &AssociationKey.appliedTheme) as? Theme }
        set { objc_setAssociatedObject(self, &AssociationKey.appliedTheme, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    /// 是否已经被标记需要更新主题。
    @objc(xz_needsUpdateThemeAppearance)
    open private(set) var needsUpdateThemeAppearance: Bool {
        get { return (objc_getAssociatedObject(self, &AssociationKey.needsUpdateThemeAppearance) as? Bool) == true }
        set { objc_setAssociatedObject(self, &AssociationKey.needsUpdateThemeAppearance, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
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
        guard newTheme != self.appliedTheme else { return }
        // 获取主题配置
        guard let themes = newTheme.themesIfLoaded(for: self) else { return }
        // 获取主题计算样式
        guard let themeStyles = themes.themeStyles(for: self) else { return }
        self.updateAppearance(with: themeStyles)
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
    
    /// **DO NOT USE this property directly!!!**
    /// It's used for interface builder inspecting the object's `themeIdentifier` property.
    @IBInspectable
    public var __themeIdentifier: String? {
        get {
            return self.themeIdentifier?.rawValue
        }
        set {
            if let newIdentifier = newValue {
                self.themeIdentifier = Theme.Identifier.init(rawValue: newIdentifier)
            } else {
                self.themeIdentifier = nil
            }
        }
    }
    
}


extension UIView {
    
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


private struct AssociationKey {
    static var themeStyles:                 Int = 0
    static var computedThemeStyles:         Int = 1
    static var themeIdentifier:             Int = 2
    static var appliedTheme:                Int = 3
    static var needsUpdateThemeAppearance:  Int = 4
}



