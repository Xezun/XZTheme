//
//  Theme+UITextField.swift
//  XZTheme
//
//  Created by mlibai on 2018/5/24.
//

import Foundation

extension Theme.Attribute {

    public static let textAlignment = Theme.Attribute.init("textAlignment")
    public static let borderStyle   = Theme.Attribute.init("borderStyle")
    public static let placeholder   = Theme.Attribute.init("placeholder")
    public static let keyboardAppearance = Theme.Attribute.init("keyboardAppearance")
    public static let keyboardType = Theme.Attribute.init("keyboardType")
}

extension Theme.Style {

    public var placeholderString: String? {
        get { return stringValue(forThemeAttribute: .placeholder) }
        set { setValue(newValue, forThemeAttribute: .placeholder) }
    }
    
    /// 支持 UIKeyboardAppearance、Int、String 等类型，默认 .default 。
    /// - Note: 支持的字符串 default、dark、light、alert 。
    /// - Note: 支持的数值为原始值。
    ///
    /// - Parameter themeAttribute: 主题属性。
    /// - Returns: UIKeyboardAppearance
    public func keyboardAppearance(forThemeAttribute themeAttribute: Theme.Attribute) -> UIKeyboardAppearance {
        guard let value = self.value(forThemeAttribute: .keyboardAppearance) else { return .default }
        if let keyboardAppearance = value as? UIKeyboardAppearance {
            return keyboardAppearance
        }
        if let number = value as? Int, let keyboardAppearance = UIKeyboardAppearance.init(rawValue: number) {
            return keyboardAppearance
        }
        if let string = value as? String {
            switch string {
            case "default": return .default;
            case "dark":    return .dark;
            case "light":   return .light;
            case "alert":   return .alert;
            default: break
            }
        }
        return .default;
    }
    
    /// 键盘外观。
    public var keyboardAppearance: UIKeyboardAppearance {
        get { return keyboardAppearance(forThemeAttribute: .keyboardAppearance) }
        set { setValue(newValue, forThemeAttribute: .keyboardAppearance) }
    }

//    public var <#color#>: UIColor? {
//        get { return color(forThemeAttribute: <#T##Theme.Attribute#>) }
//        set { setValue(newValue, forThemeAttribute: <#T##Theme.Attribute#>) }
//    }
//
//    public var <#image#>: UIImage? {
//        get { return image(forThemeAttribute: <#T##Theme.Attribute#>) }
//        set { setValue(newValue, forThemeAttribute: <#T##Theme.Attribute#>)}
//    }
//
//    public var <#bool#>: Bool {
//        get { return boolValue(forThemeAttribute: <#T##Theme.Attribute#>)  }
//        set { setValue(newValue, forThemeAttribute: <#T##Theme.Attribute#>) }
//    }

}

extension UITextField {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.containsThemeAttribute(.text) {
            self.text = themeStyles.text;
        }
        
        if themeStyles.containsThemeAttribute(.attributedText) {
            self.attributedText = themeStyles.attributedText
        }
        
        if themeStyles.containsThemeAttribute(.textColor) {
            self.textColor = themeStyles.textColor
        }
        
        if themeStyles.containsThemeAttribute(.font) {
            self.font = themeStyles.font
        }
        
        if themeStyles.containsThemeAttribute(.backgroundImage) {
            self.background = themeStyles.backgroundImage
        }
        
        if themeStyles.containsThemeAttribute(.placeholder) {
            self.placeholder = themeStyles.placeholderString
        }
        
        if themeStyles.containsThemeAttribute(.keyboardAppearance) {
            self.keyboardAppearance = themeStyles.keyboardAppearance
        }
    }
    
}

//
//open var textAlignment: NSTextAlignment // default is NSLeftTextAlignment
//
//open var borderStyle: UITextBorderStyle // default is UITextBorderStyleNone. If set to UITextBorderStyleRoundedRect, custom background images are ignored.
//
//@available(iOS 7.0, *)
//open var defaultTextAttributes: [String : Any] // applies attributes to the full range of text. Unset attributes act like default values.
//
//
//open var placeholder: String? // default is nil. string is drawn 70% gray
//
//@available(iOS 6.0, *)
//@NSCopying open var attributedPlaceholder: NSAttributedString? // default is nil
//
//open var clearsOnBeginEditing: Bool // default is NO which moves cursor to location clicked. if YES, all text cleared
//
//open var adjustsFontSizeToFitWidth: Bool // default is NO. if YES, text will shrink to minFontSize along baseline
//
//open var minimumFontSize: CGFloat // default is 0.0. actual min may be pinned to something readable. used if adjustsFontSizeToFitWidth is YES
//
//weak open var delegate: UITextFieldDelegate? // default is nil. weak reference
//
//open var background: UIImage? // default is nil. draw in border rect. image should be stretchable
//
//open var disabledBackground: UIImage? // default is nil. ignored if background not set. image should be stretchable
//
//
//open var isEditing: Bool { get }
//
//@available(iOS 6.0, *)
//open var allowsEditingTextAttributes: Bool // default is NO. allows editing text attributes with style operations and pasting rich text
//
//@available(iOS 6.0, *)
//open var typingAttributes: [String : Any]? // automatically resets when the selection changes
//
//
//// You can supply custom views which are displayed at the left or right
//// sides of the text field. Uses for such views could be to show an icon or
//// a button to operate on the text in the field in an application-defined
//// manner.
////
//// A very common use is to display a clear button on the right side of the
//// text field, and a standard clear button is provided.
//
//open var clearButtonMode: UITextFieldViewMode //
