# XZTheme

[![CI Status](https://img.shields.io/travis/rust-lang/rust.svg)](https://travis-ci.org/mlibai/XZKit)
[![Version](https://img.shields.io/badge/Version-1.0.0-blue.svg?style=flat)](http://cocoapods.org/pods/XZKit)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](http://cocoapods.org/pods/XZKit)
[![Platform](https://img.shields.io/badge/Platform-iOS-yellow.svg)](http://cocoapods.org/pods/XZKit)

XZTheme 是 XZKit 组件，该组件的主要目的是为 iOS App 提供统一的主题管理机制。

## 例子

### 1. 自定义主题

```swift
extension Theme {
    static var day: Theme {
        return Theme.default
    }
    static let night = Theme(name: "night")
}
```

### 2. 创建快捷方式

```
extension Theme.Collection {

    var day: Theme.Style.Collection {
        return self.themeStyles(forTheme: .day)
    }

    var night: Theme.Style.Collection {
        return self.themeStyles(forTheme: .night)
    }

}
```

### 3. 配置主题

#### 1. 直接设置主题属性

```swift
label.themes.day.text              = "It's day now."
label.themes.day.backgroundColor   = UIColor(0xf5f5f5ff)
label.themes.day.textColor         = UIColor(0x333333ff)

label.themes.night.text            = "It's night now."
label.themes.night.backgroundColor = UIColor(0x252525ff)
label.themes.night.textColor       = UIColor(0x707070ff)

```

#### 2. 通过链式函数设置

```swift
self.navigationController?.navigationBar.themes.day
    .setting(UIColor.white, for: .barTintColor)
    .setting(UIColor.black, for: .tintColor)
    .setting(UIImage(filled: 0xccccccFF, size: CGSize(width: 0.5, height: 0.5)), for: .shadowImage)
    .setting(UIBarStyle.default, for: .barStyle)

self.navigationController?.navigationBar.themes.night
    .setting(UIColor(0x252525FF), for: .barTintColor)
    .setting(UIColor(0x707070FF), for: .tintColor)
    .setting(UIImage(filled: 0x555555FF, size: CGSize(width: 0.5, height: 0.5)), for: .shadowImage)
    .setting(UIBarStyle.black, for: .barStyle)
```

#### 3. 通过配置字典

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

```
@IBAction func nightAction(_ sender: Any) {
    Theme.night.apply(true)
}

@IBAction func dayAction(_ sender: Any) {
    Theme.day.apply(true)
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

[mlibai@163.com](mailto://mlibai@163.com)

## License

XZKit is available under the MIT license. See the LICENSE file for more info.
