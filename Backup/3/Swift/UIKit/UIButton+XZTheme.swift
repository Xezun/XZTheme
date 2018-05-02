//
//  UIButton+XZTheme.swift
//  XZKit
//
//  Created by mlibai on 2017/12/6.
//

import UIKit

extension UIButton {
    
    open override func updateAppearance(with themeStyle: Theme.Style, for themeAttribute: Theme.Attribute) {
        super.updateAppearance(with: themeStyle, for: themeAttribute);
        
        let attributeStates: [Theme.State] = [.normal, .selected, .highlighted, .disabled, .focused];
        
        for attributeState in attributeStates {
            let controlState = UIControlState.init(attributeState);
            switch themeAttribute {
            case .title:
                setTitle(themeStyle.title(forState: attributeState), for: controlState);
                
            case .titleColor:
                setTitleColor(themeStyle.titleColor(forState: attributeState), for: controlState);
                
            case .titleShadowColor:
                setTitleShadowColor(themeStyle.titleShadowColor(forState: attributeState), for: controlState);
                
            case .image:
                setImage(themeStyle.image(forState: attributeState), for: controlState);
                
            case .backgroundImage:
                setBackgroundImage(themeStyle.backgroundImage(forState: attributeState), for: controlState);
                
            case .attributedTitle:
                setAttributedTitle(themeStyle.attributedTitle(forState: attributeState), for: controlState);
                
            default:
                break;
            }
        }
    }
    
}
