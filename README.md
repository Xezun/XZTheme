# XZTheme

[![CI Status](https://img.shields.io/travis/rust-lang/rust.svg)](https://travis-ci.org/mlibai/XZTheme)
[![Version](https://img.shields.io/badge/Version-0.0.1-blue.svg?style=flat)](http://cocoapods.org/pods/XZTheme)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](http://cocoapods.org/pods/XZTheme)
[![Platform](https://img.shields.io/badge/Platform-iOS-yellow.svg)](http://cocoapods.org/pods/XZTheme)
[![Language](https://img.shields.io/badge/Language-Swift-red.svg)](http://cocoapods.org/pods/XZTheme)

XZTheme 是 XZKit 组件，该组件的主要目的是为 iOS App 提供统一的主题管理机制。

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


## 联系作者

[mlibai@163.com](mailto:mlibai@163.com)

## License

XZKit is available under the MIT license. See the LICENSE file for more info.
