//
//  ThemeViewController.swift
//  Example
//
//  Created by mlibai on 2018/4/13.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit
import XZTheme

class ThemeViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        view.themes.day.backgroundColor = UIColor.white
//        view.themes.night.backgroundColor = UIColor(0x303030ff)

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    
}




@IBDesignable

open class XZLabel: UILabel {
    
    @IBInspectable open var contentInsets: UIEdgeInsets = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    
    override open func drawText(in rect: CGRect) {
        let textRect = UIEdgeInsetsInsetRect(rect, contentInsets)
        super.drawText(in: textRect)
    }
    
    override open var intrinsicContentSize: CGSize {
        let size1 = super.intrinsicContentSize
        return CGSize.init(
            width: size1.width + contentInsets.left + contentInsets.right,
            height: size1.height + contentInsets.top + contentInsets.bottom
        )
    }
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        let size1 = super.sizeThatFits(size)
        return CGSize.init(
            width: size1.width + contentInsets.left + contentInsets.right,
            height: size1.height + contentInsets.top + contentInsets.bottom
        )
    }
    
}







