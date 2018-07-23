//
//  Theme+UITextView.swift
//  XZTheme
//
//  Created by mlibai on 2018/5/24.
//

import Foundation

extension Theme.Attribute {
    
    /// UITextView
    public static let isEditable = Theme.Attribute.init(rawValue: "isEditable")
    /// UITextView
    public static let isSelectable = Theme.Attribute.init(rawValue: "isSelectable")
    /// UITextView
    public static let linkTextAttributes = Theme.Attribute.init(rawValue: "linkTextAttributes")
}

extension Theme.Style {
    
    public var isEditable: Bool {
        get { return boolValue(forThemeAttribute: .isEditable) }
        set { setValue(newValue, forThemeAttribute: .isEditable) }
    }
    
    public var isSelectable: Bool {
        get { return boolValue(forThemeAttribute: .isSelectable) }
        set { setValue(newValue, forThemeAttribute: .isSelectable) }
    }
    
    public var linkTextAttributes: [String : Any]? {
        get { return stringAttributes(forThemeAttribute: .linkTextAttributes) }
        set { setValue(newValue, forThemeAttribute: .linkTextAttributes) }
    }
}


extension UITextView {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.containsThemeAttribute(.text) {
            self.text = themeStyles.text
        }
        
        if themeStyles.containsThemeAttribute(.font) {
            self.font = themeStyles.font
        }
        
        if themeStyles.containsThemeAttribute(.textColor) {
            self.textColor = themeStyles.textColor
        }
        
        if themeStyles.containsThemeAttribute(.textAlignment) {
            self.textAlignment = themeStyles.textAlignment
        }

        // open var selectedRange: NSRange
        
        if themeStyles.containsThemeAttribute(.isEditable) {
            self.isEditable = themeStyles.isEditable
        }

        if themeStyles.containsThemeAttribute(.isSelectable) {
            self.isSelectable = themeStyles.isSelectable
        }

        // open var dataDetectorTypes: UIDataDetectorTypes

        if themeStyles.containsThemeAttribute(.allowsEditingTextAttributes) {
            self.allowsEditingTextAttributes = themeStyles.allowsEditingTextAttributes
        }
        
        if themeStyles.containsThemeAttribute(.attributedText) {
            self.attributedText = themeStyles.attributedText
        }

        if themeStyles.containsThemeAttribute(.typingAttributes) {
            self.typingAttributes = themeStyles.typingAttributes ?? [:]
        }

        if themeStyles.containsThemeAttribute(.clearsOnInsertion) {
            self.clearsOnInsertion = themeStyles.clearsOnInsertion
        }

        // open var textContainerInset: UIEdgeInsets

        if themeStyles.containsThemeAttribute(.linkTextAttributes) {
            self.linkTextAttributes = themeStyles.linkTextAttributes
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
