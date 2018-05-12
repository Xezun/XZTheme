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
    
    // MARK: - 组件
    
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
                NotificationCenter.default.addObserver(self, selector: #selector(setNeedsThemeAppearanceUpdate), name: .ThemeDidChange, object: nil)
            }
            
            // TODO: - 判断是否有配置文件。如果有读取配置文件，并记录。
            
            NotificationCenter.default.addObserver(self, selector: #selector(didReceiveMemoryWarning), name: .UIApplicationDidReceiveMemoryWarning, object: nil)
        }
        deinit {
            NotificationCenter.default.removeObserver(self, name: .ThemeDidChange, object: nil)
            NotificationCenter.default.removeObserver(self, name: .UIApplicationDidReceiveMemoryWarning, object: nil)
        }
        
        /// 按主题分类的主题样式集合。
        public private(set) var themedStylesIfLoaded: [Theme: Theme.Style.Collection]?
        
        public var themedStyles: [Theme: Theme.Style.Collection] {
            if let themedStyles = themedStylesIfLoaded {
                return themedStyles
            }
            
            // TODO: - 判断 tmp 目录是否有缓存，如果有加载缓存，否则创建新的。
    
            themedStylesIfLoaded = [Theme: Theme.Style.Collection]()
            return themedStylesIfLoaded!
        }
        
        private var _themeIdentifier: Theme.Identifier?
        private var _appliedTheme: Theme?
        private var _needsUpdateThemeAppearance: Bool = false
        
        /// Theme.Collection 的主题集合是其自身。
        public override var themes: Theme.Collection {
            return self;
        }
        
        /// Theme.Collection 的主题标识符为其所有者的主题标识符。
        public override var themeIdentifier: Theme.Identifier? {
            get { return _themeIdentifier       }
            set { _themeIdentifier = newValue   }
        }
        
        /// 始终返回 false 。
        public internal(set) override var needsUpdateThemeAppearance: Bool {
            get { return _needsUpdateThemeAppearance     }
            set { _needsUpdateThemeAppearance = newValue }
        }
        
        /// 所有者当前已应用的主题。
        public internal(set) override var appliedTheme: Theme? {
            get { return _appliedTheme      }
            set { _appliedTheme = newValue  }
        }
        
        /// 标记所有者主题需要更新。
        public override func setNeedsThemeAppearanceUpdate() {
            object?.setNeedsThemeAppearanceUpdate()
        }
        
        /// Theme.Collection 自身不支持主题，所以该方法不执行任何操作。
        public override func updateThemeAppearanceIfNeeded() {
            
        }
        
        /// Theme.Collection 自身不支持主题，所以该方法不执行任何操作。
        public override func updateAppearance(with newTheme: Theme) {
            
        }
        
        /// 当发生内存警告时，Theme.Collection 将尝试将样式缓存到 tmp 目录，并释放相关资源。
        @objc public func didReceiveMemoryWarning() {
            /// 如果当前对象已销毁，则立即释放所有样式。
            guard let object = self.object else {
                themedStylesIfLoaded?.removeAll()
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
                for statedStyle in themedStyle.value.statedStyles {
                    var attributedValues = [String: Any?]()
                    for attributedValue in statedStyle.value.attributedValues {
                        attributedValues.updateValue(attributedValue.value, forKey: attributedValue.key.rawValue)
                    }
                    statedStyles[statedStyle.key.rawValue] = attributedValues
                }
                dictionary[themedStyle.key.name] = statedStyles
            }
            
            // TODO: - 将样式字典缓存到 tmp 目录。
            
        }
        
    }
    
    /// 主题样式，负责存储主题属性。
    /// - Note: 使用 Array.init(_:Theme.Style) 可以取得所有已配置的属性。
    @objc(XZThemeStyle) public class Style: NSObject {
        /// 样式所属的主题集合。
        @objc public unowned let collection: Theme.Collection
        @objc public init(_ collection: Theme.Collection) {
            self.collection = collection
            super.init()
        }
        /// 按样式属性存储的属性值。
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




