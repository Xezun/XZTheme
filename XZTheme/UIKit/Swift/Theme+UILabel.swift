//
//  Theme+UILabel.swift
//  XZKit
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit


extension Theme.Attribute {
    
    /// UILabel, UISearchBar
    public static let text                  = Theme.Attribute.init(rawValue: "text");
    /// UILabel.textColor
    public static let textColor             = Theme.Attribute.init(rawValue: "textColor");
    /// UILabel.font
    public static let font                  = Theme.Attribute.init(rawValue: "font");
    /// UILabel.shadowColor
    public static let shadowColor           = Theme.Attribute.init(rawValue: "shadowColor");
    /// UILabel.highlightedTextColor
    public static let highlightedTextColor  = Theme.Attribute.init(rawValue: "highlightedTextColor");
    /// UILabel.attributedText
    public static let attributedText        = Theme.Attribute.init(rawValue: "attributedText");
    
}

extension Theme.Style {
    
    public var text: String? {
        get { return stringValue(for: .text)  }
        set { setValue(newValue, for: .text)  }
    }
    
    public var textColor: UIColor? {
        get { return color(for: .textColor)       }
        set { setValue(newValue, for: .textColor) }
    }
    
    public var font: UIFont? {
        get { return font(for: .font)       }
        set { setValue(newValue, for: .font) }
    }
    
    public var shadowColor: UIColor? {
        get { return color(for: .shadowColor)        }
        set { setValue(newValue, for: .shadowColor)  }
    }
    
    public var highlightedTextColor: UIColor? {
        get { return color(for: .highlightedTextColor)        }
        set { setValue(newValue, for: .highlightedTextColor)  }
    }
    
    public var attributedText: NSAttributedString? {
        get { return attributedString(for: .attributedText)   }
        set { setValue(newValue, for: .attributedText) }
    }
    
}

extension UILabel {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.contains(.text) {
            self.text = themeStyles.text;
        }
        
        if themeStyles.contains(.textColor) {
            self.textColor = themeStyles.textColor
        }
        
        if themeStyles.contains(.font) {
            self.font = themeStyles.font
        }
        
        if themeStyles.contains(.shadowColor) {
            self.shadowColor = themeStyles.shadowColor
        }
        
        if themeStyles.contains(.highlightedTextColor) {
            self.highlightedTextColor = themeStyles.highlightedTextColor
        }
        
        if themeStyles.contains(.attributedText) {
            self.attributedText = themeStyles.attributedText
        }
        
        if themeStyles.contains(.adjustsFontSizeToFitWidth) {
            self.adjustsFontSizeToFitWidth = themeStyles.adjustsFontSizeToFitWidth
        }
        
    }
    
}
