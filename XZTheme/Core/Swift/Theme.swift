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
    /// - Note: 视图控件 UIView 及其子类，无需监听通知，其会自动的在适当的时机应用主题。
    public static let ThemeDidChange = Notification.Name.init("com.mlibai.XZKit.theme.changed")
}

extension Theme {
    
    /// 应用主题动画时长，0.5 秒。
    @objc public static let AnimationDuration: TimeInterval = 0.5
    
    /// 在 UserDefaults 中记录当前主题所使用的 Key 。
    @objc public static let UserDefaultsKey: String = "com.mlibai.XZKit.theme.default"
    
    /// 当前主题的默认主题。
    /// - Note: 从没有应用过任何主题时默认主题。
    /// - Note: 在应用主题时，如果没有任何可以应用的主题样式，会读取此主题下配置的主题样式。
    /// - Note: 默认此主题没配置任何主题样式。
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
    
    /// 主题集，对象所支持的主题的集合。
    /// - Note: 在集合中，按主题进行分类存储所有的的主题样式。
    @objc(XZThemeCollection) public final class Collection: NSObject {
        
        /// 主题集的所有者。
        /// - Note: 这里使用了 weak 属性，是因为主题集与其所有者是值绑定的关系，生命周期可能比所有者略长。
        @objc public private(set) weak var object: NSObject?
        
        /// 父级主题集。不带标识符的全局主题集，是带标识符的全局主题集父集；全局主题集是实例对象主题集的父集。
        /// - Note: 在应用主题时，父主题集的样式会被子主题集中相同的样式所覆盖。
        public var superThemes: Theme.Collection? {
            guard let object = self.object else { return _superThemes }
            return type(of: object).effectiveThemes(forThemeIdentifier: themeIdentifier)
        }
        private weak var _superThemes: Theme.Collection?
        
        /// 实例对象构造主题集。
        ///
        /// - Parameter object: 实例对象。
        @objc public convenience init(object: NSObject) {
            self.init(object, superThemes: nil)
        }
        
        /// 类对象构造全局主题集，如果是带标识符的主题，需指定父主题集。
        ///
        /// - Parameter superThemes: 父主题集。
        @objc public convenience init(superThemes: Theme.Collection?) {
            self.init(nil, superThemes: superThemes)
        }
        
