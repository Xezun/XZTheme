//
//  Theme+UISearchBar.swift
//  XZTheme
//
//  Created by mlibai on 2018/5/24.
//

import Foundation
import XZKit

extension Theme.State {
    
    /// UISearchBarIcon.search
    public static let searchBarIconSearch = Theme.State.init(rawValue: ":searchBarIconSearch")
    /// UISearchBarIcon.clear
    public static let searchBarIconClear = Theme.State.init(rawValue: ":searchBarIconClear")
    /// UISearchBarIcon.bookmark
    public static let searchBarIconBookmark = Theme.State.init(rawValue: ":searchBarIconBookmark")
    /// UISearchBarIcon.resultsList
    public static let searchBarIconResultsList = Theme.State.init(rawValue: ":searchBarIconResultsList")

}

extension Theme.Attribute {
    
    /// UISearchBar.showsBookmarkButton
    public static let showsBookmarkButton = Theme.Attribute.init("showsBookmarkButton")
    /// UISearchBar.showsCancelButton
    public static let showsCancelButton = Theme.Attribute.init("showsCancelButton")
    /// UISearchBar.showsSearchResultsButton
    public static let showsSearchResultsButton = Theme.Attribute.init("showsSearchResultsButton")
    /// UISearchBar.isSearchResultsButtonSelected
    public static let isSearchResultsButtonSelected = Theme.Attribute.init("isSearchResultsButtonSelected")
    
    /// UISearchBar.searchBarStyle
    public static let searchBarStyle = Theme.Attribute.init("searchBarStyle")
    /// UISearchBar.scopeButtonTitles
    public static let scopeButtonTitles = Theme.Attribute.init("scopeButtonTitles")
    /// UISearchBar.selectedScopeButtonIndex
    public static let selectedScopeButtonIndex = Theme.Attribute.init("selectedScopeButtonIndex")
    /// UISearchBar.showsScopeBar
    public static let showsScopeBar = Theme.Attribute.init("showsScopeBar")
    /// UISearchBar.scopeBarBackgroundImage
    public static let scopeBarBackgroundImage = Theme.Attribute.init("scopeBarBackgroundImage")
    
    /// UISearchBar.searchFieldBackgroundImage
    public static let searchFieldBackgroundImage = Theme.Attribute.init("searchFieldBackgroundImage")
    /// UISearchBar.scopeBarButtonBackgroundImage
    public static let scopeBarButtonBackgroundImage = Theme.Attribute.init("scopeBarButtonBackgroundImage")
    /// UISearchBar.scopeBarButtonDividerImage
    public static let scopeBarButtonDividerImage = Theme.Attribute.init("scopeBarButtonDividerImage")
    /// UISearchBar.scopeBarButtonTitleTextAttributes
    public static let scopeBarButtonTitleTextAttributes = Theme.Attribute.init("scopeBarButtonTitleTextAttributes")
    /// UISearchBar.searchFieldBackgroundPositionAdjustment
    public static let searchFieldBackgroundPositionAdjustment = Theme.Attribute.init("searchFieldBackgroundPositionAdjustment")
    /// UISearchBar.searchTextPositionAdjustment
    public static let searchTextPositionAdjustment = Theme.Attribute.init("searchTextPositionAdjustment")
    /// UISearchBar.positionAdjustment
    public static let positionAdjustment = Theme.Attribute.init("positionAdjustment")
}

extension Theme.Style {
    
    public func searchBarStyle(forThemeAttribute themeAttribute: Theme.Attribute) -> UISearchBarStyle {
        guard let value = value(forThemeAttribute: themeAttribute) else { return .default }
        if let searchBarStyle = value as? UISearchBarStyle {
            return searchBarStyle
        }
        if let number = value as? UInt, let searchBarStyle = UISearchBarStyle(rawValue: number) {
            return searchBarStyle
        }
        if let number = value as? Int, let searchBarStyle = UISearchBarStyle(rawValue: UInt(number)) {
            return searchBarStyle
        }
        if let aString = value as? String {
            switch aString {
            case "default":   return .default
            case "prominent": return .prominent
            case "minimal":   return .minimal
            default: break
            }
        }
        XZLog("XZTheme: The theme style value (%@) for attribute (%@) is not a UISearchBarStyle value, `.default` returned.", value, themeAttribute)
        return .default
    }
    
    public func offset(forThemeAttribute themeAttribute: Theme.Attribute) -> UIOffset {
        guard let value = value(forThemeAttribute: themeAttribute) else { return UIOffset.zero }
        if let offset = value as? UIOffset {
            return offset
        }
        if let aString = value as? String {
            return UIOffsetFromString(aString)
        }
        if let dict = value as? [String: Any] {
            if let horizontal = dict["horizontal"] as? CGFloat {
                if let vertical = dict["vertical"] as? CGFloat {
                    return UIOffset.init(horizontal: horizontal, vertical: vertical)
                }
            }
        }
        XZLog("XZTheme: The theme style value (%@) for attribute (%@) is not a UIOffset value, `.zero` returned.", value, themeAttribute)
        return .zero
    }
    
