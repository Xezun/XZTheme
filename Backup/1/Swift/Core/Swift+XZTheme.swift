//
//  XZTheme.swift
//  XZKit
//
//  Created by mlibai on 2017/10/25.
//

import Foundation

extension Theme.State: ExpressibleByStringLiteral {
    
    public typealias StringLiteralType = String
    
    /// 通过字符串字面量创建主题属性状态。
    ///
    /// - Parameter value: 字符串字面量
    public init(stringLiteral value: String) {
        self.init(rawValue: value)
    }
}

extension Theme.Attribute: ExpressibleByStringLiteral {
    
    public typealias StringLiteralType = String
    
    /// 通过字符串字面量创建主题属性。
    ///
    /// - Parameter value: 字符串字面量
    public init(stringLiteral value: String) {
        self.init(rawValue: value)
    }
}

extension Theme.Identifier: ExpressibleByStringLiteral {
    
    public typealias StringLiteralType = String
    
    /// 通过字符串字面量创建主题标识符。
    ///
    /// - Parameter value: 字符串字面量
    public init(stringLiteral value: String) {
        self.init(rawValue: value)
    }
    
    public init?(_ rawValue: String?) {
        if let aString = rawValue {
            self = Theme.Identifier.init(aString)
        } else {
            return nil
        }
    }
    
}

// MARK: - 用空格分割由多个 Theme.Identifier 组成一个 Theme.Identifier 。

extension Theme.Identifier: OptionSet {
    
    public init() {
        self.init(rawValue: "")
    }
    
    /// 并集。并集后的结果，当前标识符中子标识符，如果在 other 标识符中存在，则被删除，然后将两个子标识符集合并集。
    ///
    /// - Parameter other: 并集的另一个标识符
    public mutating func formUnion(_ other: Theme.Identifier) {
        if other.isEmpty {
            return
        }
        if self.isEmpty {
            self = other
            return
        }
        var items1 = rawValue.components(separatedBy: " ")
        let items2 = other.rawValue.components(separatedBy: " ")
        for item2 in items2 {
            var index = 0
            while index < items1.count {
                let item1 = items1[index]
                if item1 == item2 {
                    items1.remove(at: index)
                } else {
                    index += 1
                }
            }
        }
        items1.append(contentsOf: items2)
        self = Theme.Identifier.init(rawValue: items1.joined(separator: " "))
    }
    
    /// 交集。同时存在当前标识符和 other 标识符的子标识符组成的新的标识符。
    ///
    /// - Parameter other: 交集的另一个标识符
    public mutating func formIntersection(_ other: Theme.Identifier) {
        if self.isEmpty {
            return
        }
        if other.isEmpty {
            self = other
            return
        }
        var items1 = rawValue.components(separatedBy: " ")
        let items2 = other.rawValue.components(separatedBy: " ")
        var index1 = 0
        while index1 < items1.count {
            let item1 = items1[index1]
            
            var isFound = false
            for item2 in items2 {
                if item2 == item1 {
                    isFound = true
                    break
                }
            }
            if !isFound {
                items1.remove(at: index1)
            } else {
                index1 += 1
            }
        }
        self = Theme.Identifier.init(rawValue: items1.joined(separator: " "))
    }
    
    /// 异或。如果子标识符同时存在于当前标识符和 other 标识符中，则该子标识符将被分别删除，然后由剩下的标识符组成新的标识符。
    ///
    /// - Parameter other: 异或的另一个标识符
    public mutating func formSymmetricDifference(_ other: Theme.Identifier) {
        if other.isEmpty {
            return
        }
        if self.isEmpty {
            self = other
            return
        }
        var items1 = rawValue.components(separatedBy: " ")
        var items2 = other.rawValue.components(separatedBy: " ")
        
        var index1: Int = 0
        while index1 < items1.count {
            let item1 = items1[index1]
            
            var isFound = false
            var index2 = 0
            while index2 < items2.count {
                let item2 = items2[index2]
                if item2 == item1 {
                    isFound = true
                    items2.remove(at: index2)
                } else {
                    index2 += 1
                }
            }
            
            if isFound {
                items1.remove(at: index1)
            } else {
                index1 += 1
            }
        }
        self = Theme.Identifier.init(rawValue: (items1 + items2).joined(separator: " "))
    }
    
}


// MARK: -  可以使用 for-in 遍历标识符中的子标识符。

extension Theme.Identifier: Sequence, IteratorProtocol {
    
    public mutating func next() -> Theme.Identifier? {
        if self.isEmpty {
            return nil;
        }
        let rawValue = self.rawValue;
        if let index = rawValue.index(of: " ") {
            self = Theme.Identifier.init(rawValue: String(rawValue[rawValue.index(after: index) ..< rawValue.endIndex]));
            return Theme.Identifier.init(rawValue: String(rawValue[rawValue.startIndex ..< index]));
        }
        self = Theme.Identifier.init();
        return Theme.Identifier.init(rawValue: rawValue);
    }
    
}


