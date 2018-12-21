//
//  Theme.swift
//  Example
//
//  Created by mlibai on 2018/6/3.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import Foundation



//class StyleSheet {
//
//    var namedStyles: [String: [Style]]
//
//
//}

public class Theme {
    
    var namedStyleSheets = [String: StyleSheet]()
    
    public class Style: NSObject {
        
        public enum State: Int, Hashable {
            case noState
            case normal
            
        }
        
        public enum Attribute: Hashable {
            
        }
        
        /// 样式所代表的状态。
        public let state: State
        /// 样式配置。
        public lazy var attributedValues = [Attribute: Any]()
        
        public init(for state: State) {
            self.state = state
            super.init()
        }
        
        private lazy var statedStyles = [State: Style]()
        
        public func themeStyleIfLoaded(for state: State) -> Style? {
            guard self.state != .noState else {
                return self
            }
            return statedStyles[state]
        }
        
        public func themeStyle(for state: State) -> Style {
            guard self.state == .noState else {
                return self
            }
            if let themeStyle = statedStyles[state] {
                return themeStyle
            }
            let themeStyle = Style.init(for: state)
            statedStyles[state] = themeStyle
            return themeStyle
        }
        
    }
    
    public enum Identifier: Int, Hashable {
        case notAnIdentifier
    }
    public class StyleSheet {
        
        /// 样式表中的样式。
        lazy var identifiedStyles = [Identifier: Style]()
        
    }
}









