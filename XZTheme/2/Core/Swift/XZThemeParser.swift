//
//  XZThemeParser.swift
//  Example
//
//  Created by mlibai on 2018/4/30.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import Foundation
import XZKit

public protocol ThemeColorParser {
    func parse(_ value: Any?) -> UIColor?
}

public protocol ThemeImageParser {
    func parse(_ value: Any?) -> UIImage?
    func parse(_ value: Any?) -> [UIImage]?
}

public protocol ThemeFontParser {
    func parse(_ value: Any?) -> UIFont?
}

public protocol ThemeAttributedStringParser {
    func parse(_ value: Any?) -> NSAttributedString?
}

public protocol ThemeStringAttributesParser {
    func parse(_ value: Any?) -> [NSAttributedStringKey: Any]?
}

extension Theme {
    
    private final class Parser: ThemeColorParser, ThemeImageParser, ThemeFontParser, ThemeAttributedStringParser, ThemeStringAttributesParser {

    }
    
    private static let parser: Parser = Parser.init()
    
    public static var colorParser1:             ThemeColorParser            = Theme.parser
    public static var imageParser1:             ThemeImageParser            = Theme.parser
    public static var fontParser1:              ThemeFontParser             = Theme.parser
    public static var attribtedStringParser1:   ThemeAttributedStringParser = Theme.parser
    public static var stringAttributesParser1:  ThemeStringAttributesParser = Theme.parser
    
}

extension ThemeColorParser {
    
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
        XZLog("ThemeColorParser: Unparsable color value (%@), clear color returned.", value)
        return UIColor.clear
    }
    
}
extension ThemeImageParser {
    
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
        XZLog("ThemeImageParser: Unparsable images value (%@), nil returned.", value)
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
        XZLog("ThemeImageParser: Unparsable image value (%@), nil returned.", value)
        return nil
    }
    
}
extension ThemeFontParser {
    
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
        XZLog("ThemeFontParser: Unparsable font value (%@), system font returned.", value)
        return UIFont.systemFont(ofSize: UIFont.systemFontSize)
    }
    
    
}

extension ThemeAttributedStringParser {
    
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
        XZLog("ThemeFontParser: Unparsable AttributedString value (%@), nil returned.", value)
        return nil
    }
    
    
    
}
extension ThemeStringAttributesParser where Self: ThemeColorParser, Self: ThemeFontParser {
    
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
        XZLog("ThemeFontParser: Unparsable StringAttributes value (%@), nil returned.", value)
        return nil
    }
    
}
