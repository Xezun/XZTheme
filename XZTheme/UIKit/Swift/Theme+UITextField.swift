//
//  Theme+UITextField.swift
//  XZTheme
//
//  Created by mlibai on 2018/5/24.
//

import Foundation
import XZKit




extension Theme.Attribute {

    /// UITextField
    public static let textAlignment                 = Theme.Attribute.init(rawValue: "textAlignment")
    /// UITextField
    public static let borderStyle                   = Theme.Attribute.init(rawValue: "borderStyle")
    /// UITextField
    public static let defaultTextAttributes         = Theme.Attribute.init(rawValue: "defaultTextAttributes")
    /// UITextField
    public static let attributedPlaceholder         = Theme.Attribute.init(rawValue: "attributedPlaceholder")
    /// UITextField
    public static let clearsOnBeginEditing          = Theme.Attribute.init(rawValue: "clearsOnBeginEditing")
    /// UITextField, UILabel
    public static let adjustsFontSizeToFitWidth     = Theme.Attribute.init(rawValue: "adjustsFontSizeToFitWidth")
    /// UITextField
    public static let minimumFontSize               = Theme.Attribute.init(rawValue: "minimumFontSize")
    /// UITextField
    public static let background                    = Theme.Attribute.init(rawValue: "background")
    /// UITextField
    public static let disabledBackground            = Theme.Attribute.init(rawValue: "disabledBackground")
    /// UITextField
    public static let allowsEditingTextAttributes   = Theme.Attribute.init(rawValue: "allowsEditingTextAttributes")
    /// UITextField
    public static let typingAttributes              = Theme.Attribute.init(rawValue: "typingAttributes")
    /// UITextField
    public static let clearButtonMode               = Theme.Attribute.init(rawValue: "clearButtonMode")
    /// UITextField
    public static let leftViewMode                  = Theme.Attribute.init(rawValue: "leftViewMode")
    /// UITextField
    public static let rightViewMode                 = Theme.Attribute.init(rawValue: "rightViewMode")
    /// UITextField
    public static let clearsOnInsertion             = Theme.Attribute.init(rawValue: "clearsOnInsertion")
    
    /// UITextField
    public static let keyboardAppearance            = Theme.Attribute.init(rawValue: "keyboardAppearance")
    /// UITextField
    public static let keyboardType                  = Theme.Attribute.init(rawValue: "keyboardType")
    /// UITextField
    public static let returnKeyType                 = Theme.Attribute.init(rawValue: "returnKeyType")
    /// UITextField
    public static let enablesReturnKeyAutomatically = Theme.Attribute.init(rawValue: "enablesReturnKeyAutomatically")
    /// UITextField
    public static let isSecureTextEntry             = Theme.Attribute.init(rawValue: "isSecureTextEntry")
}

extension Theme.Style {

    public func textAlignment(for themeAttribute: Theme.Attribute) -> NSTextAlignment {
        guard let value = self.value(for: .keyboardAppearance) else { return .natural }
        if let textAlignment = value as? NSTextAlignment {
            return textAlignment
        }
        if let number = value as? Int, let textAlignment = NSTextAlignment.init(rawValue: number) {
            return textAlignment
        }
        
        if let string = value as? String {
            switch string {
            case "left":        return .left;
            case "center":      return .center;
            case "right":       return .right;
            case "justified":   return .justified;
            case "natural":     return .natural;
            default: break
            }
        }
        XZLog("XZTheme: The theme style value (%@) for attribute (%@) is not a NSTextAlignment value, `.natural` returned.", value, themeAttribute)
        return .natural;
    }
    
    public func keyboardAppearance(for themeAttribute: Theme.Attribute) -> UIKeyboardAppearance {
        guard let value = self.value(for: .keyboardAppearance) else { return .default }
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
        XZLog("XZTheme: The theme style value (%@) for attribute (%@) is not a UIKeyboardAppearance value, `.default` returned.", value, themeAttribute)
        return .default;
    }
    
    public func textBorderStyle(for themeAttribute: Theme.Attribute) -> UITextField.BorderStyle {
        guard let value = self.value(for: .keyboardAppearance) else { return .none }
        if let textBorderStyle = value as? UITextField.BorderStyle {
            return textBorderStyle
        }
        if let number = value as? Int, let textBorderStyle = UITextField.BorderStyle.init(rawValue: number) {
            return textBorderStyle
        }
        
        if let string = value as? String {
            switch string {
            case "none":        return .none;
            case "line":        return .line;
            case "bezel":       return .bezel;
            case "roundedRect": return .roundedRect;
            default: break
            }
        }
        XZLog("XZTheme: The theme style value (%@) for attribute (%@) is not a UITextBorderStyle value, `.none` returned.", value, themeAttribute)
        return .none;
    }
    