        /// 私有方法，构造主题集，两参数不能同时提供。
        private init(_ object: NSObject?, superThemes: Theme.Collection?) {
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
        
        /// 将主题集设置为当前主题集的子级。
        ///
        /// - Parameter themes: 子级主题集。
        @objc public func addSubthemes(_ themes: Theme.Collection) {
            themes._superThemes = self
        }
        
        /// 按主题分类的主题样式集合，非懒加载。
        /// - Note: 更改主题样式集合会标记所有需要更新主题。
        @objc public internal(set) var themedStylesIfLoaded: [Theme: Theme.Style.Collection]? {
            didSet {
                object?.setNeedsThemeAppearanceUpdate()
            }
        }
        
        /// 按主题分类的主题样式集合，懒加载。
        @objc public internal(set) var themedStyles: [Theme: Theme.Style.Collection] {
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
        
        /// 主题集不支持主题设置，改属性返回所有者的主题集，即当前对象。
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
            fatalError("Theme.Collection.didReceiveMemoryWarning() has not been implemented")
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
                guard let statedThemeStyles = themedStyle.value.statedThemeStylesIfLoaded else { continue }
                var statedStyles = [String: [String: Any?]]()
                for statedStyle in statedThemeStyles {
                    guard let attributedValues = statedStyle.value.attributedValuesIfLoaded else { continue }
                    var values = [String: Any?]()
                    for attributedValue in attributedValues {
                        values.updateValue(attributedValue.value, forKey: attributedValue.key.rawValue)
                    }
                    statedStyles[statedStyle.key.rawValue] = values
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
        
        /// 主题样式所表示的主题。
        @objc public let theme: Theme
        
        /// 当前样式的主题状态。
        @objc public let state: Theme.State
        
        /// 主题样式所在的主题集。
        public override var themes: Theme.Collection {
            return _themes
        }
        private unowned let _themes: Theme.Collection
        
        /// 构造主题样式。默认构造的为 normal 状态下的主题样式。
        ///
        /// - Parameters:
        ///   - object: 所有者。
        ///   - themes: 主题集。
        ///   - theme: 主题。
        ///   - state: 主题状态，默认 .normal 。
        @objc public init(object: NSObject?, themes: Theme.Collection, theme: Theme, state: Theme.State = .normal) {
            self.theme  = theme
            self.object = object
            self.state  = state
            self._themes = themes
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

        /// 主题样式集：同一主题下，按状态分类的所有主题样式集合。同时，主题样式集也是 .normal 主题状态的主题样式。
        @objc(XZThemeStyleCollection) public final class Collection: Theme.Style {
            
            /// 构造主题样式集。主题样式集默认为 normal 状态，不能指定其它主题状态。
            ///
            /// - Parameters:
            ///   - object: 样式集的所有者。
            ///   - themes: 样式集所在的主题集。
            ///   - theme: 主题。
            @objc public init(object: NSObject?, themes: Theme.Collection, theme: Theme) {
                super.init(object: object, themes: themes, theme: theme, state: .normal)
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
    /// - Note: 主题状态一般情况下与触控状态相对应。
    /// - Note: 主题状态名必须符合正则 /^\:[A-Za-z]+$/ 。
    /// - Note: 主题状态可能是集合，用于设置多状态。比如 `UINavigationBar` 设置 `.backgroundImage` 属性。
    /// ```
    /// .setValue(
    ///     "bg_bar_nav",
    ///     forThemeAttribute: .backgroundImage,
    ///     forThemeState: .defaultBarMetrics
    /// )
    /// .setValue(
    ///     "bg_bar_nav",
    ///     forThemeAttribute: .backgroundImage,
    ///     forThemeState: [.anyBarPosition, .compactBarMetrics]
    /// )
    /// ```
    /// - Note: Theme.State 是有序数组，所以 `[.state1, .state2]` 与 `[.state2, .state1]` 是不同的主题状态。
    /// - Note: 可以中 for-in 语句来遍历主题状态中的所有基本元素。
    public struct State: RawRepresentable, ExpressibleByArrayLiteral, CustomStringConvertible, Sequence, IteratorProtocol {
        
        public typealias RawValue = String
        
        /// 特殊值，正常状态，没有状态描述时的状态。在触控状态中，与 UIControlState.normal 相对应。
        /// - Note: 基本状态、空状态。
        /// - Note: 任何状态与 `normal` 状态组成的复合状态与其自身相等。例如 `[.normal, .selected]` 与 `:selected` 相等，但是前者为复合状态，后者为基本状态。
        public static let normal = Theme.State.init(rawValue: "", children: [])
        
        /// 主题状态原始值，比较主题状态是否相等的依据。
        public let rawValue: String
        
        /// 基本主题状态没有子元素，复合状态子元素为复合状态或基本状态。
        public let children: [State]
        
        /// 只有主题状态 Theme.State.normal 此属性为 true 。
        public var isEmpty: Bool {
            return self == Theme.State.normal
        }
        
       /// 是否为基本主题状态。
        public var isPrimary: Bool {
            return children.isEmpty;
        }
        
        /// 主题状态默认描述文本格式为：Theme.State(:selected)
        public var description: String {
            if rawValue.isEmpty {
                return "Theme.State(:normal)"
            }
            return "Theme.State(\(rawValue))"
        }
        
        /// 检查状态是否符合要求的正则。
        private static let regularExpression = try! NSRegularExpression(pattern: "^\\:[A-Za-z]+$", options: .none)
        
        /// 基本主题状态构造方法，字符串格式必须符合格式：`/^\:[A-Za-z]+$` 。
        /// - Note: 字符串 `":normal"` 被作为创建 .normal 状态特殊值处理。
        ///
        /// - Parameter rawValue: 主题状态原始值。
        public init(rawValue: String) {
            let range = NSMakeRange(0, rawValue.count)
            guard NSEqualRanges(range, State.regularExpression.rangeOfFirstMatch(in: rawValue, options: .none, range: range)) else {
                fatalError("The `\(rawValue)` is not an valid state rawValue, which must be matched the regular expression /^\\:[A-Za-z]+$/ .")
            }
            if rawValue == ":normal" {
                self = .normal
            } else {
                self.rawValue = rawValue
                self.children = []
            }
        }
        
        
        /// 判断两个主题状态是否完全相等，原始值相等，且都为基本状态或复合状态。
        ///
        /// - Parameters:
        ///   - lhs: 主题状态。
        ///   - rhs: 主题状态。
        /// - Returns: 主题状态是否全等。
        public static func ===(lhs: Theme.State, rhs: Theme.State) -> Bool {
            return lhs.rawValue == rhs.rawValue && lhs.isPrimary == rhs.isPrimary
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
                /// 空数组不会创建新的状态。
                self = .normal
            default:
                // 如果元素是由复合元素构成的，则 rawValue 用 [] 包裹。
                // 那么 rawValue 形式可能有以下几种形式：
                // 1. 基本状态 :selected
                // 2. 基本状态的复合 [:selected:highlighted]
                // 3. 基本状态与复合状态的复合 [[:selected:highlighted]:focused]
                // 4. 复合状态与复合状态的复合 [[:selected:highlighted][:selected:focused]]
                // 5. 复合状态的复合 [[:selected:highlighted]]
                // 6. 多重复合 [[[:selected:highlighted]:focused]:disabled]
                let rawValue = elements.map({ (element) -> String in
                    element.rawValue
                }).joined()
                self.init(rawValue: "[\(rawValue)]", children: elements)
            }
        }
        
        public typealias ArrayLiteralElement = Theme.State
        
        public init(arrayLiteral elements: Theme.State...) {
            self.init(elements)
        }
        
        /// 指定初始化方法。私有构造方法，避免构造出不合法的主题状态。
        private init(rawValue: String, children: [State]) {
            self.rawValue = rawValue;
            self.children = children
        }
        
        /// 遍历主题状态中的所有基本元素，遍历顺序为正序。
        ///
        /// - Returns: 剩余未遍历的主题状态。
        public mutating func next() -> Theme.State? {
            // 空状态
            if self.isEmpty {
                return nil
            }
            // 基本状态
            if self.isPrimary {
                let state = self
                self = .normal
                return state
            }
            // 复合状态
            // 复合状态在遍历的过程中，原始值不变，只改变其 children
            // 如果 children 变为一个了，则停止遍历。
            let state = children[0]
            self = children.count == 1 ? .normal : Theme.State.init(rawValue: rawValue, children: Array.init(children.suffix(from: 1)))
            return state
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




