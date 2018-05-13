//
//  ThemeSupporting.swift
//  XZKit
//
//  Created by mlibai on 2018/5/2.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit

/// 默认为 NSObject 提供了 XZThemeSupporting 支持。
extension NSObject {
    
    /// 全局样式。
    @objc(xz_themes)
    open static var themes: Theme.Collection {
        if let themes = self.themesIfLoaded {
            return themes
        }
        let themes = Theme.Collection.init(nil)
        objc_setAssociatedObject(self, &AssociationKey.themes, themes, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return themes
    }
    
    /// 当前对象的所有主题，如果已加载。
    @objc(xz_themesIfLoaded)
    open static var themesIfLoaded: Theme.Collection? {
        return objc_getAssociatedObject(self, &AssociationKey.themes) as? Theme.Collection
    }
    
    /// 当前对象的所有主题，懒加载。
    @objc(xz_themes)
    open var themes: Theme.Collection {
        if let themes = self.themesIfLoaded {
            return themes
        }
        let themes = Theme.Collection.init(self)
        objc_setAssociatedObject(self, &AssociationKey.themes, themes, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        /// 如果将通知添加到 NSObject 上，则释放通知是个问题。
        /// 如果将通知添加到 Theme.Collection 上，那么 Theme.Collection 对象的 object 应该改为 weak 。
        
        return themes
    }
    
    /// 当前对象的所有主题，如果已加载。
    @objc(xz_themesIfLoaded)
    open var themesIfLoaded: Theme.Collection? {
        return objc_getAssociatedObject(self, &AssociationKey.themes) as? Theme.Collection
    }
    
    
    
    
    /// 主题标识符。
    /// - 设置主题标识符后，框架将自动缓存（磁盘）主题配置或从配置文件中读取配置。
    @objc(xz_themeIdentifier)
    open var themeIdentifier: Theme.Identifier? {
        get { return self.themesIfLoaded?.themeIdentifier }
        set { self.themes.themeIdentifier = newValue      }
    }
    
    /// 当前已应用的主题。
    /// - Note: 已应用的主题不等于当前主题，特别是当控件未显示时。
    /// - Note: 如果为对象配置当前主题的主题样式，那么使用的是默认主题的主题样式。
    @objc(xz_appliedTheme)
    open internal(set) var appliedTheme: Theme? {
        get { return self.themesIfLoaded?.appliedTheme       }
        set { self.themes.appliedTheme = newValue   }
    }
    
    /// 是否已经被标记需要更新主题。
    @objc(xz_needsUpdateThemeAppearance)
    open internal(set) var needsUpdateThemeAppearance: Bool {
        get { return self.themesIfLoaded?.needsUpdateThemeAppearance ?? false }
        set { self.themes.needsUpdateThemeAppearance = newValue }
    }
    
    /// 在主题发生改变时，是否自动应用主题。默认 true 。
    /// - Note: 当对象首次配置主题样式或设置主题标识符时，此属性决定 XZTheme 是否自动管理对象的主题。
    /// - Note: 被管理的对象通过监听通知，在主题变更时，调用对象的 `setNeedsThemeAppearanceUpdate` 方法来切换主题。
    /// - Note: 如果对象的主题有其自己的管理机制（比如 `UIView`），重写此属性并返回 false ，以停用 XZTheme 的自动管理。
    @objc(xz_shouldAutomaticallyUpdateThemeAppearance)
    open var shouldAutomaticallyUpdateThemeAppearance: Bool {
        return true;
    }
    
    /// 是否传递主题变更事件。
    /// - Note: 在 NSObject 实现中，该方法返回 YES 。
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
        // 如果没有配置主题，不执行操作。
        guard let themes = self.themesIfLoaded else { return }
        
        // 应用主题样式。
        if let themeStyles = themes.themeStylesIfLoaded(forTheme: newTheme) {
            self.updateAppearance(with: themeStyles)
            return;
        }
        
        // 配置了主题，但是无当前主题配置，应用默认主题，以避免控件没有样式。
        if let themeStyles = themes.themeStylesIfLoaded(forTheme: .default) {
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
    
}


extension UIView {
    
    /// UIView 控件拥有自己管理主题机制，此属性返回 false 。
    open override var shouldAutomaticallyUpdateThemeAppearance: Bool {
        return false
    }
    
    /// 当视图控件被标记为需要更新主题时，会同时标记其子视图。
    /// - Note: 子类可通过 forwardsThemeAppearanceUpdate 属性来控制该行为。
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
    
}

extension UIBarButtonItem {
    
    /// UIBarButtonItem 拥有自己管理主题机制，此属性返回 false 。
    open override var shouldAutomaticallyUpdateThemeAppearance: Bool {
        return false
    }
    
}


private struct AssociationKey {
    static var themes: Int = 0
}