    public func textFieldViewMode(for themeAttribute: Theme.Attribute) -> UITextField.ViewMode {
        guard let value = self.value(for: .keyboardAppearance) else { return .always }
        if let textBorderStyle = value as? UITextField.ViewMode {
            return textBorderStyle
        }
        if let number = value as? Int, let textBorderStyle = UITextField.ViewMode.init(rawValue: number) {
            return textBorderStyle
        }
        if let string = value as? String {
            switch string {
            case "never":         return .never;
            case "whileEditing":  return .whileEditing;
            case "unlessEditing": return .unlessEditing;
            case "always":        return .always;
            default: break
            }
        }
        XZLog("XZTheme: The theme style value (%@) for attribute (%@) is not a UITextFieldViewMode value, `.always` returned.", value, themeAttribute)
        return .always;
    }
    

    

    public var textAlignment: NSTextAlignment {
        get { return textAlignment(for: .textAlignment)  }
        set { setValue(newValue, for: .textAlignment) }
    }
    
    //open var text: String?
    //var attributedText: NSAttributedString?
    //open var textColor: UIColor?
    //open var font: UIFont?
    //open var textAlignment: NSTextAlignment
    
    public var borderStyle: UITextField.BorderStyle {
        get { return textBorderStyle(for: .borderStyle) }
        set { setValue(newValue, for: .borderStyle) }
    }
    
    open var defaultTextAttributes: [NSAttributedString.Key : Any] {
        get { return stringAttributes(for: .defaultTextAttributes) ?? [:] }
        set { setValue(newValue, for: .defaultTextAttributes) }
    }
    
    /// /// 该属性对应的主题属性为 `.placeholder` 。
    public var placeholderText: String? {
        get { return stringValue(for: .placeholder) }
        set { setValue(newValue, for: .placeholder) }
    }
    
    public var attributedPlaceholder: NSAttributedString? {
        get { return attributedString(for: .attributedPlaceholder) }
        set { setValue(newValue, for: .attributedPlaceholder) }
    }
    
    public var clearsOnBeginEditing: Bool {
        get { return boolValue(for: .clearsOnBeginEditing) }
        set { setValue(newValue, for: .clearsOnBeginEditing) }
    }
    
    public var adjustsFontSizeToFitWidth: Bool {
        get { return boolValue(for: .adjustsFontSizeToFitWidth) }
        set { setValue(newValue, for: .adjustsFontSizeToFitWidth) }
    }
    
    public var minimumFontSize: CGFloat {
        get { return floatValue(for: .minimumFontSize) }
        set { setValue(newValue, for: .minimumFontSize) }
    }
    
    public var background: UIImage? {
        get { return image(for: .background) }
        set { setValue(newValue, for: .background) }
    }
    
    public var disabledBackground: UIImage? {
        get { return image(for: .disabledBackground) }
        set { setValue(newValue, for: .disabledBackground) }
    }
    
    public var allowsEditingTextAttributes: Bool {
        get { return boolValue(for: .allowsEditingTextAttributes) }
        set { setValue(newValue, for: .allowsEditingTextAttributes) }
    }
    
    public var typingAttributes: [NSAttributedString.Key : Any]? {
        get { return stringAttributes(for: .typingAttributes) }
        set { setValue(newValue, for: .typingAttributes) }
    }
    
    public var clearButtonMode: UITextField.ViewMode {
        get { return textFieldViewMode(for: .clearButtonMode) }
        set { setValue(newValue, for: .clearButtonMode) }
    }
    
    public var leftViewMode: UITextField.ViewMode {
        get { return textFieldViewMode(for: .leftViewMode) }
        set { setValue(newValue, for: .leftViewMode) }
    }
    
    public var rightViewMode: UITextField.ViewMode {
        get { return textFieldViewMode(for: .rightViewMode) }
        set { setValue(newValue, for: .rightViewMode) }
    }
    
    public var clearsOnInsertion: Bool {
        get { return boolValue(for: .clearsOnInsertion) }
        set { setValue(newValue, for: .clearsOnInsertion) }
    }
    
    
    
    public func keyboardType(for themeAttribute: Theme.Attribute) -> UIKeyboardType {
        guard let value = self.value(for: .keyboardAppearance) else { return .`default` }
        if let keyboardType = value as? UIKeyboardType {
            return keyboardType
        }
        if let number = value as? Int, let keyboardType = UIKeyboardType.init(rawValue: number) {
            return keyboardType
        }
        if let string = value as? String {
            switch string {
            case "default":                 return .`default`
            case "asciiCapable":            return .asciiCapable
            case "numbersAndPunctuation":   return .numbersAndPunctuation
            case "URL":                     return .URL
            case "numberPad":               return .numberPad
            case "phonePad":                return .phonePad
            case "namePhonePad":            return .namePhonePad
            case "emailAddress":            return .emailAddress
            case "decimalPad":              return .decimalPad
            case "twitter":                 return .twitter
            case "webSearch":               return .webSearch
            case "asciiCapableNumberPad":   if #available(iOS 10.0, *) { return .asciiCapableNumberPad }
            default:                        break
            }
        }
        XZLog("XZTheme: The theme style value (%@) for attribute (%@) is not a UIKeyboardType value, `.default` returned.", value, themeAttribute)
        return .`default`;
    }
    
