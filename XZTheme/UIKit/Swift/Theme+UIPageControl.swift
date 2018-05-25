//
//  Theme+UIPageControl.swift
//  XZTheme
//
//  Created by mlibai on 2018/5/24.
//

import Foundation

extension Theme.Attribute {
    
    /// UIPageControl.numberOfPages
    public static let numberOfPages = Theme.Attribute.init("numberOfPages")
    /// UIPageControl.currentPage
    public static let currentPage = Theme.Attribute.init("currentPage")
    /// UIPageControl.hidesForSinglePage
    public static let hidesForSinglePage = Theme.Attribute.init("hidesForSinglePage")
    /// UIPageControl.defersCurrentPageDisplay
    public static let defersCurrentPageDisplay = Theme.Attribute.init("defersCurrentPageDisplay")
    /// UIPageControl.pageIndicatorTintColor
    public static let pageIndicatorTintColor = Theme.Attribute.init("pageIndicatorTintColor")
    /// UIPageControl.currentPageIndicatorTintColor
    public static let currentPageIndicatorTintColor = Theme.Attribute.init("currentPageIndicatorTintColor")

}

extension Theme.Style {
    
    public var numberOfPages: Int {
        get { return integerValue(forThemeAttribute: .numberOfPages)  }
        set { setValue(newValue, forThemeAttribute: .numberOfPages) }
    }
    public var currentPage: Int {
        get { return integerValue(forThemeAttribute: .currentPage)  }
        set { setValue(newValue, forThemeAttribute: .currentPage) }
    }
    
    public var hidesForSinglePage: Bool {
        get { return boolValue(forThemeAttribute: .hidesForSinglePage)  }
        set { setValue(newValue, forThemeAttribute: .hidesForSinglePage) }
    }
    public var defersCurrentPageDisplay: Bool {
        get { return boolValue(forThemeAttribute: .defersCurrentPageDisplay)  }
        set { setValue(newValue, forThemeAttribute: .defersCurrentPageDisplay) }
    }
    
    public var pageIndicatorTintColor: UIColor? {
        get { return color(forThemeAttribute: .pageIndicatorTintColor) }
        set { setValue(newValue, forThemeAttribute: .pageIndicatorTintColor) }
    }
    
    public var currentPageIndicatorTintColor: UIColor? {
        get { return color(forThemeAttribute: .currentPageIndicatorTintColor) }
        set { setValue(newValue, forThemeAttribute: .currentPageIndicatorTintColor) }
    }
    
}

extension UIPageControl {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.containsThemeAttribute(.numberOfPages) {
            self.numberOfPages = themeStyles.numberOfPages
        }
        
        if themeStyles.containsThemeAttribute(.currentPage) {
            self.currentPage = themeStyles.currentPage
        }
        
        if themeStyles.containsThemeAttribute(.hidesForSinglePage) {
            self.hidesForSinglePage = themeStyles.hidesForSinglePage
        }
        
        if themeStyles.containsThemeAttribute(.defersCurrentPageDisplay) {
            self.defersCurrentPageDisplay = themeStyles.defersCurrentPageDisplay
        }
        
        if themeStyles.containsThemeAttribute(.pageIndicatorTintColor) {
            self.pageIndicatorTintColor = themeStyles.pageIndicatorTintColor
        }
        
        if themeStyles.containsThemeAttribute(.currentPageIndicatorTintColor) {
            self.currentPageIndicatorTintColor = themeStyles.currentPageIndicatorTintColor
        }
        
    }
    
}
