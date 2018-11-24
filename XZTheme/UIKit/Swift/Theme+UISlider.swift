//
//  Theme+UISlider.swift
//  XZTheme
//
//  Created by mlibai on 2018/5/24.
//

import Foundation

extension Theme.Attribute {
    
    /// UISlider
    public static let isContinuous = Theme.Attribute.init(rawValue: "isContinuous")
    /// UISlider
    public static let minimumTrackTintColor = Theme.Attribute.init(rawValue: "minimumTrackTintColor")
    /// UISlider
    public static let maximumTrackTintColor = Theme.Attribute.init(rawValue: "maximumTrackTintColor")
    /// UISlider
    public static let thumbImage = Theme.Attribute.init(rawValue: "thumbImage")
    /// UISlider
    public static let minimumTrackImage = Theme.Attribute.init(rawValue: "minimumTrackImage")
    /// UISlider
    public static let maximumTrackImage = Theme.Attribute.init(rawValue: "maximumTrackImage")
    
}

extension Theme.Style {
    
    public var isContinuous: Bool {
        get { return boolValue(for: .isContinuous) }
        set { setValue(newValue, for: .isContinuous) }
    }
    
    public var minimumTrackTintColor: UIColor? {
        get { return color(for: .minimumTrackTintColor) }
        set { setValue(newValue, for: .minimumTrackTintColor) }
    }
    
    public var maximumTrackTintColor: UIColor? {
        get { return color(for: .maximumTrackTintColor) }
        set { setValue(newValue, for: .maximumTrackTintColor) }
    }
    
    public var thumbImage: UIImage? {
        get { return image(for: .thumbImage) }
        set { setValue(newValue, for: .thumbImage) }
    }
    
    public var minimumTrackImage: UIImage? {
        get { return image(for: .minimumTrackImage) }
        set { setValue(newValue, for: .minimumTrackImage) }
    }
    
    public var maximumTrackImage: UIImage? {
        get { return image(for: .maximumTrackImage) }
        set { setValue(newValue, for: .maximumTrackImage) }
    }
}

import XZKit

extension UISlider {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.contains(.isContinuous) {
            self.isContinuous = themeStyles.isContinuous
        }
        
        if themeStyles.contains(.minimumTrackTintColor) {
            self.minimumTrackTintColor = themeStyles.minimumTrackTintColor
        }
        
        if themeStyles.contains(.maximumTrackTintColor) {
            self.maximumTrackTintColor = themeStyles.maximumTrackTintColor
        }
        
        guard let themeStates = themeStyles.statedThemeStylesIfLoaded?.keys else { return }
        for themeState in themeStates {
            guard let controlState = UIControl.State.init(themeState) else {
                XZLog("Unapplied Theme.State %@ for UISlider.", themeState)
                continue
            }
            guard let themeStyle = themeStyles.themeStyleIfLoaded(for: themeState) else { continue }
            if themeStyle.contains(.thumbImage) {
                self.setThumbImage(themeStyle.thumbImage, for: controlState)
            }
            if themeStyle.contains(.minimumTrackImage) {
                self.setMinimumTrackImage(themeStyle.minimumTrackImage, for: controlState)
            }
            if themeStyle.contains(.maximumTrackImage) {
                self.setMaximumTrackImage(themeStyle.maximumTrackImage, for: controlState)
            }
        }
    }
}
