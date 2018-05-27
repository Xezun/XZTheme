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
    
    
    /// 表示对象在正常或者默认状态下，一般与 UIControlState.normal 相对应。
    public static let normalForRight       = Theme.State.init(rawValue: ":rightNormal")
    /// 表示对象在被选中的状态下，一般与 UIControlState.selected 相对应。
    public static let selectedForRight     = Theme.State.init(rawValue: ":rightSelected")
    /// 表示对象处高亮状态下，一般与 UIControlState.highlighted 相对应。
    public static let highlightedForRight  = Theme.State.init(rawValue: ":rightHighlighted")
    /// 表示对象处于被禁用状态下，一般与 UIControlState.disabled 相对应。
    public static let disabledForRight     = Theme.State.init(rawValue: ":rightDisabled")
    /// 表示对象处于焦点状态下，一般与 UIControlState.focused 相对应。
    public static let focusedForRight      = Theme.State.init(rawValue: ":rightFocused")
    

    public static let UIControlStateLeftRightItems: [(themeState: Theme.State, leftControlState: UIControlState, rightControlState: UIControlState)] = {
        var items: [(themeState: Theme.State, leftControlState: UIControlState, rightControlState: UIControlState)] =  [
            ([.normal, .normalForRight], .normal, .normal), ([.normal, .selectedForRight], .normal, .selected),
            ([.normal, .highlightedForRight], .normal, .highlighted), ([.normal, .disabledForRight], .normal, .disabled),
            // ([.normal, .focusedForRight], .normal, .focused),
            
            ([.selected, .normalForRight], .selected, .normal), ([.selected, .selectedForRight], .selected, .selected),
            ([.selected, .highlightedForRight], .selected, .highlighted), ([.selected, .disabledForRight], .selected, .disabled),
            // ([.selected, .focusedForRight], .selected, .focused),
            
            ([.highlighted, .normalForRight], .highlighted, .normal), ([.normal, .selectedForRight], .highlighted, .selected),
            ([.highlighted, .highlightedForRight], .highlighted, .highlighted), ([.normal, .disabledForRight], .highlighted, .disabled),
            // ([.highlighted, .focusedForRight], .highlighted, .focused),
            
            ([.disabled, .normalForRight], .disabled, .normal), ([.disabled, .selectedForRight], .disabled, .selected),
            ([.disabled, .highlightedForRight], .disabled, .highlighted), ([.disabled, .disabledForRight], .disabled, .disabled)
            // ([.disabled, .focusedForRight], .disabled, .focused),
            
            // ([.focused, .normalForRight], .focused, .normal), ([.focused, .selectedForRight], .focused, .selected),
            // ([.focused, .highlightedForRight], .focused, .highlighted), ([.focused, .disabledForRight], .focused, .disabled)
            // ([.focused, .focusedForRight], .focused, .focused)
        ]
        if #available(iOS 9.0, *) {
            items.append(([.normal, .focusedForRight], .normal, .focused))
            items.append(([.selected, .focusedForRight], .selected, .focused))
            items.append(([.highlighted, .focusedForRight], .highlighted, .focused))
            items.append(([.disabled, .focusedForRight], .disabled, .focused))
            
            items.append(([.focused, .normalForRight], .focused, .normal))
            items.append(([.focused, .selectedForRight], .focused, .selected))
            items.append(([.focused, .highlightedForRight], .focused, .highlighted))
            items.append(([.focused, .disabledForRight], .focused, .disabled))
            items.append(([.focused, .focusedForRight], .focused, .focused))
        }
        return items
    } ()
    
    
    
    public static let UISearchBarIconItems: [(themeState: Theme.State, searchBarIcon: UISearchBarIcon)] = [
        (.searchBarIconSearch, .search), (.searchBarIconClear, .clear), (.searchBarIconBookmark, .bookmark), (.searchBarIconResultsList, .resultsList)
    ]
    
    public static let UIControlStateUISearchBarIconItems: [(themeState: Theme.State, controlState: UIControlState, searchBarIcon: UISearchBarIcon)] = {
        var items: [(themeState: Theme.State, controlState: UIControlState, searchBarIcon: UISearchBarIcon)] = [
            ([.normal, .searchBarIconSearch], .normal, .search), ([.normal, .searchBarIconClear], .normal, .clear),
            ([.normal, .searchBarIconBookmark], .normal, .bookmark), ([.normal, .searchBarIconResultsList], .normal, .resultsList),
            
            ([.highlighted, .searchBarIconSearch], .highlighted, .search), ([.highlighted, .searchBarIconClear], .highlighted, .clear),
            ([.highlighted, .searchBarIconBookmark], .highlighted, .bookmark), ([.highlighted, .searchBarIconResultsList], .highlighted, .resultsList),
            
            ([.selected, .searchBarIconSearch], .selected, .search), ([.selected, .searchBarIconClear], .selected, .clear),
            ([.selected, .searchBarIconBookmark], .selected, .bookmark), ([.selected, .searchBarIconResultsList], .selected, .resultsList),
            
            ([.disabled, .searchBarIconSearch], .disabled, .search), ([.disabled, .searchBarIconClear], .disabled, .clear),
            ([.disabled, .searchBarIconBookmark], .disabled, .bookmark), ([.disabled, .searchBarIconResultsList], .disabled, .resultsList)
        ]
        if #available(iOS 9.0, *) {
            items.append(([.focused, .searchBarIconSearch], .focused, .search))
            items.append(([.focused, .searchBarIconClear], .focused, .clear))
            items.append(([.focused, .searchBarIconBookmark], .focused, .bookmark))
            items.append(([.focused, .searchBarIconResultsList], .focused, .resultsList))
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
    /// UISearchBar 需使用 Theme.State.norml、Theme.State.normlForRight 分别代表左右的 UIControlState ，其它状态依此类推。
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
        for item in Theme.State.UIBarMetricsUIBarPositionItems {
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
        
        for item in Theme.State.UIControlStateUISearchBarIconItems {
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



