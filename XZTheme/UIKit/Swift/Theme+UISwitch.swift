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
        get { return color(for: .onTintColor) }
        set { setValue(newValue, for: .onTintColor) }
    }
    
    public var thumbTintColor: UIColor? {
        get { return color(for: .thumbTintColor) }
        set { setValue(newValue, for: .thumbTintColor) }
    }
    
    public var onImage: UIImage? {
        get { return image(for: .onImage) }
        set { setValue(newValue, for: .onImage) }
    }
    
    public var offImage: UIImage? {
        get { return image(for: .offImage) }
        set { setValue(newValue, for: .offImage) }
    }
    
    public var isOn: Bool {
        get { return boolValue(for: .isOn) }
        set { setValue(newValue, for: .isOn) }
    }
    
}

extension UISwitch {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.contains(.onTintColor) {
            self.onTintColor = themeStyles.onTintColor
        }
        
        if themeStyles.contains(.thumbTintColor) {
            self.thumbTintColor = themeStyles.thumbTintColor
        }
        
        if themeStyles.contains(.onImage) {
            self.onImage = themeStyles.onImage
        }
        
        if themeStyles.contains(.offImage) {
            self.offImage = themeStyles.offImage
        }
        
        if themeStyles.contains(.isOn) {
            self.isOn = themeStyles.isOn
        }
    }
    
    
}
