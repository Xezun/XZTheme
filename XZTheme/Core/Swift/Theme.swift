//
//  Theme.swift
//  XZKit
//
//  Created by mlibai on 2018/5/2.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit
import XZKit

extension Notification.Name {
    /// XZTheme 主题变更事件。当主题发生改变时，发送 Notification 所使用的名称。
    public static let ThemeDidChange = Notification.Name.init("com.mlibai.XZKit.theme.changed")
}

extension Theme {
    
    /// 应用主题动画时长，0.5 秒。
    @objc public static let AnimationDuration: TimeInterval = 0.5
    
    /// 在 UserDefaults 中记录当前主题所使用的 Key 。
    @objc public static let UserDefaultsKey: String = "com.mlibai.XZKit.theme.default"
    
    /// 当前主题的默认主题。
    /// - Note: 如果从没有应用过主题，那么当前主题为本主题。
    /// - Note: 在默认规则下，对象应用主题时，如果没有找到主题样式，会尝试读取默认主题下的样式。
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
    
    // MARK: - 定义：主题集
    
    /// 用于描述对象的主题的集合（以后简称主题集）。
    /// - Note: 在集合中，按主题分类存储了所有的样式配置。
    /// - Note: 可使用 Array.init(_:Theme.Collection) 将集合转换为普通数组。
    @objc(XZThemeCollection) public final class Collection: NSObject {
        
        /// 主题集的所有者。
        /// - Note: 因为主题集与其所有者是值绑定的关系，生命周期可能比所有者略长，因此这里使用了 weak 属性。
        @objc public private(set) weak var object: NSObject?
        
        private weak var _superThemes: Theme.Collection?
        
        /// 父级主题集。主题样式查找的上一级。
        /// - Note: 如果当前主题集有所有者，该属性返回所有者的全局主题集。
        /// - Note: 带标识符的全局主题集，此属性返回默认的全局主题集。
        public internal(set) var superThemes: Theme.Collection? {
            get {
                guard let object = self.object else { return _superThemes }
                return type(of: object).effectiveThemes(forThemeIdentifier: themeIdentifier)
            }
            set {
                _superThemes = newValue
            }
        }
        
        /// 构造主题集，必须与所有者一同构造。
        /// - Note: 对象的默认主题集无所有者。
        ///
        /// - Parameters:
        ///   - object: 所有者。
        ///   - superThemes: （全局）主题集的上级主题集。
        @objc public init(_ object: NSObject?, superThemes: Theme.Collection?) {
            _superThemes = superThemes
            self.object = object
            super.init()
            // 如果主题集拥有所有者，则尝试自动主题管理，以及缓存相关的操作。
            guard let object = self.object else { return }
            
            if object.shouldAutomaticallyUpdateThemeAppearance {
                NotificationCenter.default.addObserver(self, selector: #selector(setNeedsThemeAppearanceUpdate), name: .ThemeDidChange, object: nil)
            }
            
            // TODO: - 如果有主题标识符，缓存到 caches ，否则缓存到 tmp （仅内存警告时）。
            // TODO: - 通过提供 block 的方法来构造样式，如果已有缓存则不执行 block ， 直接读缓存（使用数据库，只读当前主题的配置）。
            // TODO: - 判断是否有缓存，如果有读取缓存（通过类名+主题标识符来唯一标识缓存，避免相同的样式反复缓存）。否则。
            // TODO: - 判断是否有配置文件。如果有读取配置文件，并记录。
            
            // NotificationCenter.default.addObserver(self, selector: #selector(didReceiveMemoryWarning), name: .UIApplicationDidReceiveMemoryWarning, object: nil)
        }
        
        deinit {
            /// TODO: - 缓存样式
            NotificationCenter.default.removeObserver(self, name: .ThemeDidChange, object: nil)
            // NotificationCenter.default.removeObserver(self, name: .UIApplicationDidReceiveMemoryWarning, object: nil)
        }
        
        /// 按主题分类的主题样式集合，非懒加载。
        /// - Note: 更改主题样式集合会标记所有需要更新主题。
        public internal(set) var themedStylesIfLoaded: [Theme: Theme.Style.Collection]? {
            didSet {
                object?.setNeedsThemeAppearanceUpdate()
            }
        }
        
        /// 按主题分类的主题样式集合，懒加载。
        public internal(set) var themedStyles: [Theme: Theme.Style.Collection] {
            get {
                if let themedStyles = themedStylesIfLoaded {
                    return themedStyles
                }
                
                // TODO: - 判断 tmp 目录是否有缓存，如果有加载缓存，否则创建新的。
                
                themedStylesIfLoaded = [Theme: Theme.Style.Collection]()
                return themedStylesIfLoaded!
            }
            set {
                themedStylesIfLoaded = newValue
            }
        }
        
        /// 主题集不支持主题设置，改属性返回所有者的主题集，即其自身。
        public override var themes: Theme.Collection {
            return self
        }
        
        /// 主题集的主题标识符为其所有者的主题标识符。
        public override var themeIdentifier: Theme.Identifier? {
            get { return object?.themeIdentifier       }
            set { object?.themeIdentifier = newValue   }
        }
        
        /// 所有者是否已标记需要更新主题。
        public internal(set) override var needsUpdateThemeAppearance: Bool {
            get { return object?.needsUpdateThemeAppearance == true }
            set { object?.needsUpdateThemeAppearance = newValue     }
        }
        
        /// 所有者当前已应用的主题。
        public internal(set) override var appliedTheme: Theme? {
            get { return object?.appliedTheme     }
            set { object?.appliedTheme = newValue }
        }
        
        /// 标记所有者主题需要更新。
        public override func setNeedsThemeAppearanceUpdate() {
            object?.setNeedsThemeAppearanceUpdate()
        }
        
        /// 主题集不支持主题设置，所以该方法不执行任何操作。
        public override func updateThemeAppearanceIfNeeded() {
            XZLog("主题集不支持主题设置，updateThemeAppearanceIfNeeded 方法不执行任何操作。")
        }
        
        /// 主题集不支持主题设置，所以该方法不执行任何操作。
        public override func updateAppearance(with newTheme: Theme) {
            XZLog("主题集不支持主题设置，updateAppearance(with:) 方法不执行任何操作。")
        }
        
        /// 当发生内存警告时，Theme.Collection 将尝试将样式缓存到 tmp 目录，并释放相关资源。
        /// - Note: 目前该函数的功能没有实现。
        @objc public func didReceiveMemoryWarning() {
            /// 如果当前对象已销毁，则立即释放所有样式。
            guard let object = self.object else {
                self.themedStylesIfLoaded?.removeAll()
                return
            }
            /// 如果当前对象没有样式标识符，不缓存。待确定。
            
            /// 通过配置文件和代码配置的，毕竟有可能是混合用的。
            
            /// 没有样式，也就不需要释放了。
            guard let themedStyles = themedStylesIfLoaded else { return }
            
            /// 将样式转换成字典。
            var dictionary: [String: [String: [String: Any?]]] = [:]
            for themedStyle in themedStyles {
                var statedStyles = [String: [String: Any?]]()
                for statedStyle in themedStyle.value.statedThemeStyles {
                    var attributedValues = [String: Any?]()
                    for attributedValue in statedStyle.value.attributedValues {
                        attributedValues.updateValue(attributedValue.value, forKey: attributedValue.key.rawValue)
                    }
                    statedStyles[statedStyle.key.rawValue] = attributedValues
                }
                dictionary[themedStyle.key.name] = statedStyles
            }
            
            // TODO: - 将样式字典缓存到 tmp 目录。
            XZLog("缓存机制暂未实现：%@。", object)
        }
        
    }
    
    
    // MARK: - 定义：主题样式。
    