    public func returnKeyType(for themeAttribute: Theme.Attribute) -> UIReturnKeyType {
        guard let value = self.value(for: .keyboardAppearance) else { return .`default` }
        if let returnKeyType = value as? UIReturnKeyType {
            return returnKeyType
        }
        if let number = value as? Int, let returnKeyType = UIReturnKeyType.init(rawValue: number) {
            return returnKeyType
        }
        if let string = value as? String {
            switch string {
            case "default": return .`default`
            case "go":      return .go
            case "google":  return .google
            case "join":    return .join
            case "next":    return .next
            case "route":   return .route
            case "search":  return .search
            case "send":    return .send
            case "yahoo":   return .yahoo
            case "done":    return .done
            case "emergencyCall":   return .emergencyCall
            case "continue":        if #available(iOS 9.0, *) { return .`continue` }
            default:                break
            }
        }
        XZLog("XZTheme: The theme style value (%@) for attribute (%@) is not a UIReturnKeyType value, `.default` returned.", value, themeAttribute)
        return .`default`;
    }
    
    /// 键盘外观。
    public var keyboardAppearance: UIKeyboardAppearance {
        get { return keyboardAppearance(for: .keyboardAppearance) }
        set { setValue(newValue, for: .keyboardAppearance) }
    }
    
    public var keyboardType: UIKeyboardType {
        get { return keyboardType(for: .keyboardType) }
        set { setValue(newValue, for: .keyboardType) }
    }
    
    /// UITextField
    public var returnKeyType: UIReturnKeyType {
        get { return returnKeyType(for: .returnKeyType) }
        set { setValue(newValue, for: .returnKeyType) }
    }
    
    /// UITextField
    public var enablesReturnKeyAutomatically: Bool {
        get { return boolValue(for: .enablesReturnKeyAutomatically) }
        set { setValue(newValue, for: .enablesReturnKeyAutomatically) }
    }
    
    /// UITextField
    public var isSecureTextEntry: Bool {
        get { return boolValue(for: .isSecureTextEntry) }
        set { setValue(newValue, for: .isSecureTextEntry) }
    }
}

extension UITextField {
    
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.contains(.text) {
            self.text = themeStyles.text;
        }
        
        if themeStyles.contains(.attributedText) {
            self.attributedText = themeStyles.attributedText
        }
        if themeStyles.contains(.textColor) {
            self.textColor = themeStyles.textColor
        }
        if themeStyles.contains(.font) {
            self.font = themeStyles.font
        }
        
        if themeStyles.contains(.textAlignment) {
            self.textAlignment = themeStyles.textAlignment
        }
        
        if themeStyles.contains(.borderStyle) {
            self.borderStyle = themeStyles.borderStyle
        }
        
        if themeStyles.contains(.defaultTextAttributes) {
            self.defaultTextAttributes = themeStyles.defaultTextAttributes
        }
        
        if themeStyles.contains(.placeholder) {
            self.placeholder = themeStyles.placeholderText
        }
        
        if themeStyles.contains(.attributedPlaceholder) {
            self.attributedPlaceholder = themeStyles.attributedPlaceholder
        }
        
        if themeStyles.contains(.clearsOnBeginEditing) {
            self.clearsOnBeginEditing = themeStyles.clearsOnBeginEditing
        }
        
        if themeStyles.contains(.adjustsFontSizeToFitWidth) {
            self.adjustsFontSizeToFitWidth = themeStyles.adjustsFontSizeToFitWidth
        }

        if themeStyles.contains(.minimumFontSize) {
            self.minimumFontSize = themeStyles.minimumFontSize
        }
        
        if themeStyles.contains(.background) {
            self.background = themeStyles.background
        }
        
        if themeStyles.contains(.disabledBackground) {
            self.disabledBackground = themeStyles.disabledBackground
        }
 
        if themeStyles.contains(.allowsEditingTextAttributes) {
            self.allowsEditingTextAttributes = themeStyles.allowsEditingTextAttributes
        }

        if themeStyles.contains(.typingAttributes) {
            self.typingAttributes = themeStyles.typingAttributes
        }
        
        if themeStyles.contains(.clearButtonMode) {
            self.clearButtonMode = themeStyles.clearButtonMode
        }

        if themeStyles.contains(.leftViewMode) {
            self.leftViewMode = themeStyles.leftViewMode
        }
        
        if themeStyles.contains(.rightViewMode) {
            self.rightViewMode = themeStyles.rightViewMode
        }

        if themeStyles.contains(.clearsOnInsertion) {
            self.clearsOnInsertion = themeStyles.clearsOnInsertion
        }

        
        if themeStyles.contains(.keyboardAppearance) {
            self.keyboardAppearance = themeStyles.keyboardAppearance
        }
        
        if themeStyles.contains(.keyboardType) {
            self.keyboardType = themeStyles.keyboardType
        }
        
        if themeStyles.contains(.returnKeyType) {
            self.returnKeyType = themeStyles.returnKeyType
        }
        
        if themeStyles.contains(.enablesReturnKeyAutomatically) {
            self.enablesReturnKeyAutomatically = themeStyles.enablesReturnKeyAutomatically
        }
        
        if themeStyles.contains(.isSecureTextEntry) {
            self.isSecureTextEntry = themeStyles.isSecureTextEntry
        }
        
    }
    
}
