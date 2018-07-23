//
//  Theme+UISwitch.swift
//  XZTheme
//
//  Created by mlibai on 2018/5/24.
//

import Foundation

extension Theme.Attribute {
    
    /// UISwitch
    public static let onTintColor = Theme.Attribute.init(rawValue: "onTintColor")
    /// UISwitch
    public static let thumbTintColor = Theme.Attribute.init(rawValue: "thumbTintColor")
    /// UISwitch
    public static let onImage = Theme.Attribute.init(rawValue: "onImage")
    /// UISwitch
    public static let offImage = Theme.Attribute.init(rawValue: "offImage")
    /// UISwitch
    public static let isOn = Theme.Attribute.init(rawValue: "isOn")
    
}

extension Theme.Style {
    
    public var onTintColor: UIColor? {
        get { return color(forThemeAttribute: .onTintColor) }
        set { setValue(newValue, forThemeAttribute: .onTintColor) }
    }
    
    public var thumbTintColor: UIColor? {
        get { return color(forThemeAttribute: .thumbTintColor) }
        set { setValue(newValue, forThemeAttribute: .thumbTintColor) }
    }
    
    public var onImage: UIImage? {
        get { return image(forThemeAttribute: .onImage) }
        set { setValue(newValue, forThemeAttribute: .onImage) }
    }
    
    public var offImage: UIImage? {
        get { return image(forThemeAttribute: .offImage) }
        set { setValue(newValue, forThemeAttribute: .offImage) }
    }
    
    public var isOn: Bool {
        get { return boolValue(forThemeAttribute: .isOn) }
        set { setValue(newValue, forThemeAttribute: .isOn) }
    }
    
}

extension UISwitch {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.containsThemeAttribute(.onTintColor) {
            self.onTintColor = themeStyles.onTintColor
        }
        
        if themeStyles.containsThemeAttribute(.thumbTintColor) {
            self.thumbTintColor = themeStyles.thumbTintColor
        }
        
        if themeStyles.containsThemeAttribute(.onImage) {
            self.onImage = themeStyles.onImage
        }
        
        if themeStyles.containsThemeAttribute(.offImage) {
            self.offImage = themeStyles.offImage
        }
        
        if themeStyles.containsThemeAttribute(.isOn) {
            self.isOn = themeStyles.isOn
        }
    }
    
    
}
