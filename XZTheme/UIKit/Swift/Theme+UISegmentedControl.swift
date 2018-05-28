//
//  Theme+UISegmentedControl.swift
//  XZTheme
//
//  Created by mlibai on 2018/5/28.
//

import Foundation

extension Theme.State {
    
    public static let UIControlStateLeftRightUIBarMetricsItems: [(themeState: Theme.State, leftControlState: UIControlState, rightControlState: UIControlState,  barMetrics: UIBarMetrics)] = {
        var items: [(themeState: Theme.State, leftControlState: UIControlState, rightControlState: UIControlState,  barMetrics: UIBarMetrics)] = []
        for left in Theme.State.UIControlStateItems {
            for right in Theme.State.UIControlStateItems {
                for bar in Theme.State.UIBarMetricsItems {
                    items.append((
                        themeState: [left.themeState, right.themeState, bar.themeState],
                        leftControlState: left.controlState,
                        rightControlState: right.controlState,
                        barMetrics: bar.barMetrics
                    ))
                }
            }
        }
        return items
    } ()
    
    public static let UIControlStateUIBarMetricsItems: [(themeState: Theme.State, controlState: UIControlState, barMetrics: UIBarMetrics)] = {
        var items: [(themeState: Theme.State, controlState: UIControlState, barMetrics: UIBarMetrics)] = [
            ([.normal, .defaultBarMetrics], .normal, .default), ([.normal, .compactBarMetrics], .normal, .compact),
            ([.normal, .defaultPromptBarMetrics], .normal, .defaultPrompt), ([.normal, .compactPromptBarMetrics], .normal, .compactPrompt),
            
            ([.selected, .defaultBarMetrics], .selected, .default), ([.selected, .compactBarMetrics], .selected, .compact),
            ([.selected, .defaultPromptBarMetrics], .selected, .defaultPrompt), ([.selected, .compactPromptBarMetrics], .selected, .compactPrompt),
            
            ([.highlighted, .defaultBarMetrics], .highlighted, .default), ([.highlighted, .compactBarMetrics], .highlighted, .compact),
            ([.highlighted, .defaultPromptBarMetrics], .highlighted, .defaultPrompt), ([.highlighted, .compactPromptBarMetrics], .highlighted, .compactPrompt),
            
            ([.disabled, .defaultBarMetrics], .disabled, .default), ([.disabled, .compactBarMetrics], .disabled, .compact),
            ([.disabled, .defaultPromptBarMetrics], .disabled, .defaultPrompt), ([.disabled, .compactPromptBarMetrics], .disabled, .compactPrompt),
        ]
        if #available(iOS 9.0, *) {
            items.append(([.focused, .defaultBarMetrics], .focused, .default))
            items.append(([.focused, .compactBarMetrics], .focused, .compact))
            items.append(([.focused, .defaultPromptBarMetrics], .focused, .defaultPrompt))
            items.append(([.focused, .compactPromptBarMetrics], .focused, .compactPrompt))
        }
        return items
    }()
    
    
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
    
    
    public static let UISegmentedControlSegmentUIBarMetricsItems: [(themeState: Theme.State, segmentedControlSegment: UISegmentedControlSegment, barMetrics: UIBarMetrics)] = [
        ([anySegmentedControlSegment, .defaultBarMetrics], .any, .default), ([anySegmentedControlSegment, .compactBarMetrics], .any, .compact),
        ([anySegmentedControlSegment, .defaultPromptBarMetrics], .any, .defaultPrompt), ([anySegmentedControlSegment, .compactPromptBarMetrics], .any, .compactPrompt),
        
        ([leftSegmentedControlSegment, .defaultBarMetrics], .left, .default), ([leftSegmentedControlSegment, .compactBarMetrics], .left, .compact),
        ([leftSegmentedControlSegment, .defaultPromptBarMetrics], .left, .defaultPrompt), ([leftSegmentedControlSegment, .compactPromptBarMetrics], .left, .compactPrompt),
        
        ([centerSegmentedControlSegment, .defaultBarMetrics], .center, .default), ([centerSegmentedControlSegment, .compactBarMetrics], .center, .compact),
        ([centerSegmentedControlSegment, .defaultPromptBarMetrics], .center, .defaultPrompt), ([centerSegmentedControlSegment, .compactPromptBarMetrics], .center, .compactPrompt),
        
        ([rightSegmentedControlSegment, .defaultBarMetrics], .right, .default), ([rightSegmentedControlSegment, .compactBarMetrics], .right, .compact),
        ([rightSegmentedControlSegment, .defaultPromptBarMetrics], .right, .defaultPrompt), ([rightSegmentedControlSegment, .compactPromptBarMetrics], .right, .compactPrompt),
        
        ([aloneSegmentedControlSegment, .defaultBarMetrics], .alone, .default), ([aloneSegmentedControlSegment, .compactBarMetrics], .alone, .compact),
        ([aloneSegmentedControlSegment, .defaultPromptBarMetrics], .alone, .defaultPrompt), ([aloneSegmentedControlSegment, .compactPromptBarMetrics], .alone, .compactPrompt)
    ]
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
