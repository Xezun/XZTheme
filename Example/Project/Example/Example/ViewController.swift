//
//  ViewController.swift
//  Example
//
//  Created by mlibai on 2018/4/13.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit



extension Theme {
    static var day: Theme {
        return Theme.default
    }
    static let night = Theme(named: "night")
}

extension Themes {

    var day: Theme.Styles {
        return self.themeStyles(for: .day)
    }

    var night: Theme.Styles {
        return self.themeStyles(for: .night)
    }

}



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.navigationController?.navigationBar.themes.day
            .setting(UIColor.white, for: .barTintColor)
            .setting(UIColor.black, for: .tintColor)
            .setting(UIImage(filled: 0x222222FF, size: CGSize(width: 0.5, height: 0.5)), for: .shadowImage)
        
        self.navigationController?.navigationBar.themes.night
            .setting(UIColor(0x252525FF), for: .barTintColor)
            .setting(UIColor(0x707070FF), for: .tintColor)
            .setting(UIImage(filled: 0x707070FF, size: CGSize(width: 0.5, height: 0.5)), for: .shadowImage)

        let label = OMLabel.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 100))
        label.text = "This is a label."
        label.backgroundColor = UIColor.lightGray
        view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false;
        let lc1 = NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0)
        let lc2 = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0)
        view.addConstraint(lc1)
        view.addConstraint(lc2)
        
        view.themes.day.backgroundColor    = UIColor.white
        view.themes.night.backgroundColor  = UIColor(0x303030ff)

        label.themes.day.backgroundColor   = UIColor(0xf5f5f5ff)
        label.themes.day.textColor         = UIColor(0x333333ff)

        label.themes.night.backgroundColor = UIColor(0x252525ff)
        label.themes.night.textColor       = UIColor(0x707070ff)


        let button = UIButton(type: .system)

        button.frame = CGRect.init(x: 100, y: 100, width: 150, height: 40)

        button.themes.day.normal.title                  = "Normal Day"
        button.themes.day.normal.titleColor             = UIColor(0x0000FFFF)
        button.themes.day.normal.backgroundImage        = UIImage(filled: 0xCCCCCCFF)

        button.themes.day.highlighted.title             = "Highlighted Day"
        button.themes.day.highlighted.titleColor        = UIColor(0x9999FFFF)
        button.themes.day.highlighted.backgroundImage   = UIImage(filled: 0xDDDDDDFF)

        button.themes.night.normal.title                = "Normal Night"
        button.themes.night.normal.titleColor           = UIColor(0x008800FF)
        button.themes.night.normal.backgroundImage      = UIImage(filled: 0x555555ff)

        button.themes.night.highlighted.title           = "Highlighted Night"
        button.themes.night.highlighted.titleColor      = UIColor(0x007700FF)
        button.themes.night.highlighted.backgroundImage = UIImage(filled: 0x444444FF)

        view.addSubview(button)
    }
    
    /// 计划将状态栏样式做个类目。
    var statusBarStyle: UIStatusBarStyle = .default
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    override func updateAppearance(with theme: Theme) {
        super.updateAppearance(with: theme)
        
        switch theme {
        case .day:      statusBarStyle = .default
        case .night:    statusBarStyle = .lightContent
        default:        break
        }
        
        setNeedsStatusBarAppearanceUpdate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func nightAction(_ sender: Any) {
        Theme.night.apply(true)
    }
    
    @IBAction func dayAction(_ sender: Any) {
        Theme.day.apply(true)
    }
}




@IBDesignable open class OMLabel: UILabel {
    
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
