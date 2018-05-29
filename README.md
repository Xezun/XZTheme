# XZTheme

[![CI Status](https://img.shields.io/badge/build-pass-brightgreen.svg)](https://cocoapods.org/pods/XZTheme)
[![Version](https://img.shields.io/badge/Pod-0.1.0-blue.svg?style=flat)](http://cocoapods.org/pods/XZTheme)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](http://cocoapods.org/pods/XZTheme)
[![Platform](https://img.shields.io/badge/Platform-iOS-yellow.svg)](http://cocoapods.org/pods/XZTheme)
[![Language](https://img.shields.io/badge/Swift-4.0-red.svg)](http://cocoapods.org/pods/XZTheme)

>   XZTheme 是 XZKit 组件，该组件的主要目的是为 iOS App 提供统一的主题管理机制。
>   组件目前处于持续开发过程中，但是目前核心部分已经完毕，能满足大部分需求，可以正常使用。

为了让 App 适应更多的人群、适应场景，为 App 设计合适的主题，越来越被开发者们重视，但是对于 iOS 开发，对于主题的支持，一直
没有什么特别有效、方便、快捷的方法。


## 环境需求

推荐使用 Swift 语言，支持最新 4.1 版本，同时兼容 Objective-C 语言。

## 安装集成

```ruby
pod "XZTheme"
```

## 示例

### 1. 主题事件

框架为所有 `NSObject` 对象提供主题支持，并且特别的为 `UIView` 及子类控件的主题支持进行了优化。所有支持的类中，主题都应用都
发生在主题事件方法 `updateAppearance(with: Theme)` 中。默认情况下，该方法会检查主题样式，并调用应用主题样式的方法。在不想
配置主题样式的情况下，重写此方法，直接在此方法中配置控件外观，是最简单最直接的方法。

```swift
override open func updateAppearance(with newTheme: Theme) {
    switch newTheme {
    case .day:
        self.textColor = UIColor.black
        
    case .night:
        self.textColor = UIColor.white
        
    default:
        break
    }
}
```

而对于非 UIView 对象，启用自动主题支持，需要重写下面的方法，并返回 `true` （默认 `false`)。 

```swift
open override var shouldAutomaticallyUpdateThemeAppearance: Bool {
    return true
}
```

### 2. 拓展主题

- 2.1 添加自定义主题

定义主题，只需要主题名字即可。框架提供了一个名为 `Theme.default` 的默认主题，用于在没有设置任何主题时，作为当前主题的占位符，
同时也作为，如果控件缺少某一主题样式配置时的默认值。建议使用默认主题，并在默认主题下配置界面元素的默认外观。比如下面的代码表示
定义了两个主题 `day`、`night` ，而 `day` 主题是默认主题的重命名版本。

```swift
extension Theme {
    static var day: Theme {
        return Theme.default
    }
    static let night = Theme(name: "night")
}
```

- 2.2 优化主题样式的访问方式

当访问主题集 `.themes` 中指定主题下的主题样式（集）时，使用的是 `themeStyles(forTheme:)` 方法，一般情况下，可以通过下面的方法来简化
此访问过程.

```swift
extension Theme.Collection {
    var day: Theme.Style.Collection {
        return self.themeStyles(forTheme: .day)
    }
    var night: Theme.Style.Collection {
        return self.themeStyles(forTheme: .night)
    }
}
```

- 2.3 如何使用已自定义

经过上面两步的自定义，那么访问对象指定主题下的样式集，就类似于下面的代码，不管是配置还是使用主题样式，看上去都显得自然多了。

```swift
view.themes.day.backgroundColor = UIColor.white
```

### 3. 配置主题样式

由于框架对于大部分系统控件都已提供了自动应用主题样式的机制，所以大部分情况下，你需要做的仅仅是配置主题样式即可。

- 3.1 直观属性法

将主题样式划分为主题属性和值，并辅以主题状态，几乎可以直接通过属性赋值的方式，设置绝大部分外观样式，同时改方法也是最接近原生
的方法。使用这种方法，需要使用者对控件的属性非常熟悉，因为主题样式对象几乎包含所有控件的属性，设置错了属性，既不会产生效
果，也不会产生错误。

```swift
label.themes.day.text              = "It's day now."
label.themes.day.backgroundColor   = UIColor(0xf5f5f5ff)
label.themes.day.textColor         = UIColor(0x333333ff)

label.themes.night.text            = "It's night now."
label.themes.night.backgroundColor = UIColor(0x252525ff)
label.themes.night.textColor       = UIColor(0x707070ff)
```

- 3.2 通过 `setValue(_:forThemeAttribute:)` 方法来配置主题样式

这种方式也是最基本的设置方式，其它形式的设置方式都可以看作是这种方式的便利方式，而且此方法，可以优化性能。比如可以使用
十六进制的颜色值来设置需要设置 `UIColor` 对象的外观属性，可以使用图片名来设置需要使用 `UIImage` 对象的外观属性。

```swift
view.themes.day.setValue(0xFFFFFFFF, forThemeAttribute: .backgroundColor)
view.themes.night.setValue("bg_view", forThemeAttribute: .backgroundImage)
```

- 3.3 通过链式函数 `setting(_:for:)` 来配置主题样式

链式编程可以少写一部分代码，同时简化了函数命名，使其看起来更简洁。

```swift
navigationBar.themes.day
    .setting(UIColor.white, for: .barTintColor)
    .setting(UIColor.black, for: .tintColor)
    .setting("nav_shadow_1", for: .shadowImage)
    .setting(UIBarStyle.default, for: .barStyle)
```

- 3.4 配置字典

在 XZTheme 的前几个版本，配置字典一直是作为主题配置文件而存在的功能，但是在使用中，发现维护配置文件其实非常困难。
所以，目前 XZTheme 不准备加入配置文件的功能，而配置字典仅作为一种便利方式保留。不过，作为可选选项，如果有合适的方
式，XZTheme 将考虑再加入配置文件的功能，最终的内存性能优化，只能靠配置文件了。

```swift
button.themes.day.updateThemeStyles(byUsing: [
    .normal: [
        .title: "Day normal",
        .titleColor: 0x0000FFFF,
        .backgroundImage: UIImage(filled: 0xCCCCCCFF)
    ],
    .highlighted: [
        .title: "Day highlighted",
        .titleColor: 0x9999FFFF,
        .backgroundImage: UIImage(filled: 0xDDDDDDFF)
    ]
])
```

- 3.5 全局主题

为了提高主题样式的复用性，框架支持设置全局样式，从而降低内存消耗，提高性能。在使用上，设置全局样式，与设置实例样式的操作完全，只是全局样式需要保证在控件创建前设置。
例如在 `application(_:didFinishLaunchingWithOptions)` 方法中设置。

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    UIButton.themes.day
        .setting(0x333333ff, for: .titleColor)
        .setting(UIImage(filled: 0xCCCCCCFF), for: .backgroundImage)
    
    UIButton.themes.night
        .setting(0x707070ff, for: .titleColor)
        .setting(UIImage(filled: 0x252525ff), for: .backgroundImage)
    
    return true
}
```

对于自定义视图，建议自定义视图使用静态常量，来处理全局样式加载的时机。

```swift
static let isThemeInitialized: Bool = {
    XZLabel.themes.day
        .setting(0xffffffff, for: .backgroundColor)
        .setting(0x000000ff, for: .textColor)
    
    XZLabel.themes.night
        .setting(0x303030ff, for: .backgroundColor)
        .setting(0x707070ff, for: .textColor)
    return true
}()

public override init(frame: CGRect) {
    super.init(frame: frame)
    
    _ = XZLabel.isThemeInitialized
    
    // ...
}
```

- 3.6 带标识符的全局主题

全局样式分带标识符的全局样式和不带标识符的全局样式，从而方便为同一控件设置多套样式。

```swift
UIButton.themes(forThemeIdentifier: "red").day
    .setting(0xffffffff, for: .titleColor)
    .setting(UIImage(filled: 0xff0000ff), for: .backgroundImage)

let buttonRed = UIButton(type: .custom)
buttonRed.frame = CGRect.init(x: 100, y: 160, width: 150, height: 40)
buttonRed.themeIdentifier = "red"
buttonRed.setTitle("A red Button", for: .normal)
view.addSubview(buttonRed)
```

- 3.7 样式优先级

如果对象同时存在全局样式和非全局样式，那么，当查找某一样式时，它们优先生效的顺序是：

 > 	**非全局样式** -> **带标识符的全局样式** -> **不带标识符的全局样式**


 - 3.8 带状态的主题属性配置

默认提供常见状态 `.normal, .highlighted, .selected, .disabled, .focused` 等状态的直接访问方式。

```swift
button.themes.day.normal.title = "normal title"
button.themes.day.selected.title = "normal title"
```

而对于 `UIBarMetrics`、`UIBarPosition` 的非常见状态，特别是多个状态对应一个主题属性，可以通过复合的 `Theme.State` 来实现。 

```swift
navigationBar.themes.day.setValue(
    "bg_bar_nav",
    forThemeAttribute: .backgroundImage,
    forThemeState: [.anyBarPosition, .defaultBarMetrics]
)
// 对应 setBackgroundImage(themeStyle.backgroundImage, for: barPosition, barMetrics: barMetrics) 方法
```

`Theme.State` 的复合规则见注释文档。


### 4. 切换主题

切换主题提供了一个简单的渐变过渡效果，当前你也可以关掉这个效果自己做。
另外，主题在切换后会自己记录，并在下次启动时自动应用。

```swift
@IBAction func nightAction(_ sender: Any) {
    Theme.night.apply(animated: true)
}

@IBAction func dayAction(_ sender: Any) {
    Theme.day.apply(animated: true)
}
```

## 特性

易用、 高效、可拓展


## 设计原理

将主题外观样式按属性名和属性值并分类存储，再通过建立样式属性名和样式属性值与控件属性的对应关系，
使得在主题变更时，可以通过读取已存储的样式属性，通过对应关系来直接来改变控件的属性。

## 拓展主题支持

- 1. 拓展主题属性

```
extension Theme.Attribute {
    
    /// UIView.backgroundColor
    public static let backgroundColor   = Theme.Attribute.init("backgroundColor");

}
```

- 2. 拓展主题样式
```
extension Theme.Style {
    
    public var backgroundColor: UIColor? {
        get { return color(forThemeAttribute: .backgroundColor)        }
        set { setValue(newValue, forThemeAttribute: .backgroundColor)  }
    }
}
```

- 3. 提供默认实现

```
extension UIView {
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
   
        if themeStyles.containsThemeAttribute(.backgroundColor) {
            self.backgroundColor = themeStyles.backgroundColor
        }
    }
}
```

## 支持的控件和属性

**UIView:** *backgroundColor, tintColor, isHidden, alpha, isOpaque, brightness.*

**UIImageView:** *image, highlightedImage, animationImages, highlightedAnimationImages, isHighlighted, isAnimating, placeholder.*

**UIButton:** *title, titleColor, titleShadowColor, image, backgroundImage, attributedTitle.*

**UILabel:** *text, textColor, font, shadowColor, highlightedTextColor, attributedText.*

**UINavigationBar:** *prefersLargeTitles, barTintColor, shadowImage, barStyle, isTranslucent, titleTextAttributes, backIndicatorImage, backIndicatorTransitionMaskImage.*

**UINavigationItem:** *title, hidesBackButton, prompt, leftItemsSupplementBackButton, largeTitleDisplayMode, hidesSearchBarWhenScrolling.*

**UIRefreshControl:** *attributedTitle, isRefreshing.*

**UIScrollView:** *indicatorStyle.*

**UITabBar:** *barTintColor, shadowImage, backgroundImage, selectionIndicatorImage, barStyle, isTranslucent, unselectedItemTintColor.*

**UITabBarItem:** *selectedImage, image, title, landscapeImagePhone, largeContentSizeImage, titleTextAttributes.*

**UITableView:** *sectionIndexColor, sectionIndexBackgroundColor, sectionIndexTrackingBackgroundColor, separatorStyle, separatorColor.*

**UIActivityIndicatorView:** *activityIndicatorViewStyle, color, hidesWhenStopped, isAnimating.*

**UIPageControl:** *numberOfPages, currentPage, hidesForSinglePage, defersCurrentPageDisplay, pageIndicatorTintColor, currentPageIndicatorTintColor.*

**UIProgressView:** *progressViewStyle, progress, progressTintColor, trackTintColor, progressImage, trackImage.*

**UISlider:** *isContinuous, minimumTrackTintColor, maximumTrackTintColor, thumbImage, minimumTrackImage, maximumTrackImage.*

**UISearchBar:** *barStyle, text, prompt, placeholder, showsBookmarkButton, showsCancelButton, showsSearchResultsButton, isSearchResultsButtonSelected, barTintColor, searchBarStyle, isTranslucent, scopeButtonTitles, showsScopeBar, backgroundImage, scopeBarBackgroundImage, backgroundImage(for:barMetrics:), searchFieldBackgroundImage, scopeBarButtonBackgroundImage, scopeBarButtonTitleTextAttributes, image, scopeBarButtonDividerImage, searchFieldBackgroundPositionAdjustment, searchTextPositionAdjustment, positionAdjustment.*

**UISwitch:** *onTintColor, thumbTintColor, onImage, offImage, isOn.*

**UITextField:** *text, attributedText, textColor, font, textAlignment, borderStyle, defaultTextAttributes, placeholder, attributedPlaceholder, clearsOnBeginEditing, adjustsFontSizeToFitWidth, minimumFontSize, background, disabledBackground, allowsEditingTextAttributes, typingAttributes, clearButtonMode, leftViewMode, rightViewMode, clearsOnInsertion, keyboardAppearance, keyboardType, returnKeyType, enablesReturnKeyAutomatically, isSecureTextEntry.*

**UITextView:** *text, font, textColor, textAlignment, isEditable, isSelectable, allowsEditingTextAttributes, attributedText, typingAttributes, clearsOnInsertion, linkTextAttributes, keyboardAppearance, keyboardType, returnKeyType, enablesReturnKeyAutomatically, isSecureTextEntry.*

**UIToolbar:** *barStyle, isTranslucent, barTintColor, backgroundImage, shadowImage.*

**UISegmentedControl:** *isMomentary, apportionsSegmentWidthsByContent, backgroundImage, dividerImage, titleTextAttributes, contentPositionAdjustment.*

## 开发备忘录

- 尝试使用泛型最终以失败告终。
    1. Swift 对象无法在 OC 方法中出现。
    2. Swift 类目方法，无法继承重写。
    3. Swift 泛型无法桥接到 OC 。
    4. OC 泛型在 Swift 中泛型拓展，无法访问原始定义的方法。
    5. 子类无法在方法参数继承到一个泛型是自己的参数。
    6. 其它众多阻碍，最终导致无法实现。

## 缺点

### 核心类 XZThemeStyle 属性过多

一般情况下，开发对于要设置外观样式，应该使用哪个属性都很清楚，应该不存在混淆的问题，即使存在也是少数。
这种情况类似于 CSS 样式，没有具体的约束某个类型的控件能用什么样式属性，但是不影响它的正常使用。

### 受限的可拓展性

通过 extension 拓展的外观样式属性，可能无法的拓展。
在框架设计之初，考虑过使用运行时动态捕捉方法和参数的方案，但是最终弃用。
运行时的方式，类似于 UIAppearance 机制，可以解决1的问题，同时也不存在2问题，但是这一套机制只能用于 OC ，而且对内存也不是很友好。
所以本框架的设计目的就很明确了，通过一次劳动，将已知的外观属性，通过一套规则，使其能自动应用已配置的值，而且可以控制这其中的内存和性能消耗。
如果框架对所有 UIKit 视图都默认提供了一套主题规则，而且开发者不需要太多学习成本，只需设置属性值，就可以轻松实现主题支持，那么本框架的设计目的就实现了。
一般情况下，对系统控件进行拓展并提供额外的属性来控制外观，这在目前除了使用运行时，似乎没有办法解决。不过好在，一般情况下，拓展系统组件不会对
改变外观样式，或者对外观样式的改变，也是通过添加额外的子视图来实现，而子视图是在主题传播链上的，似乎也不是不能解决的问题。因此，当我们想通过拓展给系统
组件添加额外的功能时，有必要提供公开的接口，便于其它开发者直接控制管理，比如 MJRefresh ，你可以通过 mj_header 来访问它额外增加的视图。

### 内存消耗以及性能

对象的私有主题配置，会随对象一起销毁，但是系统的对象，可能有多份相同的样式配置，
目前可以通过全局样式来解决此问题。但是全局样式又带来了新的问题，全局样式不会自动销毁。
后期考虑通过配置文件提供样式配置，懒加载主题样式，并自动释放未使用的主题样式。
但是配置文件，根据实际开发经验，可能会造成维护成本增加，所以具体方案还在考虑中。
还有其它的设计方案，比如根据标识符缓存主题配置到磁盘等，这些机制也在考虑范围内。
不过，在主题不是很多的情况下，比如只支持 2 套或 3 套主题，关于内存的问题，基本上不用考虑。

### 对 OC 不如 Swift 友好

XZTheme 核心功能虽然是 OC 代码，但是其完整的功能，只有使用 Swift 才能支持。
Swift 是 iOS 语言趋势，也是 XZTheme 框架主要适配的语言。


## TODO

### 缓存策略

主题样式的资源管理以及静态缓存策略（通过主题标识符，将配置缓存到磁盘上）待研究。

### 样式配置

通过字典、JSON串来配置样式。

1. 通过统一的文件配置所有的主题

```
// Theme.xss

// default

// 所有主题下的全局样式。
SampeView {
	font: 14.0;
}

// default 主题下的全局样式
#default SampeView {
    backgroundColor: #FFF;
}

// default 主题下指定标识符的全局样式。
#default SampeView.id1 {
    backgroundColor: #EEE;
}

// 标识符为 subview1 的视图的样式。
.subview1 {

}

.subview1 .subview2 {
	
}

// 子视图标识符为 subview1 的样式。
#default SampeView .subview1 {

}


```


## 联系作者

[mlibai@163.com](mailto:mlibai@163.com)

## License

XZKit is available under the MIT license. See the LICENSE file for more info.
