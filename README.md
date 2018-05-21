# XZTheme

[![CI Status](https://img.shields.io/travis/rust-lang/rust.svg)](https://travis-ci.org/mlibai/XZTheme)
[![Version](https://img.shields.io/badge/Version-0.0.1-blue.svg?style=flat)](http://cocoapods.org/pods/XZTheme)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](http://cocoapods.org/pods/XZTheme)
[![Platform](https://img.shields.io/badge/Platform-iOS-yellow.svg)](http://cocoapods.org/pods/XZTheme)
[![Language](https://img.shields.io/badge/Language-Swift-red.svg)](http://cocoapods.org/pods/XZTheme)

XZTheme 是 XZKit 组件，该组件的主要目的是为 iOS App 提供统一的主题管理机制。



## 特性及原理

### 设计原理

将控件（或对象，以下简称控件）的外观样式划分为属性名 `Theme.Attribute` 和属性值，这样就可以将样式 `Theme.Style` 按主题进行分类存储，再通过建立样式属性名和样式属性值与控件属性的对应关系，使得在主题变更时，可以通过读取样式属性来改变控件的属性。

### 运行机制

#### 普通对象

对于普通对象，只能通过监听  `Notification.Name.ThemeDidChange` 通知来自行改变主题。

#### UIKit 控件及相关对象



## 例子

### 1. 自定义主题

通过 `extension` 将自定义主题写成属性的形式，方便调用。`Theme.default` 是默认的主题，不过它不包含任何样式。
如果你不喜欢这个名字，给它来个重命名。

```swift
extension Theme {
    static var day: Theme {
        return Theme.default
    }
    static let night = Theme(name: "night")
}
```

除此之外，设置获取主题样式配置的便利方法。

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

1. 设置函数

这是最基本的设置样式值方式，其它形式的设置方式都是这种方式的便利方式。

```swift
view.themes.day.setValue(0xFFFFFFFF, forThemeAttribute: .backgroundColor)
view.themes.night.setValue(0x303030ff, forThemeAttribute: .backgroundColor)
```

2. 主题样式属性

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

3. 链式函数

链式函数在 Swift 中，比在 OC 中看起来优美多了，所以不必排斥这种写法了。这宗写法在 OC 中是不建议的，也没有开放相关接口。

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
button.themes.day.setThemeStyles(byUsing: [
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

button.themes.night.setThemeStyles(byUsing: [
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

## 环境需求

Swift 4.0

## 安装集成

```ruby
pod "XZTheme"
```

## 组件

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


### 对 OC 不如 Swift 友好

XZTheme 核心功能虽然是 OC 代码，但是其完整的功能，只有使用 Swift 才能支持。
Swift 是 iOS 语言趋势，也是 XZTheme 框架主要适配的语言。


## TODO

### 缓存策略

主题样式的资源管理以及静态缓存策略（通过主题标识符，将配置缓存到磁盘上）待研究。

### 样式配置

通过字典、JSON串来配置样式。


## 联系作者

[mlibai@163.com](mailto:mlibai@163.com)

## License

XZKit is available under the MIT license. See the LICENSE file for more info.
