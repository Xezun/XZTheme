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
    
    /// 当主题发生改变时，发送 Notification 所使用的名称。
    /// - Note: 视图及视图控制器 UIView/UIViewController 及其子类，无需监听通知，其会自动的在适当的时机应用主题。
    public static let ThemeDidChange = Notification.Name.init("com.mlibai.XZKit.theme.changed")
    
}

extension Theme {
    
    /// 默认主题，缺省主题。
    /// - Note: 在应用主题时，如果没有任何可以应用的主题样式，会读取此主题下配置的主题样式。
    @objc(defaultTheme)
    public static let `default`: Theme = Theme.init(name: "default")
    
    /// 当前主题，最后一次应用过的主题。
    ///
    /// - Note: 如果从未应用过主题，则为 Theme.default 。
    /// - Note: 应用主题，请主题对象的 `apply(animated:)` 方法。
    @objc(currentTheme)
    public private(set) static var current: Theme = {
        if let themeName = UserDefaults.standard.string(forKey: Theme.UserDefaultsKey) {
            return Theme.init(name: themeName)
        }
        return Theme.default
    }()
    
    /// 应用主题。
    /// - Note: 该方法会自动记录当前应用的主题。
    /// - Note: 应用主题会向所有 UIApplication.sharedApplication.windows 和根控制器发送主题事件。
    /// - Note: 视图控件或视图控制器，默认会向其子视图或自控制器以及相关联的对象发送事件。
    /// - Note: 没有正在显示的视图，会在显示（添加到父视图）时，根据自身主题和当前主题判断是否需要更新主题外观。
    /// - Note: 控制器也会在其将要显示时，判断主题从而决定是否更新主题外观。
    ///
    /// - Parameter animated: 是否渐变主题应用的过程。
    @objc(applyThemeAnimated:)
    public func apply(animated: Bool) {
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
    
    /// 应用主题动画时长，0.5 秒。
    @objc public static let AnimationDuration: TimeInterval = 0.5
    
    /// 在 UserDefaults 中记录当前主题所使用的 Key 。
    @objc public static let UserDefaultsKey: String = "com.mlibai.XZKit.theme.default"
    
}

// MARK: - 定义

/// 主题。
///
/// 主题相关类有以下基本命名规则：
/// - 主题，类名 `Theme` ，在属性、变量、方法中命名为 `theme` 。
/// - 主题集，类名 `Theme.Collection` ，在属性、变量、方法中命名为 `themes` 。
/// - 主题样式，类名 `Theme.Style` ，在属性、变量、方法中命名为 `themeStyle` 。
/// - 主题样式集，类名 `Theme.Style.Collection` ，在属性、变量、方法中命名为 `themeStyles` 。
/// - 主题属性，类名 `Theme.Attribute` ，在属性、变量、方法中命名为 `themeAttribute` 。
/// - 主题状态，类名 `Theme.State` ，在属性、变量、方法中命名为 `themeState` 。
/// - 主题标识符，类名 `Theme.Identifier` ，在属性、变量、方法中命名为 `themeIdentifier` 。
@objc(XZTheme)
public final class Theme: NSObject {

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
    
    public override var description: String {
        return name
    }
    
    // MARK: - 定义：主题集
    
    /// 主题集，对象所支持的主题的集合，包括实例对象的主题集和全局主题集。
    /// - Note: 在集合中，按主题进行分类存储所有的的主题样式。
    @objc(XZThemeCollection)
    public final class Collection: NSObject {
        
        /// 实例对象构造主题集。
        ///
        /// - Parameter object: 实例对象。
        @objc public convenience init(for object: NSObject) {
            self.init(for: object, themeIdentifier: .notAnIdentifier, isGlobal: false)
        }
        
        ///  类对象构造全局主题集，如果是带标识符的主题，需指定父主题集。
        ///
        /// - Parameters:
        ///   - object: 主题集的所有者。
        ///   - themeIdentifier: 主题集适配的标识符。
        @objc public convenience init(for object: NSObject.Type, themeIdentifier: Theme.Identifier) {
            self.init(for: object, themeIdentifier: themeIdentifier, isGlobal: true)
        }
        
