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
    public static let textAlignment                 = Theme.Attribute.init("textAlignment")
    /// UITextField
    public static let borderStyle                   = Theme.Attribute.init("borderStyle")
    /// UITextField
    public static let defaultTextAttributes         = Theme.Attribute.init("defaultTextAttributes")
    /// UITextField
    public static let attributedPlaceholder         = Theme.Attribute.init("attributedPlaceholder")
    /// UITextField
    public static let clearsOnBeginEditing          = Theme.Attribute.init("clearsOnBeginEditing")
    /// UITextField, UILabel
    public static let adjustsFontSizeToFitWidth     = Theme.Attribute.init("adjustsFontSizeToFitWidth")
    /// UITextField
    public static let minimumFontSize               = Theme.Attribute.init("minimumFontSize")
    /// UITextField
    public static let background                    = Theme.Attribute.init("background")
    /// UITextField
    public static let disabledBackground            = Theme.Attribute.init("disabledBackground")
    /// UITextField
    public static let allowsEditingTextAttributes   = Theme.Attribute.init("allowsEditingTextAttributes")
    /// UITextField
    public static let typingAttributes              = Theme.Attribute.init("typingAttributes")
    /// UITextField
    public static let clearButtonMode               = Theme.Attribute.init("clearButtonMode")
    /// UITextField
    public static let leftViewMode                  = Theme.Attribute.init("leftViewMode")
    /// UITextField
    public static let rightViewMode                 = Theme.Attribute.init("rightViewMode")
    /// UITextField
    public static let clearsOnInsertion             = Theme.Attribute.init("clearsOnInsertion")
    
    /// UITextField
    public static let keyboardAppearance            = Theme.Attribute.init("keyboardAppearance")
    /// UITextField
    public static let keyboardType                  = Theme.Attribute.init("keyboardType")
    /// UITextField
    public static let returnKeyType                 = Theme.Attribute.init("returnKeyType")
    /// UITextField
    public static let enablesReturnKeyAutomatically = Theme.Attribute.init("enablesReturnKeyAutomatically")
    /// UITextField
    public static let isSecureTextEntry             = Theme.Attribute.init("isSecureTextEntry")
}

extension Theme.Style {

    public func textAlignment(forThemeAttribute themeAttribute: Theme.Attribute) -> NSTextAlignment {
        guard let value = self.value(forThemeAttribute: .keyboardAppearance) else { return .natural }
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
        XZLog("XZTheme: The theme style value (%@) for attribute (%@) is not a UIKeyboardAppearance value, `.default` returned.", value, themeAttribute)
        return .default;
    }
    
