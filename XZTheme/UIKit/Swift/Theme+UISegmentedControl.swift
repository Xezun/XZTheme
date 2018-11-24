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
    public static let anySegmentedControlSegment = Theme.State.init(name: ":anySegmentedControlSegment", rawValue: UISegmentedControl.Segment.any)
    /// UISegmentedControl
    public static let leftSegmentedControlSegment = Theme.State.init(name: ":leftSegmentedControlSegment", rawValue: UISegmentedControl.Segment.left)
    /// UISegmentedControl
    public static let centerSegmentedControlSegment = Theme.State.init(name: ":centerSegmentedControlSegment", rawValue: UISegmentedControl.Segment.center)
    /// UISegmentedControl
    public static let rightSegmentedControlSegment = Theme.State.init(name: ":rightSegmentedControlSegment", rawValue: UISegmentedControl.Segment.right)
    /// UISegmentedControl
    public static let aloneSegmentedControlSegment = Theme.State.init(name: ":aloneSegmentedControlSegment", rawValue: UISegmentedControl.Segment.alone)

}

extension UISegmentedControl.Segment {
    
    public init?(_ themeState: Theme.State) {
        guard themeState.rawType == UISegmentedControl.Segment.self else {
            return nil
        }
        self = themeState.rawValue as! UISegmentedControl.Segment
    }
}

extension Theme.Attribute {
    
    /// UISegmentedControl
    public static let isMomentary = Theme.Attribute.init(rawValue: "isMomentary")
    /// UISegmentedControl
    public static let apportionsSegmentWidthsByContent = Theme.Attribute.init(rawValue: "apportionsSegmentWidthsByContent")
    /// UISegmentedControl
    public static let dividerImage = Theme.Attribute.init(rawValue: "dividerImage")
    /// UISegmentedControl
    public static let contentPositionAdjustment = Theme.Attribute.init(rawValue: "contentPositionAdjustment")
    
    
}

extension Theme.Style {

    public var isMomentary: Bool {
        get { return boolValue(for: .isMomentary)  }
        set { setValue(newValue, for: .isMomentary) }
    }
    
    public var apportionsSegmentWidthsByContent: Bool {
        get { return boolValue(for: .apportionsSegmentWidthsByContent)  }
        set { setValue(newValue, for: .apportionsSegmentWidthsByContent) }
    }
    
    public var dividerImage: UIImage? {
        get { return image(for: .dividerImage) }
        set { setValue(newValue, for: .dividerImage)}
    }
    
    public var contentPositionAdjustment: UIOffset {
        get { return offset(for: .contentPositionAdjustment) }
        set { setValue(newValue, for: .contentPositionAdjustment) }
    }
}

extension UISegmentedControl {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.contains(.isMomentary) {
            self.isMomentary = themeStyles.isMomentary
        }
        
        if themeStyles.contains(.apportionsSegmentWidthsByContent) {
            self.apportionsSegmentWidthsByContent = themeStyles.apportionsSegmentWidthsByContent
        }
        
        guard let themeStates = themeStyles.statedThemeStylesIfLoaded?.keys else { return }
        
        for themeState in themeStates {
            switch themeState.count {
            case 1:
                guard let controlState = UIControl.State.init(themeState) else {
                    XZLog("Unapplied Theme.State %@ for UISegmentedControl.", themeState)
                    continue
                }
                guard let themeStyle = themeStyles.themeStyleIfLoaded(for: themeState) else { continue }
                if themeStyle.contains(.titleTextAttributes) {
                    setTitleTextAttributes(themeStyle.titleTextAttributes, for: controlState)
                }
            case 2:
                if let segmentedControlSegment = UISegmentedControl.Segment.init(themeState[0]) {
                    guard let barMetrics = UIBarMetrics.init(themeState[1]) else {
                        XZLog("Unapplied Theme.State %@ for UISegmentedControl.", themeState)
                        continue
                    }
                    guard let themeStyle = themeStyles.themeStyleIfLoaded(for: themeState) else { continue }
                    if themeStyle.contains(.contentPositionAdjustment) {
                        setContentPositionAdjustment(themeStyle.contentPositionAdjustment, forSegmentType: segmentedControlSegment, barMetrics: barMetrics)
                    }
                } else if let controlState = UIControl.State.init(themeState) {
                    guard let barMetrics = UIBarMetrics.init(themeState[1]) else {
                        XZLog("Unapplied Theme.State %@ for UISegmentedControl.", themeState)
                        continue
                    }
                    guard let themeStyle = themeStyles.themeStyleIfLoaded(for: themeState) else { continue }
                    if themeStyle.contains(.backgroundImage) {
                        setBackgroundImage(themeStyle.backgroundImage, for: controlState, barMetrics: barMetrics)
                    }
                } else {
                    XZLog("Unapplied Theme.State %@ for UISegmentedControl.", themeState)
                }
            default:
                guard let leftControlState = UIControl.State.init(themeState[0]),
                    let rightControlState = UIControl.State.init(themeState[1]),
                    let barMetrics = UIBarMetrics.init(themeState[2]) else {
                        XZLog("Unapplied Theme.State %@ for UISegmentedControl.", themeState)
                        continue
                }
                guard let themeStyle = themeStyles.themeStyleIfLoaded(for: themeState) else { continue }
                if themeStyle.contains(.dividerImage) {
                    setDividerImage(themeStyle.dividerImage, forLeftSegmentState: leftControlState, rightSegmentState: rightControlState, barMetrics: barMetrics)
                }
            }
        }
        
    }
    
}
