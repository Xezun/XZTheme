//
//  Theme+UIActivityIndicatorView.swift
//  XZTheme
//
//  Created by mlibai on 2018/5/24.
//

import Foundation
import XZKit

extension Theme.Attribute {
    
    /// UIActivityIndicatorView.hidesWhenStopped
    public static let activityIndicatorViewStyle = Theme.Attribute.init("activityIndicatorViewStyle")
    /// UIActivityIndicatorView.hidesWhenStopped
    public static let hidesWhenStopped = Theme.Attribute.init("hidesWhenStopped")
    /// UIActivityIndicatorView.color
    public static let color = Theme.Attribute.init("color")
    
}

extension Theme.Style {
    
    public func activityIndicatorViewStyle(forThemeAttribute themeAttribute: Theme.Attribute) -> UIActivityIndicatorViewStyle {
        guard let value = value(forThemeAttribute: themeAttribute) else { return .white }
        if let activityIndicatorViewStyle = value as? UIActivityIndicatorViewStyle {
            return activityIndicatorViewStyle
        }
        if let number = value as? Int, let activityIndicatorViewStyle = UIActivityIndicatorViewStyle(rawValue: number) {
            return activityIndicatorViewStyle
        }
        if let aString = value as? String {
            switch aString {
            case "white":      return .white
            case "whiteLarge": return .whiteLarge
            case "gray":       return .gray
            default: break
            }
        }
        XZLog("XZTheme: The theme style value (%@) for attribute (%@) is not a UIActivityIndicatorViewStyle value, `.white` returned.", value, themeAttribute)
        return .white
    }
    
    
    public var activityIndicatorViewStyle: UIActivityIndicatorViewStyle {
        get { return activityIndicatorViewStyle(forThemeAttribute: .activityIndicatorViewStyle) }
        set { setValue(newValue, forThemeAttribute: .activityIndicatorViewStyle) }
    }
    
    public var color: UIColor? {
        get { return color(forThemeAttribute: .color)       }
        set { setValue(newValue, forThemeAttribute: .color) }
    }
    
    public var hidesWhenStopped: Bool {
        get { return boolValue(forThemeAttribute: .hidesWhenStopped) }
        set { setValue(newValue, forThemeAttribute: .hidesWhenStopped) }
    }
    
}

extension UIActivityIndicatorView {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.containsThemeAttribute(.activityIndicatorViewStyle) {
            self.activityIndicatorViewStyle = themeStyles.activityIndicatorViewStyle
        }
        
        if themeStyles.containsThemeAttribute(.color) {
            self.color = themeStyles.color
        }
        
        if themeStyles.containsThemeAttribute(.hidesWhenStopped) {
            self.hidesWhenStopped = themeStyles.hidesWhenStopped
        }
        
        if themeStyles.containsThemeAttribute(.isAnimating) {
            if themeStyles.isAnimating {
                self.startAnimating()
            } else {
                self.stopAnimating()
            }
        }
    }
}

