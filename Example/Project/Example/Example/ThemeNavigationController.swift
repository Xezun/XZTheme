//
//  ThemeNavigationController.swift
//  Example
//
//  Created by mlibai on 2018/5/1.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit

class ThemeNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.themes.day
            .setting(UIColor.white, for: .barTintColor)
            .setting(UIColor.black, for: .tintColor)
            .setting(UIImage(filled: 0xccccccFF, size: CGSize(width: 0.5, height: 0.5)), for: .shadowImage)
            .setting(UIBarStyle.default, for: .barStyle)
        
        navigationBar.themes.night
            .setting(UIColor(0x252525FF), for: .barTintColor)
            .setting(UIColor(0xc7c7c7FF), for: .tintColor)
            .setting(UIImage(filled: 0x555555FF, size: CGSize(width: 0.5, height: 0.5)), for: .shadowImage)
            .setting(UIBarStyle.black, for: .barStyle)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