    /// 主题样式，用于存储主题外观样式属性以及属性值的对象。
    /// - Note: 使用 Array.init(themeStyles:) 可以取得所有已配置的属性。
    @objc(XZThemeStyle) public class Style: NSObject {
        
        /// 样式的所有者。
        @objc public private(set) weak var object: NSObject?
        
        /// 当前样式所属的主题。
        @objc public let theme: Theme
        
        /// 当前样式的主题状态。
        @objc public let state: Theme.State
        
        /// 构造主题样式。默认构造的为 normal 状态下的主题样式。
        ///
        /// - Parameters:
        ///   - object: 所有者。
        ///   - theme: 主题。
        ///   - state: 样式状态，默认 .normal 。
        @objc public init(object: NSObject?, theme: Theme, state: Theme.State = .normal) {
            self.theme  = theme
            self.object = object
            self.state  = state
            super.init()
        }
        
        /// 按属性存储的属性值，非懒加载。
        /// - Note: 更新样式属性值会标记所有者需要更新主题。
        public internal(set) var attributedValuesIfLoaded: [Theme.Attribute: Any?]? {
            didSet {
                object?.setNeedsThemeAppearanceUpdate()
            }
        }
        
        /// 按样式属性存储的属性值，懒加载。
        /// - Note: 更新样式属性值会标记所有者需要更新主题。
        public internal(set) var attributedValues: [Theme.Attribute: Any?] {
            get {
                if let attributedValues = self.attributedValuesIfLoaded {
                    return attributedValues
                }
                attributedValuesIfLoaded = [Theme.Attribute: Any?]()
                return attributedValuesIfLoaded!
            }
            set {
                attributedValuesIfLoaded = newValue
            }
        }
        
        
        // MARK: - 定义：主题样式集

        /// 主题样式集：同一主题下，按状态分类的所有主题样式集合。
        /// - Note: 使用 Array.init(_:Theme.Style.Collection) 可以取得所有状态。
        @objc(XZThemeStyleCollection) public final class Collection: Theme.Style {
            
            /// 构造主题样式集。主题样式集默认为 normal 状态，不能指定其它主题状态。
            ///
            /// - Parameters:
            ///   - object: 所有者。
            ///   - theme: 主题。
            @objc public init(object: NSObject?, theme: Theme) {
                super.init(object: object, theme: theme, state: .normal)
            }
            
            /// 按主题状态存储的主题样式集合，非懒加载。
            /// - Note: 会标记所有者需要更新主题。
            /// - Note: 该集合不包含 normal 状态的主题。
            /// - Note: 该集合不包含全局样式。
            public internal(set) var statedThemeStylesIfLoaded: [Theme.State: Theme.Style]? {
                didSet {
                    object?.setNeedsThemeAppearanceUpdate()
                }
            }
            
            /// 按主题状态存储的主题样式集合，懒加载。
            /// - Note: 会标记所有者需要更新主题。
            /// - Note: 该集合不包含 normal 状态的主题。
            /// - Note: 该集合不包含全局样式。
            public internal(set) var statedThemeStyles: [Theme.State: Theme.Style] {
                get {
                    if let statedStyles = self.statedThemeStylesIfLoaded {
                        return statedStyles
                    }
                    statedThemeStylesIfLoaded = [Theme.State: Theme.Style]()
                    return statedThemeStylesIfLoaded!
                }
                set {
                    statedThemeStylesIfLoaded = newValue
                }
            }
        }
    }
    
    
    // MARK: - 定义：主题属性。
    
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
    
    /// 主题样式状态。
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
    
    /// 主题标识符。
    /// - Note: 主题配置文件中的标识。
    /// - Note: 主题缓存所用。
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




