//
//  Theme+UITableView.swift
//  Pods-Example
//
//  Created by mlibai on 2018/5/3.
//

import UIKit


extension Theme.Attribute {
    
    /// UITableView.
    public static let sectionIndexColor = Theme.Attribute.init("sectionIndexColor")
    /// UITableView.sectionIndexBackgroundColor
    public static let sectionIndexBackgroundColor = Theme.Attribute.init("sectionIndexBackgroundColor")
    /// UITableView.sectionIndexTrackingBackgroundColor
    public static let sectionIndexTrackingBackgroundColor = Theme.Attribute.init("sectionIndexTrackingBackgroundColor")
    /// UITableView.separatorStyle
    public static let separatorStyle = Theme.Attribute.init("separatorStyle")
    /// UITableView.separatorColor
    public static let separatorColor = Theme.Attribute.init("separatorColor")
}

extension Theme.Style {

    public var sectionIndexColor: UIColor? {
        get { return color(forThemeAttribute: .sectionIndexColor) }
        set { setValue(newValue, forThemeAttribute: .sectionIndexColor) }
    }
    
    public var sectionIndexBackgroundColor: UIColor? {
        get { return color(forThemeAttribute: .sectionIndexBackgroundColor) }
        set { setValue(newValue, forThemeAttribute: .sectionIndexBackgroundColor) }
    }
    
    public var sectionIndexTrackingBackgroundColor: UIColor? {
        get { return color(forThemeAttribute: .sectionIndexTrackingBackgroundColor) }
        set { setValue(newValue, forThemeAttribute: .sectionIndexTrackingBackgroundColor) }
    }
    
    public var separatorStyle: UITableViewCellSeparatorStyle {
        get { return separatorStyle(forThemeAttribute: .separatorStyle)  }
        set { setValue(newValue, forThemeAttribute: .separatorStyle) }
    }
    
    public var separatorColor: UIColor? {
        get { return color(forThemeAttribute: .separatorColor) }
        set { setValue(newValue, forThemeAttribute: .separatorColor) }
    }
    
}

extension UITableView {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.containsThemeAttribute(.sectionIndexColor) {
            self.sectionIndexColor = themeStyles.sectionIndexColor
        }
        
        if themeStyles.containsThemeAttribute(.sectionIndexBackgroundColor) {
            self.sectionIndexBackgroundColor = themeStyles.sectionIndexBackgroundColor
        }
        
        if themeStyles.containsThemeAttribute(.sectionIndexTrackingBackgroundColor) {
            self.sectionIndexTrackingBackgroundColor = themeStyles.sectionIndexTrackingBackgroundColor
        }
        
        if themeStyles.containsThemeAttribute(.separatorStyle) {
            self.separatorStyle = themeStyles.separatorStyle
        }
        
        if themeStyles.containsThemeAttribute(.separatorColor) {
            self.separatorColor = themeStyles.separatorColor
        }
                
    }
    
}
