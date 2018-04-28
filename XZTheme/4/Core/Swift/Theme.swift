//
//  Theme.swift
//  Hello
//
//  Created by mlibai on 2018/4/28.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit

//extension Notification.Name {
//    /// 当主题发生改变时，所发送通知的名称。
//    public static let ThemeDidChange: Notification.Name = Notification.Name.init("com.mlibai.XZKit.theme.changed")
//}
//
///// 保存默认主题使用的 NSUserDefault 键名。
///// - Note: 保存的内容为主题名称。
//public let ThemeUserDefaultsKey: String = "com.mlibai.XZKit.theme.default";
//
///// 应用主题动画时长。
//public let ThemeAnimationDuration: TimeInterval = 0.5

//extension Theme {

//    /// 当前主题。
//    /// - Note: 切换主题请使用 Theme.apply(_:) 方法。
//    public private(set) static var current: Theme = { () -> Theme in
//        guard let themeName = UserDefaults.standard.string(forKey: ThemeUserDefaultsKey) else {
//            return Theme.default
//        }
//        return Theme.init(themeName)
//    }()
//
//    /// 默认主题。
//    /// - Note: 如果对象没有设置任何主题样式，那么该主题为默认生效的主题。
//    /// - Note: 如果应用主题时，某对象的主题配置不存在，会默认查找一次默认主题。
//    /// - Note: 建议使用默认主题 + 自定义主题组合。
//    public static let `default`: Theme = Theme.init("default")
//
//    /// 应用主题。
//    ///
//    /// - Parameter animated: 是否渐变主题应用的过程。
//    public func apply(_ animated: Bool) {
//        guard Theme.current != self else {
//            return
//        }
//        Theme.current = self
//        UserDefaults.standard.set(self.rawValue, forKey: ThemeUserDefaultsKey)
//        // 更新当前视图。
//        for window in UIApplication.shared.windows {
//            window.setNeedsThemeAppearanceUpdate()
//            window.rootViewController?.setNeedsThemeAppearanceUpdate()
//            guard animated else { continue }
//            guard let snapView = window.snapshotView(afterScreenUpdates: false) else { continue }
//            window.addSubview(snapView)
//            UIView.animate(withDuration: ThemeAnimationDuration, animations: {
//                snapView.alpha = 0;
//            }, completion: { (_) in
//                snapView.removeFromSuperview()
//            })
//        }
//        // 发送通知。
//        NotificationCenter.default.post(name: .ThemeDidChange, object: self)
//    }
    
//}

//public struct Theme {
//
//    public let name: String
//
//    public init(name: String) {
//        self.name = name
//    }
//
//    public typealias Collection = XZThemeCollection
//    public typealias Style      = XZThemeStyle
//    public typealias Attribute  = XZThemeAttribute
//    public typealias State      = XZThemeState
//
//}
//
//extension Theme: ExpressibleByStringLiteral, Equatable, Hashable {
//
//    public typealias StringLiteralType = String
//
//    public init(stringLiteral value: String) {
//        self.init(name: value)
//    }
//
//    public static func == (lhs: Theme, rhs: Theme) -> Bool {
//        return lhs.name == rhs.name
//    }
//
//    public var hashValue: Int {
//        return name.hashValue
//    }
//
//}
//
//
//
//extension Theme: ReferenceConvertible {
//
//    public var description: String {
//        return name
//    }
//
//    public var debugDescription: String {
//        return "Theme(name: \(name))"
//    }
//
//    public typealias ReferenceType = XZTheme
//    public typealias _ObjectiveCType = XZTheme
//
//    public func _bridgeToObjectiveC() -> XZTheme {
//        return name as XZTheme
//    }
//
//    public static func _forceBridgeFromObjectiveC(_ source: XZTheme, result: inout Theme?) {
//        result = Theme.init(name: source as String)
//    }
//
//    public static func _conditionallyBridgeFromObjectiveC(_ source: XZTheme, result: inout Theme?) -> Bool {
//        _forceBridgeFromObjectiveC(source, result: &result)
//        return true
//    }
//
//    public static func _unconditionallyBridgeFromObjectiveC(_ source: XZTheme?) -> Theme {
//        if let themeName = source {
//            return Theme.init(name: themeName as String)
//        }
//        return Theme.default
//    }
//
//}