    public var showsBookmarkButton: Bool {
        get { return boolValue(forThemeAttribute: .showsBookmarkButton)  }
        set { setValue(newValue, forThemeAttribute: .showsBookmarkButton) }
    }
    
    public var showsCancelButton: Bool {
        get { return boolValue(forThemeAttribute: .showsCancelButton)  }
        set { setValue(newValue, forThemeAttribute: .showsCancelButton) }
    }
    
    public var showsSearchResultsButton: Bool {
        get { return boolValue(forThemeAttribute: .showsSearchResultsButton)  }
        set { setValue(newValue, forThemeAttribute: .showsSearchResultsButton) }
    }
    
    public var isSearchResultsButtonSelected: Bool {
        get { return boolValue(forThemeAttribute: .isSearchResultsButtonSelected)  }
        set { setValue(newValue, forThemeAttribute: .isSearchResultsButtonSelected) }
    }
    
    public var searchBarStyle: UISearchBarStyle {
        get { return searchBarStyle(forThemeAttribute: .searchBarStyle) }
        set { setValue(newValue, forThemeAttribute: .searchBarStyle) }
    }
    
    public var scopeButtonTitles: [String]? {
        get { return stringValues(forThemeAttribute: .scopeButtonTitles) }
        set { setValue(newValue, forThemeAttribute: .scopeButtonTitles) }
    }

    public var selectedScopeButtonIndex: Int {
        get { return integerValue(forThemeAttribute: .selectedScopeButtonIndex) }
        set { setValue(newValue, forThemeAttribute: .selectedScopeButtonIndex)}
    }
    
    public var showsScopeBar: Bool {
        get { return boolValue(forThemeAttribute: .showsScopeBar)  }
        set { setValue(newValue, forThemeAttribute: .showsScopeBar) }
    }
    
    public var scopeBarBackgroundImage: UIImage? {
        get { return image(forThemeAttribute: .scopeBarBackgroundImage)  }
        set { setValue(newValue, forThemeAttribute: .scopeBarBackgroundImage) }
    }
    
    
    
    public var searchFieldBackgroundImage: UIImage? {
        get { return image(forThemeAttribute: .searchFieldBackgroundImage)  }
        set { setValue(newValue, forThemeAttribute: .searchFieldBackgroundImage) }
    }
    
    public var scopeBarButtonBackgroundImage: UIImage? {
        get { return image(forThemeAttribute: .scopeBarButtonBackgroundImage)  }
        set { setValue(newValue, forThemeAttribute: .scopeBarButtonBackgroundImage) }
    }
    
    public var scopeBarButtonDividerImage: UIImage? {
        get { return image(forThemeAttribute: .scopeBarButtonDividerImage)  }
        set { setValue(newValue, forThemeAttribute: .scopeBarButtonDividerImage) }
    }
    
    public var scopeBarButtonTitleTextAttributes: [String : Any]? {
        get {
            guard let stringAttributes = self.stringAttributes(forThemeAttribute: .scopeBarButtonTitleTextAttributes) else {
                return nil
            }
            var titleTextAttributes = [String: Any]()
            for item in stringAttributes {
                titleTextAttributes[item.key.rawValue] = item.value
            }
            return titleTextAttributes
        }
        set {
            setValue(newValue, forThemeAttribute: .scopeBarButtonTitleTextAttributes)
        }
    }
    
    public var searchFieldBackgroundPositionAdjustment: UIOffset {
        get { return offset(forThemeAttribute: .searchFieldBackgroundPositionAdjustment)      }
        set { setValue(newValue, forThemeAttribute: .searchFieldBackgroundPositionAdjustment) }
    }
    
    public var searchTextPositionAdjustment: UIOffset {
        get { return offset(forThemeAttribute: .searchTextPositionAdjustment)      }
        set { setValue(newValue, forThemeAttribute: .searchTextPositionAdjustment) }
    }
    
    public var positionAdjustment: UIOffset {
        get { return offset(forThemeAttribute: .positionAdjustment)       }
        set { setValue(newValue, forThemeAttribute: .positionAdjustment)  }
    }
    
    
}

extension UISearchBar {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.containsThemeAttribute(.barStyle) {
            self.barStyle = themeStyles.barStyle
        }
        
        if themeStyles.containsThemeAttribute(.text) {
            self.text = themeStyles.text
        }
        
        if themeStyles.containsThemeAttribute(.prompt) {
            self.prompt = themeStyles.prompt
        }
        
        if themeStyles.containsThemeAttribute(.placeholder) {
            self.placeholder = themeStyles.placeholderText
        }
        
        if themeStyles.containsThemeAttribute(.showsBookmarkButton) {
            self.showsBookmarkButton = themeStyles.showsBookmarkButton
        }
        
        if themeStyles.containsThemeAttribute(.showsCancelButton) {
            self.showsCancelButton = themeStyles.showsCancelButton
        }
        
