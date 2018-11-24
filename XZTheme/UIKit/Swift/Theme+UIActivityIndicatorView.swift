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
    public static let activityIndicatorViewStyle = Theme.Attribute.init(rawValue: "activityIndicatorViewStyle")
    /// UIActivityIndicatorView.hidesWhenStopped
    public static let hidesWhenStopped = Theme.Attribute.init(rawValue: "hidesWhenStopped")
    /// UIActivityIndicatorView.color
    public static let color = Theme.Attribute.init(rawValue: "color")
    
}

extension Theme.Style {
    
    public func activityIndicatorViewStyle(for themeAttribute: Theme.Attribute) -> UIActivityIndicatorView.Style {
        guard let value = value(for: themeAttribute) else { return .white }
        if let activityIndicatorViewStyle = value as? UIActivityIndicatorView.Style {
            return activityIndicatorViewStyle
        }
        if let number = value as? Int, let activityIndicatorViewStyle = UIActivityIndicatorView.Style(rawValue: number) {
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
    
    
    public var activityIndicatorViewStyle: UIActivityIndicatorView.Style {
        get { return activityIndicatorViewStyle(for: .activityIndicatorViewStyle) }
        set { setValue(newValue, for: .activityIndicatorViewStyle) }
    }
    
    public var color: UIColor? {
        get { return color(for: .color)       }
        set { setValue(newValue, for: .color) }
    }
    
    public var hidesWhenStopped: Bool {
        get { return boolValue(for: .hidesWhenStopped) }
        set { setValue(newValue, for: .hidesWhenStopped) }
    }
    
}

extension UIActivityIndicatorView {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.contains(.activityIndicatorViewStyle) {
            self.style = themeStyles.activityIndicatorViewStyle
        }
        
        if themeStyles.contains(.color) {
            self.color = themeStyles.color
        }
        
        if themeStyles.contains(.hidesWhenStopped) {
            self.hidesWhenStopped = themeStyles.hidesWhenStopped
        }
        
        if themeStyles.contains(.isAnimating) {
            if themeStyles.isAnimating {
                self.startAnimating()
            } else {
                self.stopAnimating()
            }
        }
    }
}