        /// 主题集的所有者。
        /// - Note: 应该避免在对象生命周期之外调用其主题相关对象。
        /// - ToDo: 主题集与其所有者是值绑定的关系，生命周期可能比所有者略长，使用了 unowned 是否会引发问题，待验证。
        @objc public unowned let object: AnyObject
        
        /// 当前主题集是否为全局主题集。
        open var isGlobal: Bool

        /// 构造主题集。
        ///
        /// - Parameters:
        ///   - object: 主题集的所有者，对象或类。
        ///   - themeIdentifier: 主题标识符。
        ///   - isGlobal: 所有者是否为实例对象。
        private init(for object: AnyObject, themeIdentifier: Theme.Identifier, isGlobal: Bool) {
            self.object   = object
            self.isGlobal = isGlobal
            super.init()
            super.themeIdentifier = themeIdentifier
            
            // 如果主题集拥有所有者，则尝试自动主题管理，以及缓存相关的操作。
            // guard self.isGlobal else {
            //     return
            // }
            // if (self.object as! NSObject).shouldAutomaticallyUpdateThemeAppearance {
            //     NotificationCenter.default.addObserver(self, selector: #selector(setNeedsThemeAppearanceUpdate), name: .ThemeDidChange, object: nil)
            // }
            
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
        
        /// 自动应用所有者的主题，全局主题集此方法无效。
        /// - Note: 除非需要及时响应主题变更事件，否则一般情况下，对于 UIView、UIViewController 对象及子类对象无须调用此方法，因为其主题会在适当的时机自动应用。
        @objc public func setAutomaticallyUpdateThemeAppearance() {
            if isGlobal {
                return
            }
            NotificationCenter.default.addObserver(self, selector: #selector(setNeedsThemeAppearanceUpdate), name: .ThemeDidChange, object: nil)
        }
        
        /// 按主题分类的主题样式集合，非懒加载。
        /// - Note: 更改主题样式集合会标记所有需要更新主题。
        @objc public private(set) var themedStylesIfLoaded: [Theme: Theme.Style.Collection]? {
            didSet {
                if isGlobal {
                    return
                }
                (object as! NSObject).setNeedsThemeAppearanceUpdate()
            }
        }
        
        /// 按主题分类的主题样式集合，懒加载。
        @objc public private(set) var themedStyles: [Theme: Theme.Style.Collection] {
            get {
                if themedStylesIfLoaded != nil {
                    return themedStylesIfLoaded!
                }
                // TODO: - 判断 tmp 目录是否有缓存，如果有加载缓存，否则创建新的。
                themedStylesIfLoaded = [Theme: Theme.Style.Collection]()
                return themedStylesIfLoaded!
            }
            set {
                themedStylesIfLoaded = newValue
            }
        }
    }
    
    
    // MARK: - 定义：主题样式。
    
    /// 主题样式，用于存储主题外观样式属性以及属性值的对象。
    /// - Note: 使用 Array.init(themeStyles:) 可以取得所有已配置的属性。
    @objc(XZThemeStyle) public class Style: NSObject {
        
        /// 样式所在的主题集。
        private unowned let owner: Theme.Collection
        
        /// 主题样式所表示的主题。
        @objc public let theme: Theme
        
        /// 当前样式的主题状态。
        public let state: Theme.State
        
        /// 主题样式的主题集为其所有者。
        public override var themes: Theme.Collection {
            return owner
        }
        
        /// 构造主题样式。默认构造的为 normal 状态下的主题样式。
        ///
        /// - Parameters:
        ///   - themes: 主题集。
        ///   - theme: 主题。
        ///   - state: 主题状态，默认 .normal 。
        public init(themes: Theme.Collection, theme: Theme, state: Theme.State = .normal) {
            self.theme = theme
            self.owner = themes
            self.state = state
            super.init()
        }
        
        /// 按属性存储的属性值，非懒加载。
        /// - Note: 更新样式属性值会标记所有者需要更新主题。
        public internal(set) var attributedValuesIfLoaded: [Theme.Attribute: Any?]? {
            didSet {
                themes.setNeedsThemeAppearanceUpdate()
            }
        }
        
        /// 按样式属性存储的属性值，懒加载。
        /// - Note: 更新样式属性值会标记所有者需要更新主题。
        public internal(set) var attributedValues: [Theme.Attribute: Any?] {
            get {
                if attributedValuesIfLoaded != nil {
                    return attributedValuesIfLoaded!
                }
                attributedValuesIfLoaded = [Theme.Attribute: Any?]()
                return attributedValuesIfLoaded!
            }
            set {
                attributedValuesIfLoaded = newValue
            }
        }
        
        
        // MARK: - 定义：主题样式集

        /// 主题样式集：同一主题下，按状态分类的所有主题样式集合。同时，主题样式集也是 .normal 主题状态的主题样式。
        @objc(XZThemeStyleCollection)
        public final class Collection: Theme.Style {
            
            /// 构造主题样式集。主题样式集默认为 normal 状态，不能指定其它主题状态。
            ///
            /// - Parameters:
            ///   - themes: 样式集的所有者。
            ///   - theme: 主题。
            @objc public init(themes: Theme.Collection, theme: Theme) {
                super.init(themes: themes, theme: theme, state: .normal)
            }
            
            /// 按主题状态存储的主题样式集合，非懒加载。
            /// - Note: 会标记所有者需要更新主题。
            /// - Note: 该集合不包含 normal 状态的主题。
            /// - Note: 该集合不包含全局样式。
            public internal(set) var statedThemeStylesIfLoaded: [Theme.State: Theme.Style]? {
                didSet {
                    themes.setNeedsThemeAppearanceUpdate()
                }
            }
            
            /// 按主题状态存储的主题样式集合，懒加载。
            /// - Note: 会标记所有者需要更新主题。
            /// - Note: 该集合不包含 normal 状态的主题。
            /// - Note: 该集合不包含全局样式。
            public internal(set) var statedThemeStyles: [Theme.State: Theme.Style] {
                get {
                    if statedThemeStylesIfLoaded != nil {
                        return statedThemeStylesIfLoaded!
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
    
    /// 主题属性。
    /// - Note: 主题属性一般情况下与对象的外观属性相对应。
    /// - Note: 主题属性名应该符合正则 /^[A-Za-z_][A-Za-z0-9_]+$/ 。
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
    
    /// 主题状态。
    /// - Note: 主题状态是为了解决主题属性的多状态值而设立的。
    /// - Note: 主题状态名必须符合正则表达式 /^\:[A-Za-z]+$/ 。
    /// - Note: 一个或多个基本主题状态，通过数组的方式可以组合成复合主题状态。
    /// - Note: 复合状态用于解决主题属性同时具有不同类型的状态值。
    /// - Note: 复合状态是有序的，比如 `[.state1, .state2]` 与 `[.state2, .state1]` 是不同的主题状态。
    /// - Note: 可以使用 for-in 语句来遍历主题状态中的所有子元素。
    public struct State: ExpressibleByArrayLiteral, CustomStringConvertible, Sequence, IteratorProtocol {
        
        /// 特殊值，表示不区分主题状态时的状态。
        public static let None = Theme.State.init(name: "", rawValue: "None", rawType: String.self, isOptionSet: false, children: [])
        
        /// 是否为 Theme.State.Empty 。
        public var isEmpty: Bool {
            return self == .None
        }
        
        /// 主题状态名。
        public let name: String
        
        /// 主题状态原始值，复合状态原始值为 0 。
        public let rawValue: Any
        
        /// 原始类型。
        public let rawType: Any.Type
        
        /// 复合状态的子状态，子状态也可能是复合状态。
        public let children: [State]
        
        /// 主题状态的原始值，是否为 OptionSet 类型，用于优化性能。
        /// - Note: 相同 OptionSet 类型的基本主题状态组成的复合状态，此属性为 true 。
        public let isOptionSet: Bool
        
        /// 是否为基本主题状态。
        public var isPrimary: Bool {
            return children.isEmpty
        }
       
        /// 主题状态默认描述文本格式为：Theme.State(:selected)
        public var description: String {
            if self.isEmpty {
                return "Theme.State.None"
            }
            return "Theme.State(\(name))"
        }
        
        /// 检查状态是否符合要求的正则。
        private static let regularExpression = try! NSRegularExpression(pattern: "^\\:[A-Za-z]+$", options: .none)
        
        /// 基本主题状态构造方法，主题状态名必须符合正则表达式：`/^\:[A-Za-z]+$/` 。
        ///
        /// - Parameters:
        ///     - name: 主题状态名。
        ///     - rawValue: 主题状态原始值。
        ///     - rawType: 主题状态原始类型。
        ///     - isOptionSet: 原始类型是否为 OptionSet 类型。
        public init<T>(name: String, rawValue: T, rawType: T.Type = T.self, isOptionSet: Bool = false) {
            let range = NSMakeRange(0, name.count)
            guard NSEqualRanges(range, State.regularExpression.rangeOfFirstMatch(in: name, options: .none, range: range)) else {
                fatalError("The `\(rawValue)` is not an valid state rawValue, which must be matched the regular expression /^\\:[A-Za-z]+$/ .")
            }
            self.init(name: name, rawValue: rawValue, rawType: rawType, isOptionSet: isOptionSet, children: [])
        }
        
        /// 将主题状态集合转换复合主题状态。
        /// - Note: 空数组将获得 .normal 状态。
        /// - Note: 单个元素也可以复合，且与原来不相等。
        /// - Note: 任何状态与 .normal 复合等于对其自身进行复合。
        /// ```
        /// let state1: Theme.State = .highlighted
        /// let state2: Theme.State = [.normal, .highlighted]
        /// print(state1 == state2) // prints true
        /// print(state1 === state2) // prints false
        /// ```
        /// - Note: 复合状态可以再次被复合成新的复合状态，且与原来不相等。
        ///
        /// - Parameter rawValue: 主题状态原始值。
        public init(_ elements: Array<Theme.State>) {
            switch elements.count {
            case 0:
                self = .None
            default:
                var isOptionSet = true
                var rawType: Any.Type! = nil
                var rawValue: [Any] = []
                let name = elements.map({ (element) -> String in
                    // 只要数组存在非 OptionSet 元素或存在两个不同的 OptionSet 类型，那么复合状态就不是 OptionSet
                    if isOptionSet {
                        if rawType == nil { // first loop
                            rawType = element.rawType
                            isOptionSet = element.isOptionSet
                        } else {
                            // 如果有元素是非 OptionSet 或者存在两种不同的类型 或者非基本状态，则复合状态不是 OptionSet 。
                            if !element.isOptionSet || rawType != element.rawType || !element.isPrimary {
                                isOptionSet = false
                                rawType = Any.self
                            }
                        }
                    }
                    // 复合状态的原始值是子元素原始值的数组。
                    rawValue.append(element.rawValue)
                    // 如果元素是复合元素，用 [] 包裹它。
                    if element.children.count > 0 {
                        return "[\(element.name)]"
                    }
                    // 否则直接使用元素名。
                    return element.name
                }).joined()
                self.init(name: name, rawValue: rawValue, rawType: rawType, isOptionSet: isOptionSet, children: elements)
            }
        }
        
        public typealias ArrayLiteralElement = Theme.State
        
        public init(arrayLiteral elements: Theme.State...) {
            self.init(elements)
        }
        
        /// 指定初始化方法。私有构造方法，避免构造出不合法的主题状态。
        private init(name: String, rawValue: Any, rawType: Any.Type, isOptionSet: Bool = false, children: [State] = []) {
            self.name       = name
            self.rawValue   = rawValue
            self.rawType    = rawType
            self.isOptionSet = isOptionSet
            self.children   = children
        }
        
        /// 遍历主题状态中的所有基本元素，遍历顺序为正序。
        ///
        /// - Returns: 剩余未遍历的主题状态。
        public mutating func next() -> Theme.State? {
            // 遍历的终点
            if self.isEmpty {
                return nil
            }
            // 复合状态
            // 复合状态在遍历的过程中，原始值不变，只改变其 children
            // 如果 children 变为一个了，则停止遍历。
            switch children.count {
            case 0:     // 基本状态
                let state = self
                self = .None
                return state
            case 1:
                let state = children[0]
                self = .None
                return state
            default:
                let state = children[0]
                // 这里会产生一个不合法的状态
                self = Theme.State.init(
                    name:           name,
                    rawValue:       rawValue,
                    rawType:        rawType,
                    isOptionSet:    isOptionSet,
                    children:       Array.init(children.suffix(from: 1))
                )
                return state
            }
            
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
            return self.name == theme.name
        }
        return false
    }
    
}



extension Theme.Collection {
    
    /// 获取默认主题的样式的快捷方法。
    /// - Note: 该方法等同于调用 themeStyle(forTheme:) 方法。
    /// - Note: 建议给自定义主题添加类似的访问方法。
    /// ```
    /// let view = UIView()
    /// // 设置 default 主题的样式。
    /// view.themes.default.backgroundColor = .white
    /// ```
    /// ```
    /// // 自定义主题
    /// extension Theme {
    ///     /// 夜间主题
    ///     static let night = Theme.init(name: "night")
    /// }
    /// // 便利访问方式
    /// extension Theme.Colletion {
    ///     var day: Theme.Style.Collection {
    ///         return themeStyles(forTheme: .night)
    ///     }
    /// }
    /// ```
    public var `default`: Theme.Style.Collection {
        return themeStyles(forTheme: .default)
    }
    
}

extension Theme.Collection {
    
    /// 对于主题集对象，如果是全局主题集，其主题标识符表示该全局主题集指定了标识符，而对于对象主题集，此属性始终是 .notAnIdentifier 。
    /// - Important: 不可以尝试更改此属性。
    public override var themeIdentifier: Theme.Identifier! {
        get { return super.themeIdentifier }
        set { fatalError("Theme.Collection's themeIdentifier property can not be modified.") }
    }
    
    /// 当前主题集的父集。
    /// - Note: 类型的 *全局主题集* 是 *实例对象的主题集* 的父集。
    /// - Note: 同一类型 *不带标识符的全局主题集* 是 *带标识符的全局主题集* 的父集。
    /// - Note: *父类的不带标识符全局主题集* 是 *子类的全局主题集* 的父集，即父类带标识符的主题集，不会传播到子类。
    /// - Note: 获取父集时，会逐层向上查找，直至找到或结束。
    /// - Note: 在应用主题时，父主题集的样式会被子主题集中相同的样式所覆盖。
    public var superThemes: Theme.Collection? {
        // 对类进行 is AnyObject 判断会触发错误，所以用了 isGlobal 来标示类与对象。
        
        // 如果所有者为对象，则返回全局主题集。
        guard isGlobal else {
            return (type(of: object) as! NSObject.Type).effectiveThemes(forThemeIdentifier: self.themeIdentifier)
        }
        
        // 所有者为类，根据主题标识符来判断。
        // 所有者的类型。
        let objectType = self.object as! NSObject.Type
        
        // 带标识符的全局主题集的父集是不带标识符的全局主题集；不带标识符的全局主题集的父集是父类的不带标识符的全局主题集。
        
        if self.themeIdentifier != .notAnIdentifier {
            // 当前主题集为带标识符的主题集。
            if let superThemes = objectType.themesIfLoaded {
                // 那么获取 不带标识符的主题 作为其父集。
                return superThemes
            }
            // 没有 不带标识符的全局主题集，那么根据 标识符查找父类的 全局主题集（带标识符或不带标识符）。
        }
        // 当前主题集为不带标识符的主题集，查找父类不带标识符的主题集。
        
        guard let ownerSuperType = class_getSuperclass(objectType) as? NSObject.Type else {
            return nil
        }
        return ownerSuperType.effectiveThemes(forThemeIdentifier: self.themeIdentifier)
    }
    
    
    
    @objc public func containsThemeStyle(for theme: Theme) -> Bool {
        return themedStylesIfLoaded?.contains(where: { $0.key == theme }) == true
    }
    
    
    
    /// 主题集不支持主题设置，改属性返回所有者的主题集，即当前对象。
    public override var themes: Theme.Collection {
        return self
    }
    
    /// 所有者是否已标记需要更新主题。
    public internal(set) override var needsUpdateThemeAppearance: Bool {
        get { fatalError("Theme Theme.Collection dose not support Theme.") }
        set { fatalError("Theme Theme.Collection dose not support Theme.") }
    }
    
    /// 所有者当前已应用的主题。
    public internal(set) override var appliedTheme: Theme? {
        get { fatalError("Theme Theme.Collection dose not support Theme.") }
        set { fatalError("Theme Theme.Collection dose not support Theme.") }
    }
    
    /// 标记所有者主题需要更新。
    public override func setNeedsThemeAppearanceUpdate() {
        if isGlobal {
            return
        }
        (object as! NSObject).setNeedsThemeAppearanceUpdate()
    }
    
    /// 主题集不支持主题设置，所以该方法不执行任何操作。
    public override func updateThemeAppearanceIfNeeded() {
        fatalError("Theme Theme.Collection dose not support Theme.")
    }
    
    /// 主题集不支持主题设置，所以该方法不执行任何操作。
    public override func updateAppearance(with newTheme: Theme) {
        fatalError("Theme Theme.Collection dose not support Theme.")
    }
    
    /// 当发生内存警告时，Theme.Collection 将尝试将样式缓存到 tmp 目录，并释放相关资源。
    /// - Note: 目前该函数的功能没有实现。
    @objc public func didReceiveMemoryWarning() {
        /// 如果当前对象没有样式标识符，不缓存。待确定。
        
        /// 通过配置文件和代码配置的，毕竟有可能是混合用的。
        
        /// 没有样式，也就不需要释放了。
        
        /// 将样式转换成字典。
        
        // TODO: - 将样式字典缓存到 tmp 目录。
    }
    
    /// 获取已设置的主题样式（如果有）。
    ///
    /// - Parameter theme: 主题。
    /// - Returns: 主题样式集合。
    @objc public func themeStylesIfLoaded(forTheme theme: Theme) -> Theme.Style.Collection? {
        return themedStylesIfLoaded?[theme]
    }
    
    /// 获取已设置的主题样式，如果主题对应的样式不存在，则会自动创建。
    ///
    /// - Parameter theme: 主题。
    /// - Returns: 主题样式。
    @objc public func themeStyles(forTheme theme: Theme) -> Theme.Style.Collection {
        if let themeStyles = themedStylesIfLoaded?[theme] {
            return themeStyles
        }
        let themeStyles = Theme.Style.Collection.init(themes: self, theme: theme)
        setThemeStyles(themeStyles, forTheme: theme)
        return themeStyles
    }
    
    /// 设置主题样式。
    ///
    /// - Parameter themeStyles: 主题样式。
    /// - Parameter theme: 主题。
    @objc public func setThemeStyles(_ themeStyles: Theme.Style.Collection, forTheme theme: Theme) {
        self.themedStyles[theme] = themeStyles
    }
    
    /// 当前生效的主题样式集。如果所有者没有配置主题样式集，则返回全局主题样式集（如果有）。
    ///
    /// - Parameter theme: 主题。
    /// - Returns: 主题样式集。
    @objc public func effectiveThemeStyles(forTheme theme: Theme) -> Theme.Style.Collection? {
        if let themeStyles = themeStylesIfLoaded(forTheme: theme) {
            return themeStyles
        }
        var superThemes: Theme.Collection! = self.superThemes
        
        while superThemes != nil {
            if let themeStyles = superThemes.themeStylesIfLoaded(forTheme: theme) {
                return themeStyles
            }
            superThemes = superThemes.superThemes
        }
        
        return nil
    }
    
}

