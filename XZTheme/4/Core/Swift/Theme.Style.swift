//
//  Theme.Style.swift
//  Hello
//
//  Created by mlibai on 2018/4/28.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit



extension Theme.Style  {

    
    public typealias Owner = AnyObject
    
    
    public func value(for attribute: Theme.Attribute) -> Any? {
        return value(forThemeAttribute: attribute)
    }
    
    /// 更新主题属性值。
    /// - Note: 值 nil 也会更新到主题配置中。
    ///
    /// - Parameters:
    ///   - value: 待更新的值。
    ///   - attribute: 待更新的属性。
    func update(_ value: Any?, for attribute: Theme.Attribute) {
        
    }
    
    /// 删除主题属性（包括属性和值）。
    ///
    /// - Parameter attribute: 主题属性。
    @discardableResult func removeValue(for attribute: Theme.Attribute) -> Any?? {
        return nil
    }
    
    

    

 
}










