//
//  UIControlState+XZThemeState.swift
//  XZKit
//
//  Created by mlibai on 2017/12/6.
//

import UIKit

extension UIControlState {
    
    public init(_ themeState: Theme.State) {
        switch themeState {
        case .normal:
            self = .normal
            
        case .selected:
            self = .selected
            
        case .highlighted:
            self = .highlighted
            
        case .focused:
            if #available(iOS 9.0, *) {
                self = .focused
            } else {
                self = .normal
            }
            
        case .disabled:
            self = .disabled
            
        default:
            self = .normal
        }
        
    }
    
}
