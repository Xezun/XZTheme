//
//  Theme+UIProgressView.swift
//  XZTheme
//
//  Created by mlibai on 2018/5/24.
//

import Foundation
import XZKit



extension Theme.Attribute {
    
    /// UIProgressView
    public static let progressViewStyle = Theme.Attribute.init(rawValue: "progressViewStyle")
    /// UIProgressView
    public static let progress          = Theme.Attribute.init(rawValue: "progress")
    /// UIProgressView
    public static let progressTintColor = Theme.Attribute.init(rawValue: "progressTintColor")
    /// UIProgressView
    public static let trackTintColor    = Theme.Attribute.init(rawValue: "trackTintColor")
    /// UIProgressView
    public static let progressImage     = Theme.Attribute.init(rawValue: "progressImage")
    /// UIProgressView
    public static let trackImage        = Theme.Attribute.init(rawValue: "trackImage")
}

extension Theme.Style {
    
    public func progressViewStyle(forThemeAttribute themeAttribute: Theme.Attribute) -> UIProgressViewStyle {
        guard let value = value(forThemeAttribute: themeAttribute) else { return .default }
        if let progressViewStyle = value as? UIProgressViewStyle {
            return progressViewStyle
        }
        if let number = value as? Int, let progressViewStyle = UIProgressViewStyle(rawValue: number) {
            return progressViewStyle
        }
        if let aString = value as? String {
            switch aString {
            case "default": return .default
            case "bar":     return .bar
            default: break
            }
        }
        XZLog("XZTheme: The theme style value (%@) for attribute (%@) is not a UIProgressViewStyle value, `.default` returned.", value, themeAttribute)
        return .default
    }
    
    public var progressViewStyle: UIProgressViewStyle {
        get { return progressViewStyle(forThemeAttribute: .progressViewStyle) }
        set { setValue(newValue, forThemeAttribute: .progressViewStyle) }
    }
    
    public var progress: Float {
        get { return self.floatValue(forThemeAttribute: .progress) }
        set { setValue(newValue, forThemeAttribute: .progress) }
    }
    
    public var progressTintColor: UIColor? {
        get { return color(forThemeAttribute: .progressTintColor) }
        set { setValue(newValue, forThemeAttribute: .progressTintColor) }
    }
    
    public var trackTintColor: UIColor? {
        get { return color(forThemeAttribute: .trackTintColor) }
        set { setValue(newValue, forThemeAttribute: .trackTintColor) }
    }
    
    public var progressImage: UIImage? {
        get { return image(forThemeAttribute: .progressImage) }
        set { setValue(newValue, forThemeAttribute: .progressImage)}
    }
    
    public var trackImage: UIImage? {
        get { return image(forThemeAttribute: .trackImage)  }
        set { setValue(newValue, forThemeAttribute: .trackImage) }
    }
    
}

extension UIProgressView {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.containsThemeAttribute(.progressViewStyle) {
            self.progressViewStyle = themeStyles.progressViewStyle
        }
        
        if themeStyles.containsThemeAttribute(.progress) {
            self.progress = themeStyles.progress
        }
        
        if themeStyles.containsThemeAttribute(.progressTintColor) {
            self.progressTintColor = themeStyles.progressTintColor
        }
        
        if themeStyles.containsThemeAttribute(.trackTintColor) {
            self.trackTintColor = themeStyles.trackTintColor
        }
        
        if themeStyles.containsThemeAttribute(.progressImage) {
            self.progressImage = themeStyles.progressImage
        }
        
        if themeStyles.containsThemeAttribute(.trackImage) {
            self.trackImage = themeStyles.trackImage
        }

    }
    
}
