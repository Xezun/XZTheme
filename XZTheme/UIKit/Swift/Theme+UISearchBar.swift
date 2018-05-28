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
    public static let searchSearchBarIcon = Theme.State.init(rawValue: ":searchSearchBarIcon")
    /// UISearchBarIcon.clear
    public static let clearSearchBarIcon = Theme.State.init(rawValue: ":clearSearchBarIcon")
    /// UISearchBarIcon.bookmark
    public static let bookmarkSearchBarIcon = Theme.State.init(rawValue: ":searchBarIconBookmark")
    /// UISearchBarIcon.resultsList
    public static let resultsListSearchBarIcon = Theme.State.init(rawValue: ":resultsListSearchBarIcon")

    public static let UIControlStateLeftRightItems: [(themeState: Theme.State, leftControlState: UIControlState, rightControlState: UIControlState)] = {
        var items: [(themeState: Theme.State, leftControlState: UIControlState, rightControlState: UIControlState)] =  [
            ([.normal, .normal], .normal, .normal), ([.normal, .selected], .normal, .selected),
            ([.normal, .highlighted], .normal, .highlighted), ([.normal, .disabled], .normal, .disabled),
            // ([.normal, .focused], .normal, .focused),
            
            ([.selected, .normal], .selected, .normal), ([.selected, .selected], .selected, .selected),
            ([.selected, .highlighted], .selected, .highlighted), ([.selected, .disabled], .selected, .disabled),
            // ([.selected, .focused], .selected, .focused),
            
            ([.highlighted, .normal], .highlighted, .normal), ([.normal, .selected], .highlighted, .selected),
            ([.highlighted, .highlighted], .highlighted, .highlighted), ([.normal, .disabled], .highlighted, .disabled),
            // ([.highlighted, .focused], .highlighted, .focused),
            
            ([.disabled, .normal], .disabled, .normal), ([.disabled, .selected], .disabled, .selected),
            ([.disabled, .highlighted], .disabled, .highlighted), ([.disabled, .disabled], .disabled, .disabled)
            // ([.disabled, .focused], .disabled, .focused),
            
            // ([.focused, .normal], .focused, .normal), ([.focused, .selected], .focused, .selected),
            // ([.focused, .highlighted], .focused, .highlighted), ([.focused, .disabled], .focused, .disabled)
            // ([.focused, .focused], .focused, .focused)
        ]
        if #available(iOS 9.0, *) {
            items.append(([.normal, .focused], .normal, .focused))
            items.append(([.selected, .focused], .selected, .focused))
            items.append(([.highlighted, .focused], .highlighted, .focused))
            items.append(([.disabled, .focused], .disabled, .focused))
            
            items.append(([.focused, .normal], .focused, .normal))
            items.append(([.focused, .selected], .focused, .selected))
            items.append(([.focused, .highlighted], .focused, .highlighted))
            items.append(([.focused, .disabled], .focused, .disabled))
            items.append(([.focused, .focused], .focused, .focused))
        }
        return items
    } ()
    
    
    
    public static let UISearchBarIconItems: [(themeState: Theme.State, searchBarIcon: UISearchBarIcon)] = [
        (.searchSearchBarIcon, .search), (.clearSearchBarIcon, .clear), (.bookmarkSearchBarIcon, .bookmark), (.resultsListSearchBarIcon, .resultsList)
    ]
    
    public static let UISearchBarIconUIControlStateItems: [(themeState: Theme.State, controlState: UIControlState, searchBarIcon: UISearchBarIcon)] = {
        var items: [(themeState: Theme.State, controlState: UIControlState, searchBarIcon: UISearchBarIcon)] = [
            ([.searchSearchBarIcon, .normal], .normal, .search), ([.clearSearchBarIcon, .normal], .normal, .clear),
            ([.bookmarkSearchBarIcon, .normal], .normal, .bookmark), ([.resultsListSearchBarIcon, .normal], .normal, .resultsList),
            
            ([.searchSearchBarIcon, .highlighted], .highlighted, .search), ([.clearSearchBarIcon, .highlighted], .highlighted, .clear),
            ([.bookmarkSearchBarIcon, .highlighted], .highlighted, .bookmark), ([.resultsListSearchBarIcon, .highlighted], .highlighted, .resultsList),
            
            ([.searchSearchBarIcon, .selected], .selected, .search), ([.clearSearchBarIcon, .selected], .selected, .clear),
            ([.bookmarkSearchBarIcon, .selected], .selected, .bookmark), ([.resultsListSearchBarIcon, .selected], .selected, .resultsList),
            
            ([.searchSearchBarIcon, .disabled], .disabled, .search), ([.clearSearchBarIcon, .disabled], .disabled, .clear),
            ([.bookmarkSearchBarIcon, .disabled], .disabled, .bookmark), ([.resultsListSearchBarIcon, .disabled], .disabled, .resultsList)
        ]
        if #available(iOS 9.0, *) {
            items.append(([.searchSearchBarIcon, .focused], .focused, .search))
            items.append(([.clearSearchBarIcon, .focused], .focused, .clear))
            items.append(([.bookmarkSearchBarIcon, .focused], .focused, .bookmark))
            items.append(([.resultsListSearchBarIcon, .focused], .focused, .resultsList))
        }
        return items
    }()

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
    /// UISearchBar 需使用 Theme.State.norml、Theme.State.norml 分别代表左右的 UIControlState ，其它状态依此类推。
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
        get { return stringAttributes(forThemeAttribute: .scopeBarButtonTitleTextAttributes) }
        set { setValue(newValue, forThemeAttribute: .scopeBarButtonTitleTextAttributes) }
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
        for item in Theme.State.UIBarPositionUIBarMetricsItems {
            guard let themeStyle = themeStyles.effectiveThemeStyle(forThemeState: item.themeState) else { continue }
            if themeStyle.containsThemeAttribute(.backgroundImage) {
                setBackgroundImage(themeStyle.backgroundImage, for: item.barPosition, barMetrics: item.barMetrics)
            }
        }
        
        // searchFieldBackgroundImage
        
        for item in Theme.State.UIControlStateItems {
            guard let themeStyle = themeStyles.effectiveThemeStyle(forThemeState: item.themeState) else { continue }
            if themeStyle.containsThemeAttribute(.searchFieldBackgroundImage) {
                setSearchFieldBackgroundImage(themeStyle.searchFieldBackgroundImage, for: item.controlState)
            }
            if themeStyle.containsThemeAttribute(.scopeBarButtonBackgroundImage) {
                setScopeBarButtonBackgroundImage(themeStyle.scopeBarButtonBackgroundImage, for: item.controlState)
            }
            if themeStyle.containsThemeAttribute(.scopeBarButtonTitleTextAttributes) {
                setScopeBarButtonTitleTextAttributes(themeStyle.scopeBarButtonTitleTextAttributes, for: item.controlState)
            }
            
        }
        
        // open func setImage(_ iconImage: UIImage?, for icon: UISearchBarIcon, state: UIControlState)
        
        for item in Theme.State.UISearchBarIconUIControlStateItems {
            guard let themeStyle = themeStyles.effectiveThemeStyle(forThemeState: item.themeState) else { continue }
            if themeStyle.containsThemeAttribute(.image) {
                setImage(themeStyle.image, for: item.searchBarIcon, state: item.controlState)
            }
        }
        
        for item in Theme.State.UIControlStateLeftRightItems {
            guard let themeStyle = themeStyles.effectiveThemeStyle(forThemeState: item.themeState) else { continue }
            if themeStyle.containsThemeAttribute(.scopeBarButtonDividerImage) {
                setScopeBarButtonDividerImage(themeStyle.scopeBarButtonDividerImage, forLeftSegmentState: item.leftControlState, rightSegmentState: item.rightControlState)
            }
        }
        
        if themeStyles.containsThemeAttribute(.searchFieldBackgroundPositionAdjustment) {
            self.searchFieldBackgroundPositionAdjustment = themeStyles.searchFieldBackgroundPositionAdjustment
        }
        
        if themeStyles.containsThemeAttribute(.searchTextPositionAdjustment) {
            self.searchTextPositionAdjustment = themeStyles.searchTextPositionAdjustment
        }
        
        // setPositionAdjustment
        
        for item in Theme.State.UISearchBarIconItems {
            guard let themeStyle = themeStyles.effectiveThemeStyle(forThemeState: item.themeState) else { continue }
            if themeStyle.containsThemeAttribute(.positionAdjustment) {
                setPositionAdjustment(themeStyle.positionAdjustment, for: item.searchBarIcon)
            }
        }
        
    }
    
}



