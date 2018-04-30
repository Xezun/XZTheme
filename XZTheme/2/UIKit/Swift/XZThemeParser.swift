//
//  XZThemeParser.swift
//  Example
//
//  Created by mlibai on 2018/4/30.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import Foundation
import XZKit

/// 主题属性值解析器。
/// 配置主题属性值时，使用实际值可能会更效率，但是内存能不允许。
/// 例如主题样式包含大量图片，虽然 XZTheme 样式存储会随对象一起销毁，但是为了避免某些极端情况的内存问题，XZTheme 允许其它值来设置主题样式，比如图片名字。
/// 在默认规则下， ThemeParser 的作用是负责将样式配置值转换成实际使用值。
public protocol ThemeParser {
    func parse(_ value: Any?) -> UIColor?
    func parse(_ value: Any?) -> UIImage?
    func parse(_ value: Any?) -> [UIImage]?
    func parse(_ value: Any?) -> UIFont?
    func parse(_ value: Any?) -> NSAttributedString?
    func parse(_ value: Any?) -> [NSAttributedStringKey: Any]?
}


extension Theme {
    
    private final class Parser: ThemeParser {

    }
    
    /// 默认的主题样式属性解析器。
    /// - Note: 此属性可写，即可以自定解析方法。
    public static var parser: ThemeParser = Parser.init()
    
}

extension ThemeParser {
    
    public func parse(_ value: Any?) -> UIColor? {
        guard let value = value else { return nil }
        if let color = value as? UIColor {
            return color
        }
        if let number = value as? ColorValue {
            return UIColor.init(number)
        }
        if let string = value as? String {
            return UIColor.init(string)
        }
        XZLog("XZTheme: Unparsable color value (%@), clear color returned.", value)
        return UIColor.clear
    }
    
    func parse(_ value: Any?) -> [UIImage]? {
        guard let value = value else { return nil }
        if let imageName = value as? String {
            var images = [UIImage]()
            for index in 0 ... 1024 {
                guard let image = UIImage(named: String.init(format: "%@%d", imageName, index)) else { break }
                images.append(image)
            }
            return images
        } else if let imageNames = value as? [String] {
            var images = [UIImage]()
            for name in imageNames {
                guard let image = UIImage.init(named: name) else { continue }
                images.append(image)
            }
            return images
        }
        XZLog("XZTheme: Unparsable images value (%@), nil returned.", value)
        return nil
    }
    
    
    public func parse(_ value: Any?) -> UIImage? {
        guard let value = value else { return nil }
        if let image = value as? UIImage {
            return image
        }
        if let imageName = value as? String {
            return UIImage(named: imageName)
        }
        if let dict = value as? [String: Any] {
            if let images: [UIImage] = self.parse(dict["name"]) {
                if let duration = dict["duration"] as? TimeInterval {
                    return UIImage.animatedImage(with: images, duration: duration)
                }
            }
        }
        XZLog("XZTheme: Unparsable image value (%@), nil returned.", value)
        return nil
    }
    
    public func parse(_ value: Any?) -> UIFont? {
        guard let value = value else { return nil }
        if let font = value as? UIFont {
            return font
        }
        if let fontName = value as? String {
            return UIFont(name: fontName, size: UIFont.systemFontSize)
        }
        if let fontSize = value as? CGFloat {
            return UIFont.systemFont(ofSize: fontSize)
        }
        guard let dict = value as? [String: Any] else { return nil }
        
        if let fontName = dict["name"] as? String {
            // name and size
            if let fontSize = dict["size"] as? CGFloat {
                return UIFont(name: fontName, size: fontSize)
            } else {
                return UIFont(name: fontName, size: UIFont.systemFontSize)
            }
        } else if let fontSize = dict["size"] as? CGFloat {
            // systeme font size and weight
            if #available(iOS 8.2, *), let fontWeight = dict["weight"] as? CGFloat {
                return UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight(rawValue: fontWeight))
            } else {
                return UIFont.systemFont(ofSize: fontSize)
            }
        }
        XZLog("XZTheme: Unparsable font value (%@), system font returned.", value)
        return UIFont.systemFont(ofSize: UIFont.systemFontSize)
    }
    
    /// 富文本解析。
    /// 如果值已经是 NSAttributedString 则直接返回原始值。
    /// 如果值为字符串，则直接通过此字符串构造 NSAttributedString 。
    /// 如果格式为字典，其目前仅支持如下格式：
    /// ```json
    /// {
    ///     "type": "html"
    ///     "content": "<b>This is the text.</b>"
    /// }
    /// ```
    ///
    /// - Parameter value: 待解析的值。
    /// - Returns: 富文本。
    func parse(_ value: Any?) -> NSAttributedString? {
        guard let value = value else { return nil }
        if let attributedString = value as? NSAttributedString {
            return attributedString
        }
        if let dict = value as? [String: Any] {
            if let content = dict["content"] as? String {
                if let type = dict["type"] as? String {
                    switch type {
                    case "html":
                        guard let data = content.data(using: .utf8) else { break }
                        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
                        if let attributedString = try? NSAttributedString.init(data: data, options: options, documentAttributes: nil) {
                            return attributedString;
                        }
                        
                    default: break
                    }
                } else {
                    return NSAttributedString.init(string: content)
                }
            }
        }
        if let string = value as? String {
            return NSAttributedString.init(string: string)
        }
        XZLog("XZTheme: Unparsable AttributedString value (%@), nil returned.", value)
        return nil
    }
    
    
    func parse(_ value: Any?) -> [NSAttributedStringKey : Any]? {
        guard let value = value else { return nil }
        if let stringAttributes = value as? [NSAttributedStringKey: Any] {
            return stringAttributes
        }
        if let dict = value as? [String: Any] {
            let font: UIFont? = self.parse(dict["font"])
            let color: UIColor? = self.parse(dict["color"])
            let backgroundColor: UIColor? = self.parse(dict["backgroundColor"])
            if font != nil || color != nil || backgroundColor != nil {
                var stringAttributes = [NSAttributedStringKey: Any]()
                stringAttributes[.font] = font
                stringAttributes[.foregroundColor] = color
                stringAttributes[.backgroundColor] = backgroundColor
                return stringAttributes
            }
        }
        XZLog("XZTheme: Unparsable StringAttributes value (%@), nil returned.", value)
        return nil
    }
    
}
