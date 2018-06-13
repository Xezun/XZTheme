//
//  Theme+UISegmentedControl.swift
//  XZTheme
//
//  Created by mlibai on 2018/5/28.
//

import Foundation
import XZKit

extension Theme.State {
    
    /// UISegmentedControl
    public static let anySegmentedControlSegment = Theme.State.init(name: ":anySegmentedControlSegment", rawValue: UISegmentedControlSegment.any)
    /// UISegmentedControl
    public static let leftSegmentedControlSegment = Theme.State.init(name: ":leftSegmentedControlSegment", rawValue: UISegmentedControlSegment.left)
    /// UISegmentedControl
    public static let centerSegmentedControlSegment = Theme.State.init(name: ":centerSegmentedControlSegment", rawValue: UISegmentedControlSegment.center)
    /// UISegmentedControl
    public static let rightSegmentedControlSegment = Theme.State.init(name: ":rightSegmentedControlSegment", rawValue: UISegmentedControlSegment.right)
    /// UISegmentedControl
    public static let aloneSegmentedControlSegment = Theme.State.init(name: ":aloneSegmentedControlSegment", rawValue: UISegmentedControlSegment.alone)

}

extension UISegmentedControlSegment {
    
    public init?(_ themeState: Theme.State) {
        guard themeState.rawType == UISegmentedControlSegment.self else {
            return nil
        }
        self = themeState.rawValue as! UISegmentedControlSegment
    }
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
        
        for themeState in themeStyles.effectiveThemeStates + [.normal] {
            if themeState.isOptionSet {
                guard let controlState = UIControlState.init(themeState) else {
                    XZLog("Unapplied Theme.State %@ for UISegmentedControl.", themeState)
                    continue
                }
                guard let themeStyle = themeStyles.effectiveThemeStyle(forThemeState: themeState) else { continue }
                if themeStyle.containsThemeAttribute(.titleTextAttributes) {
                    setTitleTextAttributes(themeStyle.titleTextAttributes, for: controlState)
                }
            } else if themeState.children.count == 2 {
                if let segmentedControlSegment = UISegmentedControlSegment.init(themeState.children[0]) {
                    guard let barMetrics = UIBarMetrics.init(themeState.children[1]) else {
                        XZLog("Unapplied Theme.State %@ for UISegmentedControl.", themeState)
                        continue
                    }
                    guard let themeStyle = themeStyles.effectiveThemeStyle(forThemeState: themeState) else { continue }
                    if themeStyle.containsThemeAttribute(.contentPositionAdjustment) {
                        setContentPositionAdjustment(themeStyle.contentPositionAdjustment, forSegmentType: segmentedControlSegment, barMetrics: barMetrics)
                    }
                } else if let controlState = UIControlState.init(themeState) {
                    guard let barMetrics = UIBarMetrics.init(themeState.children[1]) else {
                        XZLog("Unapplied Theme.State %@ for UISegmentedControl.", themeState)
                        continue
                    }
                    guard let themeStyle = themeStyles.effectiveThemeStyle(forThemeState: themeState) else { continue }
                    if themeStyle.containsThemeAttribute(.backgroundImage) {
                        setBackgroundImage(themeStyle.backgroundImage, for: controlState, barMetrics: barMetrics)
                    }
                } else {
                    XZLog("Unapplied Theme.State %@ for UISegmentedControl.", themeState)
                }
            } else if themeState.children.count >= 3 {
                guard let leftControlState = UIControlState.init(themeState.children[0]),
                    let rightControlState = UIControlState.init(themeState.children[1]),
                    let barMetrics = UIBarMetrics.init(themeState.children[2]) else {
                        XZLog("Unapplied Theme.State %@ for UISegmentedControl.", themeState)
                        continue
                }
                guard let themeStyle = themeStyles.effectiveThemeStyle(forThemeState: themeState) else { continue }
                if themeStyle.containsThemeAttribute(.dividerImage) {
                    setDividerImage(themeStyle.dividerImage, forLeftSegmentState: leftControlState, rightSegmentState: rightControlState, barMetrics: barMetrics)
                }
            } else {
                XZLog("Unapplied Theme.State %@ for UISegmentedControl.", themeState)
            }
        }
        
    }
    
}
