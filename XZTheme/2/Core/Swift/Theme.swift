//
//  Theme.swift
//  XZKit
//
//  Created by mlibai on 2018/5/2.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit

/// 尝试使用泛型最终以失败告终，无法解决的问题：
/// - Swift 对象无法在 OC 方法中出现。
/// - Swift 类目方法，无法继承重写。
/// - Swift 泛型无法桥接到 OC 。
/// - OC 泛型在 Swift 中泛型拓展，无法访问原始定义的方法。
/// - 子类无法在方法参数继承到一个泛型是自己的参数。
/// - 其它众多阻碍，最终导致无法实现。

/// 当前控件的缺点：
/// 1. XZThemeStyle 属性过多。
/// 2. 通过 extension 拓展的外观样式属性，可能无法的拓展。
/// 对于缺点1，一般情况下，开发对于要设置外观样式，应该使用哪个属性都很清楚，应该不存在混淆的问题，即使存在也是少数。
/// 这种情况类似于 CSS 样式，没有具体的约束某个类型的控件能用什么样式属性，但是不影响它的正常使用。
/// 对于缺点2，在框架设计之初，考虑过使用运行时动态捕捉方法和参数的方案，但是最终弃用。
/// 运行时的方式，类似于 UIAppearance 机制，可以解决1的问题，同时也不存在2问题，但是这一套机制只能用于 OC ，而且对内存也不是很友好。
/// 所以本框架的设计目的就很明确了，通过一次劳动，将已知的外观属性，通过一套规则，使其能自动应用已配置的值，而且可以控制这其中的内存和性能消耗。
/// 如果框架对所有 UIKit 视图都默认提供了一套主题规则，而且开发者不需要太多学习成本，只需设置属性值，就可以轻松实现主题支持，那么本框架的设计目的就实现了。
/// 一般情况下，对系统控件进行拓展并提供额外的属性来控制外观，这在目前除了使用运行时，似乎没有办法解决。不过好在，一般情况下，拓展系统组件不会对
/// 改变外观样式，或者对外观样式的改变，也是通过添加额外的子视图来实现，而子视图是在主题传播链上的，似乎也不是不能解决的问题。因此，当我们想通过拓展给系统
/// 组件添加额外的功能时，有必要提供公开的接口，便于其它开发者直接控制管理，比如 MJRefresh ，你可以通过 mj_header 来访问它额外增加的视图。

/// Swift 是 iOS 语言趋势，也是 XZTheme 框架所适配的唯一语言。
/// XZTheme 核心功能虽然是 OC 代码，但是其完整的功能，只有使用 Swift 才能支持。

/// @b 主题。
/// 主题的机制依赖与运行时，所以主要代码以 Objective-C 呈现。
/// @todo 主题样式的资源管理以及静态缓存策略（通过主题标识符，将配置缓存到磁盘上）待研究。
/// @todo 通过主题标识符自动读取配置。
/// @todo 通过字典、JSON串来配置样式。
/// XZTheme

extension Notification.Name {
    /// 当主题发生改变时，所发送通知的名称。
    public static let ThemeDidChange = Notification.Name.init("com.mlibai.XZKit.theme.changed")
}

extension Theme {
    /// 应用主题动画时长，0.5 秒。
    public static let AnimationDuration: TimeInterval = 0.5
    /// 在 UserDefaults 中记录当前主题所使用的 Key 。
    public static let UserDefaultsKey: String = "com.mlibai.XZKit.theme.default"
    /// 默认主题。
    /// @note 如果对象没有设置任何主题样式，那么该主题为默认生效的主题。
    /// @note 如果应用主题时，某对象的主题配置不存在，会默认查找一次默认主题。
    /// @note 建议使用默认主题 + 自定义主题组合。
    @objc(defaultTheme) public static let `default`: Theme = Theme.init(name: "default")
    /// 当前主题，默认 Theme.default 。
    @objc(currentTheme) public private(set) static var current: Theme = {
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
    @objc(apply:) public func apply(_ animated: Bool) {
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
    public let name: String
    /// 构造主题对象。
    ///
    /// - Parameter name: 主题名称。
    public init(name: String) {
        self.name = name
    }
    
    /// Theme.Collection 是 Theme 的集合，它管理了对象所支持的主题和样式配置。
    /// - Note: 可使用 Array.init(_:Theme.Collection) 将集合转换为普通数组。
    @objc(XZThemeCollection) public final class Collection: NSObject {
        /// 当前 XZThemeCollection 所属的对象。
        /// - Note: 因为运行时的值绑定机制，被绑定的值生命周期可能比对象的生命周期长，所以该属性需谨慎使用。
        @objc public unowned let object: ThemeSupporting
        @objc(initWithObject:) public init(_ object: ThemeSupporting) {
            self.object = object
            super.init()
        }
        /// 按主题分类的主题样式集合。
        internal lazy var themedStyles = [Theme: Theme.Style.Collection]()
    }
    
    /// 主题样式。
    @objc(XZThemeStyle) public class Style: NSObject {
        @objc public unowned let object: ThemeSupporting
        @objc(initWithObject:) public init(_ object: ThemeSupporting) {
            self.object = object
            super.init()
        }
        internal lazy var attributedValues = [Theme.Attribute: Any?]()
        
        /// 主题样式集合。
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









