//
//  Theme+UIPageControl.swift
//  XZTheme
//
//  Created by mlibai on 2018/5/24.
//

import Foundation

extension Theme.Attribute {
    
    /// UIPageControl
    public static let numberOfPages                 = Theme.Attribute.init(rawValue: "numberOfPages")
    /// UIPageControl.currentPage
    public static let currentPage                   = Theme.Attribute.init(rawValue: "currentPage")
    /// UIPageControl
    public static let hidesForSinglePage            = Theme.Attribute.init(rawValue: "hidesForSinglePage")
    /// UIPageControl
    public static let defersCurrentPageDisplay      = Theme.Attribute.init(rawValue: "defersCurrentPageDisplay")
    /// UIPageControl
    public static let pageIndicatorTintColor        = Theme.Attribute.init(rawValue: "pageIndicatorTintColor")
    /// UIPageControl
    public static let currentPageIndicatorTintColor = Theme.Attribute.init(rawValue: "currentPageIndicatorTintColor")

}

extension Theme.Style {
    
    public var numberOfPages: Int {
        get { return integerValue(for: .numberOfPages)  }
        set { setValue(newValue, for: .numberOfPages) }
    }
    public var currentPage: Int {
        get { return integerValue(for: .currentPage)  }
        set { setValue(newValue, for: .currentPage) }
    }
    
    public var hidesForSinglePage: Bool {
        get { return boolValue(for: .hidesForSinglePage)  }
        set { setValue(newValue, for: .hidesForSinglePage) }
    }
    public var defersCurrentPageDisplay: Bool {
        get { return boolValue(for: .defersCurrentPageDisplay)  }
        set { setValue(newValue, for: .defersCurrentPageDisplay) }
    }
    
    public var pageIndicatorTintColor: UIColor? {
        get { return color(for: .pageIndicatorTintColor) }
        set { setValue(newValue, for: .pageIndicatorTintColor) }
    }
    
    public var currentPageIndicatorTintColor: UIColor? {
        get { return color(for: .currentPageIndicatorTintColor) }
        set { setValue(newValue, for: .currentPageIndicatorTintColor) }
    }
    
}

extension UIPageControl {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.contains(.numberOfPages) {
            self.numberOfPages = themeStyles.numberOfPages
        }
        
        if themeStyles.contains(.currentPage) {
            self.currentPage = themeStyles.currentPage
        }
        
        if themeStyles.contains(.hidesForSinglePage) {
            self.hidesForSinglePage = themeStyles.hidesForSinglePage
        }
        
        if themeStyles.contains(.defersCurrentPageDisplay) {
            self.defersCurrentPageDisplay = themeStyles.defersCurrentPageDisplay
        }
        
        if themeStyles.contains(.pageIndicatorTintColor) {
            self.pageIndicatorTintColor = themeStyles.pageIndicatorTintColor
        }
        
        if themeStyles.contains(.currentPageIndicatorTintColor) {
            self.currentPageIndicatorTintColor = themeStyles.currentPageIndicatorTintColor
        }
        
    }
    
}
