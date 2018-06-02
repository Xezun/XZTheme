//
//  Theme+UISegmentedControl.swift
//  XZTheme
//
//  Created by mlibai on 2018/5/28.
//

import Foundation

extension Theme.State {
    
    /// UISegmentedControl
    public static let anySegmentedControlSegment = Theme.State.init(rawValue: ":anySegmentedControlSegment")
    /// UISegmentedControl
    public static let leftSegmentedControlSegment = Theme.State.init(rawValue: ":leftSegmentedControlSegment")
    /// UISegmentedControl
    public static let centerSegmentedControlSegment = Theme.State.init(rawValue: ":centerSegmentedControlSegment")
    /// UISegmentedControl
    public static let rightSegmentedControlSegment = Theme.State.init(rawValue: ":rightSegmentedControlSegment")
    /// UISegmentedControl
    public static let aloneSegmentedControlSegment = Theme.State.init(rawValue: ":aloneSegmentedControlSegment")

}

extension Theme.Attribute {
    
    /// UISegmentedControl
    public static let isMomentary = Theme.Attribute.init("isMomentary")
    /// UISegmentedControl
    public static let apportionsSegmentWidthsByContent = Theme.Attribute.init("apportionsSegmentWidthsByContent")
    /// UISegmentedControl
    public static let dividerImage = Theme.Attribute.init("dividerImage")
    /// UISegmentedControl
    public static let contentPositionAdjustment = Theme.Attribute.init("contentPositionAdjustment")
    
    
}

extension Theme.Style {

    public var isMomentary: Bool {
        get { return boolValue(forThemeAttribute: .isMomentary)  }
        set { setValue(newValue, forThemeAttribute: .isMomentary) }
    }
    
    public var apportionsSegmentWidthsByContent: Bool {
        get { return boolValue(forThemeAttribute: .apportionsSegmentWidthsByContent)  }
        set { setValue(newValue, forThemeAttribute: .apportionsSegmentWidthsByContent) }
    }
    
    public var dividerImage: UIImage? {
        get { return image(forThemeAttribute: .dividerImage) }
        set { setValue(newValue, forThemeAttribute: .dividerImage)}
    }
    
    public var contentPositionAdjustment: UIOffset {
        get { return offset(forThemeAttribute: .contentPositionAdjustment) }
        set { setValue(newValue, forThemeAttribute: .contentPositionAdjustment) }
    }
}

extension UISegmentedControl {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.containsThemeAttribute(.isMomentary) {
            self.isMomentary = themeStyles.isMomentary
        }
        
        if themeStyles.containsThemeAttribute(.apportionsSegmentWidthsByContent) {
            self.apportionsSegmentWidthsByContent = themeStyles.apportionsSegmentWidthsByContent
        }
        
        
        for themeState in themeStyles.effectiveThemeStates {
            guard let controlState = UIControlState.init(themeState) else {
                XZLog("Unapplied Theme.State %@ for UITabBarItem.", themeState)
                continue
            }
            guard let themeStyle = themeStyles.effectiveThemeStyle(forThemeState: themeState) else { continue }
            
            if themeStyle.containsThemeAttribute(.titleTextAttributes) {
                setTitleTextAttributes(themeStyle.titleTextAttributes, for: controlState)
            }
        }
        
        
        
        for item in Theme.State.UIControlStateUIBarMetricsItems {
            guard let themeStyle = themeStyles.effectiveThemeStyle(forThemeState: item.themeState) else { continue }
            if themeStyle.containsThemeAttribute(.backgroundImage) {
                setBackgroundImage(themeStyle.backgroundImage, for: item.controlState, barMetrics: item.barMetrics)
            }
        }

        for item in Theme.State.UIControlStateLeftRightUIBarMetricsItems {
            guard let themeStyle = themeStyles.effectiveThemeStyle(forThemeState: item.themeState) else { continue }
            if themeStyle.containsThemeAttribute(.dividerImage) {
                setDividerImage(themeStyle.dividerImage, forLeftSegmentState: item.leftControlState, rightSegmentState: item.rightControlState, barMetrics: item.barMetrics)
            }
        }
        

        
        for item in Theme.State.UIControlStateItems {
            guard let themeStyle = themeStyles.effectiveThemeStyle(forThemeState: item.themeState) else { continue }
            if themeStyle.containsThemeAttribute(.titleTextAttributes) {
                setTitleTextAttributes(themeStyle.titleTextAttributes, for: item.controlState)
            }
        
        }
        
        for item in Theme.State.UISegmentedControlSegmentUIBarMetricsItems {
            guard let themeStyle = themeStyles.effectiveThemeStyle(forThemeState: item.themeState) else { continue }
            if themeStyle.containsThemeAttribute(.contentPositionAdjustment) {
                setContentPositionAdjustment(themeStyle.contentPositionAdjustment, forSegmentType: item.segmentedControlSegment, barMetrics: item.barMetrics)
            }
        }

    }
    
}
