//
//  Themable.swift
//  Hello
//
//  Created by mlibai on 2018/4/28.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import Foundation

/// Themable 表明了遵循协议的对象支持设置或切换主题。
public protocol Themable: class {
    
    /// 支持主题的对象，也即主题拥有者。
    associatedtype Owner: AnyObject
    
    /// 对象所拥有的所有主题集合。
    /// - Note: 懒加载。
    /// - Note: 通过运行时值绑定的方式为对象添加的额外属性。
    /// - Note: 因为运行时的特性，主题相关对象的生命周期可能比其拥有者稍长，因此不建议在脱离拥有者的情况下调用主题相关对象的方法或属性。
    var themes: Theme.Collection<Owner> { get }
    
}

extension Themable {
    
    public var themes: Theme.Collection<Self> {
        if let themes = objc_getAssociatedObject(self, &AssociationKey.themes) as? Theme.Collection<Self> {
            return themes
        }
        let themes = Theme.Collection<Self>.init(self)
        objc_setAssociatedObject(self, &AssociationKey.themes, themes, .OBJC_ASSOCIATION_RETAIN)
        return themes
    }
    
    /// 当前对象的所有主题，如果已加载。
    public var themesIfLoaded: Theme.Collection<Self>? {
        return objc_getAssociatedObject(self, &AssociationKey.themes) as? Theme.Collection<Self>
    }
    
}

extension NSObject: Themable {
    
    /// 当前已应用的主题。
    public private(set) var appliedTheme: Theme? {
        get { return objc_getAssociatedObject(self, &AssociationKey.appliedTheme) as? Theme }
        set { objc_setAssociatedObject(self, &AssociationKey.appliedTheme, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    /// 是否传递主题变更事件。默认 YES 。
    /// @note 当 UIView 控件收到主题变更事件时，可以通过此方法来控制子视图是否更新主题。
    @objc(xz_forwardsThemeAppearanceUpdate) open func forwardsThemeAppearanceUpdate() -> Bool {
        return true
    }
    
    /// 是否已标记需要更新主题。
    @objc(xz_needsThemeAppearanceUpdate) open private(set) var xz_needsThemeAppearanceUpdate: Bool {
        get { return (objc_getAssociatedObject(self, &AssociationKey.needsThemeAppearanceUpdate) as? Bool) == true }
        set { objc_setAssociatedObject(self, &AssociationKey.needsThemeAppearanceUpdate, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    /// 将主题标记为需要更新。
    /// @note 此方法主要目的是降低在更改主题样式时更新主题的频率，从而提高性能；尽可能的只在视图显示时更新主题则不在此方法考虑的范围。
    /// @note 所以此方法一旦调用，更新主题的方法一定会发生，只是频率会大大减少。
    /// @note 默认情况下，该方法将在下一 runloop 中调用 `-applyThemeIfNeeded` 方法，且在同一 runloop 中，多次调用，只会触发一次。
    /// @note 对于 UIKit 控件，当主题发生改变时，此方法会自动调用；如果控件没有显示，则在其显示时会自动调用。
    /// @note 对于非 UIKit 控件对象，需要手动添加监听主题变更通知，并在合适的时机调用此方法（一般可以直接将通知绑定到此方法上）。
    @objc(xz_setNeedsThemeAppearanceUpdate) open func setNeedsThemeAppearanceUpdate() {
        
    }
    
    /// @b 一般情况下，请勿重写此方法。
    /// 如果已被标记为需要更新主题，则执行以下操作，否则不执行任何操作。
    /// @note 1. 取消标记。
    /// @note 2. 取出当前主题并应用（调用 `xz_updateAppearanceWithThemeStyles:` 方法）。
    /// @note 3. 记录 2 中应用的主题。
    @objc(xz_updateThemeAppearanceIfNeeded) open func updateThemeAppearanceIfNeeded() {
        
    }
    
    /// 当需要应用主题时，此方法会被调用。
    /// @note 当此方法执行时，属性 `xz_appliedTheme` 的值为旧的主题。
    /// @note 如果当前没有配置任何主题，则不会执行任何操作。
    /// @note 默认情况下此方法将检查是否已配置主题样式，并调用 `-xz_updateAppearanceWithThemeStyles:` 方法。
    /// @note 如果当前已配置主题，但是没有当前主题的样式，则尝试从默认主题配置中读取样式并应用。
    ///
    /// @param theme 待应用的主题。
    @objc(xz_updateAppearanceWithTheme:)
    open func updateAppearance(with theme: Theme) {
        
    }
    
    /// 当需要应用主题时，且当前对象已被配置主题样式时，此方法会被调用。
    /// @note 当此方法执行时，属性 `xz_appliedTheme` 的值为旧的主题。
    /// @note 默认此方法不执行任何操作。
    ///
    /// @param themeStyleSet 待应用的主题样式。
    @objc(xz_updateAppearanceWithThemeStyles:)
    open func updateAppearance(with themeStyles: Theme.Style<Owner>.Collection<Owner>) {
        
    }
    
    
}

private struct AssociationKey {
    
    static var themes: Int = 0
    static var appliedTheme: Int = 1
    static var needsThemeAppearanceUpdate: Int = 3
}

