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
    
    public func progressViewStyle(for themeAttribute: Theme.Attribute) -> UIProgressViewStyle {
        guard let value = value(for: themeAttribute) else { return .default }
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
        get { return progressViewStyle(for: .progressViewStyle) }
        set { setValue(newValue, for: .progressViewStyle) }
    }
    
    public var progress: Float {
        get { return self.floatValue(for: .progress) }
        set { setValue(newValue, for: .progress) }
    }
    
    public var progressTintColor: UIColor? {
        get { return color(for: .progressTintColor) }
        set { setValue(newValue, for: .progressTintColor) }
    }
    
    public var trackTintColor: UIColor? {
        get { return color(for: .trackTintColor) }
        set { setValue(newValue, for: .trackTintColor) }
    }
    
    public var progressImage: UIImage? {
        get { return image(for: .progressImage) }
        set { setValue(newValue, for: .progressImage)}
    }
    
    public var trackImage: UIImage? {
        get { return image(for: .trackImage)  }
        set { setValue(newValue, for: .trackImage) }
    }
    
}

extension UIProgressView {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.contains(.progressViewStyle) {
            self.progressViewStyle = themeStyles.progressViewStyle
        }
        
        if themeStyles.contains(.progress) {
            self.progress = themeStyles.progress
        }
        
        if themeStyles.contains(.progressTintColor) {
            self.progressTintColor = themeStyles.progressTintColor
        }
        
        if themeStyles.contains(.trackTintColor) {
            self.trackTintColor = themeStyles.trackTintColor
        }
        
        if themeStyles.contains(.progressImage) {
            self.progressImage = themeStyles.progressImage
        }
        
        if themeStyles.contains(.trackImage) {
            self.trackImage = themeStyles.trackImage
        }

    }
    
}
