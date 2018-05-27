//
//  Theme+UISlider.swift
//  XZTheme
//
//  Created by mlibai on 2018/5/24.
//

import Foundation

extension Theme.Attribute {
    
    /// UISlider
    public static let isContinuous = Theme.Attribute.init("isContinuous")
    /// UISlider
    public static let minimumTrackTintColor = Theme.Attribute.init("minimumTrackTintColor")
    /// UISlider
    public static let maximumTrackTintColor = Theme.Attribute.init("maximumTrackTintColor")
    /// UISlider
    public static let thumbImage = Theme.Attribute.init("thumbImage")
    /// UISlider
    public static let minimumTrackImage = Theme.Attribute.init("minimumTrackImage")
    /// UISlider
    public static let maximumTrackImage = Theme.Attribute.init("maximumTrackImage")
    
}

extension Theme.Style {
    
    public var isContinuous: Bool {
        get { return boolValue(forThemeAttribute: .isContinuous) }
        set { setValue(newValue, forThemeAttribute: .isContinuous) }
    }
    
    public var minimumTrackTintColor: UIColor? {
        get { return color(forThemeAttribute: .minimumTrackTintColor) }
        set { setValue(newValue, forThemeAttribute: .minimumTrackTintColor) }
    }
    
    public var maximumTrackTintColor: UIColor? {
        get { return color(forThemeAttribute: .maximumTrackTintColor) }
        set { setValue(newValue, forThemeAttribute: .maximumTrackTintColor) }
    }
    
    public var thumbImage: UIImage? {
        get { return image(forThemeAttribute: .thumbImage) }
        set { setValue(newValue, forThemeAttribute: .thumbImage) }
    }
    
    public var minimumTrackImage: UIImage? {
        get { return image(forThemeAttribute: .minimumTrackImage) }
        set { setValue(newValue, forThemeAttribute: .minimumTrackImage) }
    }
    
    public var maximumTrackImage: UIImage? {
        get { return image(forThemeAttribute: .maximumTrackImage) }
        set { setValue(newValue, forThemeAttribute: .maximumTrackImage) }
    }
}


extension UISlider {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.containsThemeAttribute(.isContinuous) {
            self.isContinuous = themeStyles.isContinuous
        }
        
        if themeStyles.containsThemeAttribute(.minimumTrackTintColor) {
            self.minimumTrackTintColor = themeStyles.minimumTrackTintColor
        }
        
        if themeStyles.containsThemeAttribute(.maximumTrackTintColor) {
            self.maximumTrackTintColor = themeStyles.maximumTrackTintColor
        }
        
        for item in Theme.State.UIControlStateItems {
            guard let themeStyle = themeStyles.effectiveThemeStyle(forThemeState: item.themeState) else { continue }
            if themeStyle.containsThemeAttribute(.thumbImage) {
                self.setThumbImage(themeStyle.thumbImage, for: item.controlState)
            }
            
            if themeStyle.containsThemeAttribute(.minimumTrackImage) {
                self.setMinimumTrackImage(themeStyle.minimumTrackImage, for: item.controlState)
            }
            
            if themeStyle.containsThemeAttribute(.maximumTrackImage) {
                self.setMaximumTrackImage(themeStyle.maximumTrackImage, for: item.controlState)
            }
        }
    }
}
