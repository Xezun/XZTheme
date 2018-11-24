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
    public static let searchSearchBarIcon = Theme.State.init(name: ":searchSearchBarIcon", rawValue: UISearchBar.Icon.search)
    /// UISearchBarIcon.clear
    public static let clearSearchBarIcon = Theme.State.init(name: ":clearSearchBarIcon", rawValue: UISearchBar.Icon.clear)
    /// UISearchBarIcon.bookmark
    public static let bookmarkSearchBarIcon = Theme.State.init(name: ":searchBarIconBookmark", rawValue: UISearchBar.Icon.bookmark)
    /// UISearchBarIcon.resultsList
    public static let resultsListSearchBarIcon = Theme.State.init(name: ":resultsListSearchBarIcon", rawValue: UISearchBar.Icon.resultsList)

}

extension UISearchBar.Icon {
    public init?(_ themeState: Theme.State) {
        guard type(of: themeState.rawValue) == UISearchBar.Icon.self else {
            return nil
        }
        self = themeState.rawValue as! UISearchBar.Icon
    }
}

extension Theme.Attribute {
    /// UISearchBar.showsBookmarkButton
    public static let showsBookmarkButton = Theme.Attribute.init(rawValue: "showsBookmarkButton")
    /// UISearchBar.showsCancelButton
    public static let showsCancelButton = Theme.Attribute.init(rawValue: "showsCancelButton")
    /// UISearchBar.showsSearchResultsButton
    public static let showsSearchResultsButton = Theme.Attribute.init(rawValue: "showsSearchResultsButton")
    /// UISearchBar.isSearchResultsButtonSelected
    public static let isSearchResultsButtonSelected = Theme.Attribute.init(rawValue: "isSearchResultsButtonSelected")
    
    /// UISearchBar.searchBarStyle
    public static let searchBarStyle = Theme.Attribute.init(rawValue: "searchBarStyle")
    /// UISearchBar.scopeButtonTitles
    public static let scopeButtonTitles = Theme.Attribute.init(rawValue: "scopeButtonTitles")
    /// UISearchBar.selectedScopeButtonIndex
    public static let selectedScopeButtonIndex = Theme.Attribute.init(rawValue: "selectedScopeButtonIndex")
    /// UISearchBar.showsScopeBar
    public static let showsScopeBar = Theme.Attribute.init(rawValue: "showsScopeBar")
    /// UISearchBar.scopeBarBackgroundImage
    public static let scopeBarBackgroundImage = Theme.Attribute.init(rawValue: "scopeBarBackgroundImage")
    
    /// UISearchBar.searchFieldBackgroundImage
    public static let searchFieldBackgroundImage = Theme.Attribute.init(rawValue: "searchFieldBackgroundImage")
    /// UISearchBar.scopeBarButtonBackgroundImage
    public static let scopeBarButtonBackgroundImage = Theme.Attribute.init(rawValue: "scopeBarButtonBackgroundImage")
    /// UISearchBar 需使用 Theme.State.norml、Theme.State.norml 分别代表左右的 UIControlState ，其它状态依此类推。
    public static let scopeBarButtonDividerImage = Theme.Attribute.init(rawValue: "scopeBarButtonDividerImage")
    /// UISearchBar.scopeBarButtonTitleTextAttributes
    public static let scopeBarButtonTitleTextAttributes = Theme.Attribute.init(rawValue: "scopeBarButtonTitleTextAttributes")
    /// UISearchBar.searchFieldBackgroundPositionAdjustment
    public static let searchFieldBackgroundPositionAdjustment = Theme.Attribute.init(rawValue: "searchFieldBackgroundPositionAdjustment")
    /// UISearchBar.searchTextPositionAdjustment
    public static let searchTextPositionAdjustment = Theme.Attribute.init(rawValue: "searchTextPositionAdjustment")
    /// UISearchBar.positionAdjustment
    public static let positionAdjustment = Theme.Attribute.init(rawValue: "positionAdjustment")
}

extension Theme.Style {
    
