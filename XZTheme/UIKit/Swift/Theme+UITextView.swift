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
        get { return boolValue(for: .isEditable) }
        set { setValue(newValue, for: .isEditable) }
    }
    
    public var isSelectable: Bool {
        get { return boolValue(for: .isSelectable) }
        set { setValue(newValue, for: .isSelectable) }
    }
    
    public var linkTextAttributes: [NSAttributedString.Key : Any]? {
        get { return stringAttributes(for: .linkTextAttributes) }
        set { setValue(newValue, for: .linkTextAttributes) }
    }
}


extension UITextView {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.contains(.text) {
            self.text = themeStyles.text
        }
        
        if themeStyles.contains(.font) {
            self.font = themeStyles.font
        }
        
        if themeStyles.contains(.textColor) {
            self.textColor = themeStyles.textColor
        }
        
        if themeStyles.contains(.textAlignment) {
            self.textAlignment = themeStyles.textAlignment
        }

        // open var selectedRange: NSRange
        
        if themeStyles.contains(.isEditable) {
            self.isEditable = themeStyles.isEditable
        }

        if themeStyles.contains(.isSelectable) {
            self.isSelectable = themeStyles.isSelectable
        }

        // open var dataDetectorTypes: UIDataDetectorTypes

        if themeStyles.contains(.allowsEditingTextAttributes) {
            self.allowsEditingTextAttributes = themeStyles.allowsEditingTextAttributes
        }
        
        if themeStyles.contains(.attributedText) {
            self.attributedText = themeStyles.attributedText
        }

        if themeStyles.contains(.typingAttributes) {
            self.typingAttributes = themeStyles.typingAttributes ?? [:]
        }

        if themeStyles.contains(.clearsOnInsertion) {
            self.clearsOnInsertion = themeStyles.clearsOnInsertion
        }

        // open var textContainerInset: UIEdgeInsets

        if themeStyles.contains(.linkTextAttributes) {
            self.linkTextAttributes = themeStyles.linkTextAttributes
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