    public func textBorderStyle(forThemeAttribute themeAttribute: Theme.Attribute) -> UITextBorderStyle {
        guard let value = self.value(forThemeAttribute: .keyboardAppearance) else { return .none }
        if let textBorderStyle = value as? UITextBorderStyle {
            return textBorderStyle
        }
        if let number = value as? Int, let textBorderStyle = UITextBorderStyle.init(rawValue: number) {
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
    
    public func textFieldViewMode(forThemeAttribute themeAttribute: Theme.Attribute) -> UITextFieldViewMode {
        guard let value = self.value(forThemeAttribute: .keyboardAppearance) else { return .always }
        if let textBorderStyle = value as? UITextFieldViewMode {
            return textBorderStyle
        }
        if let number = value as? Int, let textBorderStyle = UITextFieldViewMode.init(rawValue: number) {
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
        get { return textAlignment(forThemeAttribute: .textAlignment)  }
        set { setValue(newValue, forThemeAttribute: .textAlignment) }
    }
    
    //open var text: String?
    //var attributedText: NSAttributedString?
    //open var textColor: UIColor?
    //open var font: UIFont?
    //open var textAlignment: NSTextAlignment
    
    public var borderStyle: UITextBorderStyle {
        get { return textBorderStyle(forThemeAttribute: .borderStyle) }
        set { setValue(newValue, forThemeAttribute: .borderStyle) }
    }
    
    open var defaultTextAttributes: [String : Any] {
        get { return stringAttributes(forThemeAttribute: .defaultTextAttributes) ?? [:] }
        set { setValue(newValue, forThemeAttribute: .defaultTextAttributes) }
    }
    
    /// /// 该属性对应的主题属性为 `.placeholder` 。
    public var placeholderText: String? {
        get { return stringValue(forThemeAttribute: .placeholder) }
        set { setValue(newValue, forThemeAttribute: .placeholder) }
    }
    
    public var attributedPlaceholder: NSAttributedString? {
        get { return attributedString(forThemeAttribute: .attributedPlaceholder) }
        set { setValue(newValue, forThemeAttribute: .attributedPlaceholder) }
    }
    
    public var clearsOnBeginEditing: Bool {
        get { return boolValue(forThemeAttribute: .clearsOnBeginEditing) }
        set { setValue(newValue, forThemeAttribute: .clearsOnBeginEditing) }
    }
    
    public var adjustsFontSizeToFitWidth: Bool {
        get { return boolValue(forThemeAttribute: .adjustsFontSizeToFitWidth) }
        set { setValue(newValue, forThemeAttribute: .adjustsFontSizeToFitWidth) }
    }
    
    public var minimumFontSize: CGFloat {
        get { return floatValue(forThemeAttribute: .minimumFontSize) }
        set { setValue(newValue, forThemeAttribute: .minimumFontSize) }
    }
    
    public var background: UIImage? {
        get { return image(forThemeAttribute: .background) }
        set { setValue(newValue, forThemeAttribute: .background) }
    }
    
    public var disabledBackground: UIImage? {
        get { return image(forThemeAttribute: .disabledBackground) }
        set { setValue(newValue, forThemeAttribute: .disabledBackground) }
    }
    
    public var allowsEditingTextAttributes: Bool {
        get { return boolValue(forThemeAttribute: .allowsEditingTextAttributes) }
        set { setValue(newValue, forThemeAttribute: .allowsEditingTextAttributes) }
    }
    
    public var typingAttributes: [String : Any]? {
        get { return stringAttributes(forThemeAttribute: .typingAttributes) }
        set { setValue(newValue, forThemeAttribute: .typingAttributes) }
    }
    
    public var clearButtonMode: UITextFieldViewMode {
        get { return textFieldViewMode(forThemeAttribute: .clearButtonMode) }
        set { setValue(newValue, forThemeAttribute: .clearButtonMode) }
    }
    
    public var leftViewMode: UITextFieldViewMode {
        get { return textFieldViewMode(forThemeAttribute: .leftViewMode) }
        set { setValue(newValue, forThemeAttribute: .leftViewMode) }
    }
    
    public var rightViewMode: UITextFieldViewMode {
        get { return textFieldViewMode(forThemeAttribute: .rightViewMode) }
        set { setValue(newValue, forThemeAttribute: .rightViewMode) }
    }
    
    public var clearsOnInsertion: Bool {
        get { return boolValue(forThemeAttribute: .clearsOnInsertion) }
        set { setValue(newValue, forThemeAttribute: .clearsOnInsertion) }
    }
    
    
    
    public func keyboardType(forThemeAttribute themeAttribute: Theme.Attribute) -> UIKeyboardType {
        guard let value = self.value(forThemeAttribute: .keyboardAppearance) else { return .`default` }
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
    
    public func returnKeyType(forThemeAttribute themeAttribute: Theme.Attribute) -> UIReturnKeyType {
        guard let value = self.value(forThemeAttribute: .keyboardAppearance) else { return .`default` }
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
        get { return keyboardAppearance(forThemeAttribute: .keyboardAppearance) }
        set { setValue(newValue, forThemeAttribute: .keyboardAppearance) }
    }
    
    public var keyboardType: UIKeyboardType {
        get { return keyboardType(forThemeAttribute: .keyboardType) }
        set { setValue(newValue, forThemeAttribute: .keyboardType) }
    }
    
    /// UITextField
    public var returnKeyType: UIReturnKeyType {
        get { return returnKeyType(forThemeAttribute: .returnKeyType) }
        set { setValue(newValue, forThemeAttribute: .returnKeyType) }
    }
    
    /// UITextField
    public var enablesReturnKeyAutomatically: Bool {
        get { return boolValue(forThemeAttribute: .enablesReturnKeyAutomatically) }
        set { setValue(newValue, forThemeAttribute: .enablesReturnKeyAutomatically) }
    }
    
    /// UITextField
    public var isSecureTextEntry: Bool {
        get { return boolValue(forThemeAttribute: .isSecureTextEntry) }
        set { setValue(newValue, forThemeAttribute: .isSecureTextEntry) }
    }
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
        
        if themeStyles.containsThemeAttribute(.textAlignment) {
            self.textAlignment = themeStyles.textAlignment
        }
        
        if themeStyles.containsThemeAttribute(.borderStyle) {
            self.borderStyle = themeStyles.borderStyle
        }
        
        if themeStyles.containsThemeAttribute(.defaultTextAttributes) {
            self.defaultTextAttributes = themeStyles.defaultTextAttributes
        }
        
        if themeStyles.containsThemeAttribute(.placeholder) {
            self.placeholder = themeStyles.placeholderText
        }
        
        if themeStyles.containsThemeAttribute(.attributedPlaceholder) {
            self.attributedPlaceholder = themeStyles.attributedPlaceholder
        }
        
        if themeStyles.containsThemeAttribute(.clearsOnBeginEditing) {
            self.clearsOnBeginEditing = themeStyles.clearsOnBeginEditing
        }
        
        if themeStyles.containsThemeAttribute(.adjustsFontSizeToFitWidth) {
            self.adjustsFontSizeToFitWidth = themeStyles.adjustsFontSizeToFitWidth
        }

        if themeStyles.containsThemeAttribute(.minimumFontSize) {
            self.minimumFontSize = themeStyles.minimumFontSize
        }
        
        if themeStyles.containsThemeAttribute(.background) {
            self.background = themeStyles.background
        }
        
        if themeStyles.containsThemeAttribute(.disabledBackground) {
            self.disabledBackground = themeStyles.disabledBackground
        }
 
        if themeStyles.containsThemeAttribute(.allowsEditingTextAttributes) {
            self.allowsEditingTextAttributes = themeStyles.allowsEditingTextAttributes
        }

        if themeStyles.containsThemeAttribute(.typingAttributes) {
            self.typingAttributes = themeStyles.typingAttributes
        }
        
        if themeStyles.containsThemeAttribute(.clearButtonMode) {
            self.clearButtonMode = themeStyles.clearButtonMode
        }

        if themeStyles.containsThemeAttribute(.leftViewMode) {
            self.leftViewMode = themeStyles.leftViewMode
        }
        
        if themeStyles.containsThemeAttribute(.rightViewMode) {
            self.rightViewMode = themeStyles.rightViewMode
        }

        if themeStyles.containsThemeAttribute(.clearsOnInsertion) {
            self.clearsOnInsertion = themeStyles.clearsOnInsertion
        }

        
        if themeStyles.containsThemeAttribute(.keyboardAppearance) {
            self.keyboardAppearance = themeStyles.keyboardAppearance
        }
        
        if themeStyles.containsThemeAttribute(.keyboardType) {
            self.keyboardType = themeStyles.keyboardType
        }
        
        if themeStyles.containsThemeAttribute(.returnKeyType) {
            self.returnKeyType = themeStyles.returnKeyType
        }
        
        if themeStyles.containsThemeAttribute(.enablesReturnKeyAutomatically) {
            self.enablesReturnKeyAutomatically = themeStyles.enablesReturnKeyAutomatically
        }
        
        if themeStyles.containsThemeAttribute(.isSecureTextEntry) {
            self.isSecureTextEntry = themeStyles.isSecureTextEntry
        }
        
    }
    
}
