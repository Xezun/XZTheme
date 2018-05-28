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


## 特性及原理

系统原生 UIAppearance 方案，应该说是在实现主题方案中最直观的了，但是其局限性和性能却让人不敢恭维。本组件在借鉴 UIAppearance 机制的基础上，
提高了组件性能以及适应性。

### 设计原理

将主题外观样式按属性名和属性值并分类存储，再通过建立样式属性名和样式属性值与控件属性的对应关系，
使得在主题变更时，可以通过读取已存储的样式属性，通过对应关系来直接来改变控件的属性。

### 运行机制


#### 普通对象

为每一个需要支持主题的对象，自动创建监听主题变更的对象（开发者也可以自定义），并在主题变更时，响应指定的方法。

#### UIKit 控件及相关对象

主题变更时，所有正在显示的视图，都将收到主题变更事件，而且这些都是自动的；而没有正在显示的视图，则在它们被添加到父视图上时，自动检测
其已应用的主题与当前主题是否一致，并自动决定是否需要应用主题。

## 环境需求

Swift 4.0

## 安装集成

```ruby
pod "XZTheme"
```

## 例子

### 0. 最简单的例子 

当主题发生改变时，UIView控件及其子类的 `updateAppearance(with: Theme)` 方法会被调用，直接在此方法中，根据主题来配置样式。
这是本主题组件支持的最简单的方式，同时也是理论上效率、性能最高的方式。

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

而对于非 UIView 对象，需要写的实现的方法，仅比上面多一行代码。

```swift
open override var shouldAutomaticallyUpdateThemeAppearance: Bool {
    return true
}
```

上面这个方法，返回 true 时，XZTheme 组件将自动调用 `updateAppearance(with: Theme)` 方法（通过 `setNeedsThemeAppearanceUpdate()` 方法）来告知对象切换主题了。
不过，如果对象切换主题需要特殊处理来提高性能，比如可以延迟切换主题，那么开发者可以根据需要来确定是否需要监听通知。


### 1. 准备工作

上面的例子中，使用 `.day` 和 `.night` 来通过 `switch` 判断主题，是需要一些准备工作的。

- 自定义主题

通过 `extension` 将自定义主题写成属性的形式，方便调用。框架已经提供了一个 `Theme.default` 的默认主题拓展，它默认也不包含任何样式。
默认主题在以下介绍的几种主题配置方案中，是建议使用的，如果你不喜欢这个名字，可以给它重命名。

```swift
extension Theme {
    static var day: Theme {
        return Theme.default
    }
    static let night = Theme(name: "night")
}
```

- 在下面的几种方案中，你可能还需要设置获取主题样式配置的便利方法。

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

### 2. 配置主题

XZTheme 支持使用多种方式配置主题，而且支持使用多种值来设置。比如使用十六进制颜色值（#FFAA33、0xA2B2C3FF）来设置颜色，通过图片名称来设置图片。
XZTheme 仅对 OC 开放了少量基本接口，毕竟 Swift 是 iOS 的未来，还没有使用 Swift 开发的同学，开始拥抱 Swift 吧。

1. 通过 setValue 方法来配置主题样式。

这是最基本的设置样式值方式，其它形式的设置方式都是这种方式的便利方式。

```swift
view.themes.day.setValue(0xFFFFFFFF, forThemeAttribute: .backgroundColor)
view.themes.night.setValue(0x303030ff, forThemeAttribute: .backgroundColor)
```

2. 通过主题属性，对于原生控件，这个看上去与 UIAppearance 很相似。

主题样式几乎拥有大部分控件的样式属性，即使没有，也可以自行拓展，所以你可以直接访问属性来设置值。
但是这种方式，就必须使用属性的实际值了。

```swift
label.themes.day.text              = "It's day now."
label.themes.day.backgroundColor   = UIColor(0xf5f5f5ff)
label.themes.day.textColor         = UIColor(0x333333ff)

label.themes.night.text            = "It's night now."
label.themes.night.backgroundColor = UIColor(0x252525ff)
label.themes.night.textColor       = UIColor(0x707070ff)

```

3. 通过 setting 方法，链式设置。

链式编程在 Swift 中，比在 OC 中看起来优美多了，所以不必排斥这种写法了。
链式编程在 OC 中是不被建议使用的，也没有对 OC 开放相关接口。

```swift
navigationBar.themes.day
    .setting(UIColor.white, for: .barTintColor)
    .setting(UIColor.black, for: .tintColor)
    .setting("nav_shadow_1", for: .shadowImage)
    .setting(UIBarStyle.default, for: .barStyle)

navigationBar.themes.night
    .setting(UIColor(0x252525FF), for: .barTintColor)
    .setting(UIColor(0x707070FF), for: .tintColor)
    .setting("nav_shadow_2", for: .shadowImage)
    .setting(UIBarStyle.black, for: .barStyle)
```

4. 配置字典

如果调用方法让人感到厌烦，获取这里有一个看上去简单点的方法。
配置字典和配置文件看起来很像，在 XZTheme 的前几个版本，XZTheme 是一直支持配置文件的功能，但是在实际使用才发现，维护配置文件真的很头疼。
不过，作为可选选项，如果有合适的方式，XZTheme 将考虑再加入这个功能。

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

button.themes.night.updateThemeStyles(byUsing: [
    .normal: [
        .title: "Night normal",
        .titleColor: 0x008800FF,
        .backgroundImage: UIImage(filled: 0x555555ff)
    ],
    .highlighted: [
        .title: "Night highlighted",
        .titleColor: 0x007700FF,
        .backgroundImage: UIImage(filled: 0x444444FF)
    ]
])
```

5. 全局主题

为了提供主题样式的复用性，提供了设置全局样式的方法，且设置全局样式，与设置实例对象的样式完全一样。

全局样式的设置，可以放在 `application(_:didFinishLaunchingWithOptions)` 方法中。

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

不过，对于自定义视图，建议自定义视图使用静态常量（`initialize()` 在 Swift 4 中被禁用了）。

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

为了提供全局样式的适应性，全局样式分带标识符的全局样式和不带标识符的全局样式。通过主题标识符，可以为对象提供多套全局样式。

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

如果对象同时存在全局样式和私有样式，那么，当查找某一样式时，它们生效的顺序是：

    1. 首先检查私有样式是否包含该指定的样式的配置；
    2. 检查当前对象标识符对应的带标识符的全局样式是否包含该指定的样式；
    3. 检查不带标识符的全局样式是否包含该指定的样式。

比如：

```swift
UIButton.themes.day
    .setting(0x333333ff, for: .titleColor)
    .setting(UIImage(filled: 0xCCCCCCFF), for: .backgroundImage)
UIButton.themes(forThemeIdentifier: "red").day
    .setting(0xffffffff, for: .titleColor)
    .setting(UIImage(filled: 0xff0000ff), for: .backgroundImage)

let buttonRed = UIButton(type: .custom)
buttonRed.frame = CGRect.init(x: 100, y: 160, width: 150, height: 40)
buttonRed.themeIdentifier = "red"
buttonRed.setTitle("A red Button", for: .normal)
view.addSubview(buttonRed)
```

`buttonRed` 最终会显示白色文字、红色背景的按钮。


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

## 拓展主题支持

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