        if themeStyles.containsThemeAttribute(.showsSearchResultsButton) {
            self.showsSearchResultsButton = themeStyles.showsSearchResultsButton
        }
        
        if themeStyles.containsThemeAttribute(.isSearchResultsButtonSelected) {
            self.isSearchResultsButtonSelected = themeStyles.isSearchResultsButtonSelected
        }
        
        if themeStyles.containsThemeAttribute(.barTintColor) {
            self.barTintColor = themeStyles.barTintColor
        }
        
        if themeStyles.containsThemeAttribute(.searchBarStyle) {
            self.searchBarStyle = themeStyles.searchBarStyle
        }
        
        if themeStyles.containsThemeAttribute(.isTranslucent) {
            self.isTranslucent = themeStyles.isTranslucent
        }
        
        if themeStyles.containsThemeAttribute(.scopeButtonTitles) {
            self.scopeButtonTitles = themeStyles.scopeButtonTitles
        }
        
        if themeStyles.containsThemeAttribute(.showsScopeBar) {
            self.showsScopeBar = themeStyles.showsScopeBar
        }
        
        if themeStyles.containsThemeAttribute(.backgroundImage) {
            self.backgroundImage = themeStyles.backgroundImage
        }
        
        if themeStyles.containsThemeAttribute(.scopeBarBackgroundImage) {
            self.scopeBarBackgroundImage = themeStyles.scopeBarBackgroundImage
        }
        
        // setBackgroundImage
        全局样式中可能存在配置 statedThemeStylesIfLoaded 需要重新处理。
        if let statedThemeStyles = themeStyles.statedThemeStylesIfLoaded {
            for statedThemeStyle in statedThemeStyles {
                for barMetrics in statedThemeStyle.key.barMetrics {
                    for barPosition in statedThemeStyle.key.barPositions {
                        if statedThemeStyle.value.containsThemeAttribute(.backgroundImage) {
                            self.setBackgroundImage(statedThemeStyle.value.backgroundImage, for: barPosition, barMetrics: barMetrics)
                        }
                    }
                }
            }
        }
        
        // searchFieldBackgroundImage
        
        if themeStyles.containsThemeAttribute(.searchFieldBackgroundImage) {
            self.setSearchFieldBackgroundImage(themeStyles.searchFieldBackgroundImage, for: .normal)
        }
        
        if let themeStyle = themeStyles.selectedIfLoaded, themeStyle.containsThemeAttribute(.searchFieldBackgroundImage) {
            self.setSearchFieldBackgroundImage(themeStyle.searchFieldBackgroundImage, for: .selected)
        }
        
        if let themeStyle = themeStyles.highlightedIfLoaded, themeStyle.containsThemeAttribute(.searchFieldBackgroundImage) {
            self.setSearchFieldBackgroundImage(themeStyle.searchFieldBackgroundImage, for: .highlighted)
        }
        
        if let themeStyle = themeStyles.disabledIfLoaded, themeStyle.containsThemeAttribute(.searchFieldBackgroundImage) {
            self.setSearchFieldBackgroundImage(themeStyle.searchFieldBackgroundImage, for: .disabled)
        }
        
        // open func setImage(_ iconImage: UIImage?, for icon: UISearchBarIcon, state: UIControlState)
        
        
        
        if themeStyles.containsThemeAttribute(.searchFieldBackgroundPositionAdjustment) {
            self.searchFieldBackgroundPositionAdjustment = themeStyles.searchFieldBackgroundPositionAdjustment
        }
        
        if themeStyles.containsThemeAttribute(.searchTextPositionAdjustment) {
            self.searchTextPositionAdjustment = themeStyles.searchTextPositionAdjustment
        }
        
        // setPositionAdjustment
        
    }
    
}

//open func setImage(_ iconImage: UIImage?, for icon: UISearchBarIcon, state: UIControlState)
//open func image(for icon: UISearchBarIcon, state: UIControlState) -> UIImage?

//open func setScopeBarButtonBackgroundImage(_ backgroundImage: UIImage?, for state: UIControlState)
//open func scopeBarButtonBackgroundImage(for state: UIControlState) -> UIImage?

//open func setScopeBarButtonDividerImage(_ dividerImage: UIImage?, forLeftSegmentState leftState: UIControlState, rightSegmentState rightState: UIControlState)
//open func scopeBarButtonDividerImage(forLeftSegmentState leftState: UIControlState, rightSegmentState rightState: UIControlState) -> UIImage?

//open func setScopeBarButtonTitleTextAttributes(_ attributes: [String : Any]?, for state: UIControlState)
//open func scopeBarButtonTitleTextAttributes(for state: UIControlState) -> [String : Any]?

//open var searchFieldBackgroundPositionAdjustment: UIOffset
//open var searchTextPositionAdjustment: UIOffset

//open func setPositionAdjustment(_ adjustment: UIOffset, for icon: UISearchBarIcon)
//open func positionAdjustment(for icon: UISearchBarIcon) -> UIOffset




