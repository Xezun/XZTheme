//
//  Theme+UILabel.swift
//  XZKit
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit


extension Theme.Attribute {
    
    /// UILabel.text
    public static let text                  = Theme.Attribute.init("text");
    /// UILabel.textColor
    public static let textColor             = Theme.Attribute.init("textColor");
    /// UILabel.font
    public static let font                  = Theme.Attribute.init("font");
    /// UILabel.shadowColor
    public static let shadowColor           = Theme.Attribute.init("shadowColor");
    /// UILabel.highlightedTextColor
    public static let highlightedTextColor  = Theme.Attribute.init("highlightedTextColor");
    /// UILabel.attributedText
    public static let attributedText        = Theme.Attribute.init("attributedText");
    
}

extension Theme.Style {
    
    public var text: String? {
        get { return stringValue(forThemeAttribute: .text)  }
        set { setValue(newValue, forThemeAttribute: .text)  }
    }
    
    public var textColor: UIColor? {
        get { return color(forThemeAttribute: .textColor)       }
        set { setValue(newValue, forThemeAttribute: .textColor) }
    }
    
    public var font: UIFont? {
        get { return font(forThemeAttribute: .font)       }
        set { setValue(newValue, forThemeAttribute: .font) }
    }
    
    public var shadowColor: UIColor? {
        get { return color(forThemeAttribute: .shadowColor)        }
        set { setValue(newValue, forThemeAttribute: .shadowColor)  }
    }
    
    public var highlightedTextColor: UIColor? {
        get { return color(forThemeAttribute: .highlightedTextColor)        }
        set { setValue(newValue, forThemeAttribute: .highlightedTextColor)  }
    }
    
    public var attributedText: NSAttributedString? {
        get { return attributedString(forThemeAttribute: .attributedText)   }
        set { setValue(newValue, forThemeAttribute: .attributedText) }
    }
    
}

extension UILabel {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.containsThemeAttribute(.text) {
            self.text = themeStyles.text;
        }
        
        if themeStyles.containsThemeAttribute(.textColor) {
            self.textColor = themeStyles.textColor
        }
        
        if themeStyles.containsThemeAttribute(.font) {
            self.font = themeStyles.font
        }
        
        if themeStyles.containsThemeAttribute(.shadowColor) {
            self.shadowColor = themeStyles.shadowColor
        }
        
        if themeStyles.containsThemeAttribute(.highlightedTextColor) {
            self.highlightedTextColor = themeStyles.highlightedTextColor
        }
        
        if themeStyles.containsThemeAttribute(.attributedText) {
            self.attributedText = themeStyles.attributedText
        }
        
    }
    
}
