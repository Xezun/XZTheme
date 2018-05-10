//
//  Theme.swift
//  XZKit
//
//  Created by mlibai on 2018/5/2.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit


extension Notification.Name {
    /// XZTheme 主题变更事件。当主题发生改变时，发送 Notification 所使用的名称。
    public static let ThemeDidChange = Notification.Name.init("com.mlibai.XZKit.theme.changed")
}

extension Theme {
    /// 应用主题动画时长，0.5 秒。
    @objc public static let AnimationDuration: TimeInterval = 0.5
    /// 在 UserDefaults 中记录当前主题所使用的 Key 。
    @objc public static let UserDefaultsKey: String = "com.mlibai.XZKit.theme.default"
    /// 默认主题。
    /// - Note: 如果对象没有设置任何主题样式，那么该主题为默认生效的主题。
    /// - Note: 如果应用主题时，某对象的主题配置不存在，会默认查找一次默认主题。
    /// - Note: 建议使用默认主题 + 自定义主题组合。
    @objc(defaultTheme)
    public static let `default`: Theme = Theme.init(name: "default")
    /// 当前主题，默认 Theme.default 。
    @objc(currentTheme)
    public private(set) static var current: Theme = {
        if let themeName = UserDefaults.standard.string(forKey: Theme.UserDefaultsKey) {
            return Theme.init(name: themeName)
        }
        return Theme.default
    }()
    
    /// 应用主题。
    /// - Note: 应用主题会向所有 UIApplication.sharedApplication.windows 和根控制器发送主题事件。
    /// - Note: 视图控件或视图控制器，默认会向其子视图或自控制器以及相关联的对象发送事件。
    /// - Note: 没有正在显示的视图，会在显示（添加到父视图）时，根据自身主题和当前主题判断是否需要更新主题外观。
    /// - Note: 控制器也会在其将要显示时，判断主题从而决定是否更新主题外观。
    ///
    /// - Parameter animated: 是否渐变主题应用的过程。
    @objc(applyThemeAnimated:) public func apply(animated: Bool) {
        guard Theme.current != self else {
            return
        }
        Theme.current = self
        // 记住当前主题。
        UserDefaults.standard.set(self.name, forKey: Theme.UserDefaultsKey)
        // 更新正在显示的视图。
        for window in UIApplication.shared.windows {
            window.setNeedsThemeAppearanceUpdate()
            window.rootViewController?.setNeedsThemeAppearanceUpdate()
            guard animated else { continue }
            guard let snapView = window.snapshotView(afterScreenUpdates: false) else { continue }
            window.addSubview(snapView)
            UIView.animate(withDuration: Theme.AnimationDuration, animations: {
                snapView.alpha = 0
            }, completion: { (_) in
                snapView.removeFromSuperview()
            })
        }
        // 发送通知。
        NotificationCenter.default.post(name: .ThemeDidChange, object: self)
    }
}

// MARK: - 定义

/// 主题。
@objc(XZTheme) public final class Theme: NSObject {

    /// 主题名称。
    /// - Note: 主题名称为主题的唯一标识符，判断两个主题对象是否相等的唯一标准。
    @objc public let name: String
    
    /// 构造主题对象。
    ///
    /// - Parameter name: 主题名称。
    @objc public init(name: String) {
        self.name = name
        super.init()
    }
    
    /// Theme.Collection 用于描述对象的主题的集合。
    /// - Note: 在集合中，按主题分类存储了所有的样式配置。
    /// - Note: 可使用 Array.init(_:Theme.Collection) 将集合转换为普通数组。
    @objc(XZThemeCollection) public final class Collection: NSObject {
        /// 当前 XZThemeCollection 所属的对象。
        @objc public private(set) weak var object: ThemeSupporting?
        @objc public init(_ object: ThemeSupporting) {
            self.object = object
            super.init()
            
            if object.shouldAutomaticallyUpdateThemeAppearance {
                let selector = #selector(setNeedsThemeAppearanceUpdate)
                NotificationCenter.default.addObserver(self, selector: selector, name: .ThemeDidChange, object: nil)
            }
        }
        deinit {
            NotificationCenter.default.removeObserver(self, name: .ThemeDidChange, object: nil)
        }
        /// 按主题分类的主题样式集合。
        internal lazy var themedStyles = [Theme: Theme.Style.Collection]()
        /// 标记所有者主题需要更新。
        public override func setNeedsThemeAppearanceUpdate() {
            object?.setNeedsThemeAppearanceUpdate()
        }
    }
    
    /// 主题样式，负责存储主题属性。
    /// - Note: 使用 Array.init(_:Theme.Style) 可以取得所有已配置的属性。
    @objc(XZThemeStyle) public class Style: NSObject {
        @objc public unowned let object: ThemeSupporting
        @objc public init(_ object: ThemeSupporting) {
            self.object = object
            super.init()
        }
        internal lazy var attributedValues = [Theme.Attribute: Any?]()
        
        /// 主题样式集合：同一主题下，按状态分类的所有主题样式集合。
        /// - Note: 使用 Array.init(_:Theme.Style.Collection) 可以取得所有状态。
        @objc(XZThemeStyleCollection) public final class Collection: Theme.Style {
            internal lazy var statedStyles = [Theme.State: Theme.Style]()
        }
    }
    
    /// 主题样式属性。
    /// - Note: 主题样式属性一般情况下与对象的外观属性相对应。
    /// - Note: 主题样式属性名应该符合正则 /^[A-Za-z_][A-Za-z0-9_]+$/ 。
    public struct Attribute: RawRepresentable {
        public typealias RawValue = String
        public let rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
        public init(_ rawValue: String) {
            self.init(rawValue: rawValue)
        }
    }
    
    /// 主题样式属性状态。
    /// - Note: 主题状态一般情况下与触控状态相对应。
    /// - Note: 主题状态名应该符合正则 /^\:[A-Za-z]+$/ 。
    public struct State: RawRepresentable {
        public typealias RawValue = String
        public let rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
        public init(_ rawValue: String) {
            self.init(rawValue: rawValue)
        }
    }
    
    public struct Identifier: RawRepresentable {
        public typealias RawValue = String
        public let rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
        public init(_ rawValue: String) {
            self.init(rawValue: rawValue)
        }
    }
    
}

extension Theme: NSCopying {
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return Theme.init(name: self.name)
    }
    
    public override var hashValue: Int {
        return name.hashValue
    }
    
    public static func == (lhs: Theme, rhs: Theme) -> Bool {
        return lhs.name == rhs.name
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        if let theme = object as? Theme {
            return self == theme
        }
        return false
    }
    
}