    public func searchBarStyle(for themeAttribute: Theme.Attribute) -> UISearchBar.Style {
        guard let value = value(for: themeAttribute) else { return .default }
        if let searchBarStyle = value as? UISearchBar.Style {
            return searchBarStyle
        }
        if let number = value as? UInt, let searchBarStyle = UISearchBar.Style(rawValue: number) {
            return searchBarStyle
        }
        if let number = value as? Int, let searchBarStyle = UISearchBar.Style(rawValue: UInt(number)) {
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
    
    public func offset(for themeAttribute: Theme.Attribute) -> UIOffset {
        guard let value = value(for: themeAttribute) else { return UIOffset.zero }
        if let offset = value as? UIOffset {
            return offset
        }
        if let aString = value as? String {
            return NSCoder.uiOffset(for: aString)
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
        get { return boolValue(for: .showsBookmarkButton)  }
        set { setValue(newValue, for: .showsBookmarkButton) }
    }
    
    public var showsCancelButton: Bool {
        get { return boolValue(for: .showsCancelButton)  }
        set { setValue(newValue, for: .showsCancelButton) }
    }
    
    public var showsSearchResultsButton: Bool {
        get { return boolValue(for: .showsSearchResultsButton)  }
        set { setValue(newValue, for: .showsSearchResultsButton) }
    }
    
    public var isSearchResultsButtonSelected: Bool {
        get { return boolValue(for: .isSearchResultsButtonSelected)  }
        set { setValue(newValue, for: .isSearchResultsButtonSelected) }
    }
    
    public var searchBarStyle: UISearchBar.Style {
        get { return searchBarStyle(for: .searchBarStyle) }
        set { setValue(newValue, for: .searchBarStyle) }
    }
    
    public var scopeButtonTitles: [String]? {
        get { return stringValues(for: .scopeButtonTitles) }
        set { setValue(newValue, for: .scopeButtonTitles) }
    }

    public var selectedScopeButtonIndex: Int {
        get { return integerValue(for: .selectedScopeButtonIndex) }
        set { setValue(newValue, for: .selectedScopeButtonIndex)}
    }
    
    public var showsScopeBar: Bool {
        get { return boolValue(for: .showsScopeBar)  }
        set { setValue(newValue, for: .showsScopeBar) }
    }
    
    public var scopeBarBackgroundImage: UIImage? {
        get { return image(for: .scopeBarBackgroundImage)  }
        set { setValue(newValue, for: .scopeBarBackgroundImage) }
    }
    
    public var searchFieldBackgroundImage: UIImage? {
        get { return image(for: .searchFieldBackgroundImage)  }
        set { setValue(newValue, for: .searchFieldBackgroundImage) }
    }
    
    public var scopeBarButtonBackgroundImage: UIImage? {
        get { return image(for: .scopeBarButtonBackgroundImage)  }
        set { setValue(newValue, for: .scopeBarButtonBackgroundImage) }
    }
    
    public var scopeBarButtonDividerImage: UIImage? {
        get { return image(for: .scopeBarButtonDividerImage)  }
        set { setValue(newValue, for: .scopeBarButtonDividerImage) }
    }
    
    public var scopeBarButtonTitleTextAttributes: [NSAttributedString.Key : Any]? {
        get { return stringAttributes(for: .scopeBarButtonTitleTextAttributes) }
        set { setValue(newValue, for: .scopeBarButtonTitleTextAttributes) }
    }
    
    public var searchFieldBackgroundPositionAdjustment: UIOffset {
        get { return offset(for: .searchFieldBackgroundPositionAdjustment)      }
        set { setValue(newValue, for: .searchFieldBackgroundPositionAdjustment) }
    }
    
    public var searchTextPositionAdjustment: UIOffset {
        get { return offset(for: .searchTextPositionAdjustment)      }
        set { setValue(newValue, for: .searchTextPositionAdjustment) }
    }
    
    public var positionAdjustment: UIOffset {
        get { return offset(for: .positionAdjustment)       }
        set { setValue(newValue, for: .positionAdjustment)  }
    }
    
    
}

extension UISearchBar {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.contains(.barStyle) {
            self.barStyle = themeStyles.barStyle
        }
        
        if themeStyles.contains(.text) {
            self.text = themeStyles.text
        }
        
        if themeStyles.contains(.prompt) {
            self.prompt = themeStyles.prompt
        }
        
        if themeStyles.contains(.placeholder) {
            self.placeholder = themeStyles.placeholderText
        }
        
        if themeStyles.contains(.showsBookmarkButton) {
            self.showsBookmarkButton = themeStyles.showsBookmarkButton
        }
        
        if themeStyles.contains(.showsCancelButton) {
            self.showsCancelButton = themeStyles.showsCancelButton
        }
        
        if themeStyles.contains(.showsSearchResultsButton) {
            self.showsSearchResultsButton = themeStyles.showsSearchResultsButton
        }
        
        if themeStyles.contains(.isSearchResultsButtonSelected) {
            self.isSearchResultsButtonSelected = themeStyles.isSearchResultsButtonSelected
        }
        
        if themeStyles.contains(.barTintColor) {
            self.barTintColor = themeStyles.barTintColor
        }
        
        if themeStyles.contains(.searchBarStyle) {
            self.searchBarStyle = themeStyles.searchBarStyle
        }
        
        if themeStyles.contains(.isTranslucent) {
            self.isTranslucent = themeStyles.isTranslucent
        }
        
        if themeStyles.contains(.scopeButtonTitles) {
            self.scopeButtonTitles = themeStyles.scopeButtonTitles
        }
        
        if themeStyles.contains(.showsScopeBar) {
            self.showsScopeBar = themeStyles.showsScopeBar
        }
        
        if themeStyles.contains(.backgroundImage) {
            self.backgroundImage = themeStyles.backgroundImage
        }
        
        if themeStyles.contains(.scopeBarBackgroundImage) {
            self.scopeBarBackgroundImage = themeStyles.scopeBarBackgroundImage
        }
        
        if themeStyles.contains(.searchFieldBackgroundPositionAdjustment) {
            self.searchFieldBackgroundPositionAdjustment = themeStyles.searchFieldBackgroundPositionAdjustment
        }
        
        if themeStyles.contains(.searchTextPositionAdjustment) {
            self.searchTextPositionAdjustment = themeStyles.searchTextPositionAdjustment
        }

        guard let themeStates = themeStyles.statedThemeStylesIfLoaded?.keys else {
            return
        }
        
        for themeState in themeStates {
            if themeState.isOptionSet {
                guard let controlState = UIControl.State.init(themeState) else {
                    XZLog("Unapplied Theme.State %@ for UISearchBar.", themeState)
                    continue
                }
                guard let themeStyle = themeStyles.themeStyleIfLoaded(for: themeState) else { continue }
                if themeStyle.contains(.searchFieldBackgroundImage) {
                    setSearchFieldBackgroundImage(themeStyle.searchFieldBackgroundImage, for: controlState)
                }
                if themeStyle.contains(.scopeBarButtonBackgroundImage) {
                    setScopeBarButtonBackgroundImage(themeStyle.scopeBarButtonBackgroundImage, for: controlState)
                }
                if themeStyle.contains(.scopeBarButtonTitleTextAttributes) {
                    setScopeBarButtonTitleTextAttributes(themeStyle.scopeBarButtonTitleTextAttributes, for: controlState)
                }
            } else if themeState.isPrimary {
                guard let searchBarIcon = UISearchBar.Icon.init(themeState) else {
                    XZLog("Unapplied Theme.State %@ for UISearchBar.", themeState)
                    continue
                }
                guard let themeStyle = themeStyles.themeStyleIfLoaded(for: themeState) else { continue }
                if themeStyle.contains(.positionAdjustment) {
                    setPositionAdjustment(themeStyle.positionAdjustment, for: searchBarIcon)
                }
            } else {
                if let barPosition = UIBarPosition.init(themeState[0]) {
                    guard let barMetrics = UIBarMetrics.init(themeState[1]) else {
                        XZLog("Unapplied Theme.State %@ for UISearchBar.", themeState)
                        continue
                    }
                    guard let themeStyle = themeStyles.themeStyleIfLoaded(for: themeState) else { continue }
                    if themeStyle.contains(.backgroundImage) {
                        self.setBackgroundImage(themeStyle.backgroundImage, for: barPosition, barMetrics: barMetrics)
                    }
                } else if let searchBarIcon = UISearchBar.Icon.init(themeState[0]) {
                    guard let controlState = UIControl.State.init(themeState[1]) else {
                        XZLog("Unapplied Theme.State %@ for UISearchBar.", themeState)
                        continue
                    }
                    guard let themeStyle = themeStyles.themeStyleIfLoaded(for: themeState) else { continue }
                    if themeStyle.contains(.image) {
                        setImage(themeStyle.image, for: searchBarIcon, state: controlState)
                    }
                } else if let leftControlState = UIControl.State.init(themeState[0]) {
                    guard let rightControlState = UIControl.State.init(themeState[1]) else {
                        XZLog("Unapplied Theme.State %@ for UISearchBar.", themeState)
                        continue
                    }
                    guard let themeStyle = themeStyles.themeStyleIfLoaded(for: themeState) else { continue }
                    if themeStyle.contains(.scopeBarButtonDividerImage) {
                        setScopeBarButtonDividerImage(themeStyle.scopeBarButtonDividerImage, forLeftSegmentState: leftControlState, rightSegmentState: rightControlState)
                    }
                } else {
                    XZLog("Unapplied Theme.State %@ for UISearchBar.", themeState)
                }
            }
        }
   
    }
    
}
