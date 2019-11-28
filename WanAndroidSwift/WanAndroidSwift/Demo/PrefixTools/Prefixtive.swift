//
//  Prefixtive.swift
//  WanAndroidSwift
//
//  Created by SilenceZhou on 2019/11/28.
//  Copyright © 2019 zhouyun. All rights reserved.
//

import Foundation
// Swift命名空间形式拓展的实现
// 参考链接：https://blog.nswebfrog.com/2017/03/23/swift-namespace/

// 1. 定义结构体 - 作为命名空间的承载
public struct Prefixtive<T> {
    public let value: T
    public init(_ value: T) { self.value = value}
}

// 2.定义协议
public protocol Prefixtivable {
    associatedtype PrefixtiveType
    static var zy: Prefixtive<PrefixtiveType>.Type { get set }
    var zy: Prefixtive<PrefixtiveType> { get set }
}

// 3.extension实现协议
extension Prefixtivable {
    public static var zy: Prefixtive<Self>.Type {
        get { Prefixtive<Self>.self }
        set {}
    }
    
    public var zy: Prefixtive<Self> {
        get { Prefixtive(self) }
        set {}
    }
}


// 第三方实现
// 1.遵循协议
extension UIView : Prefixtivable {}
// 2.拓展结构体
extension Prefixtive where T : UIView {
    
    /// 设置颜色
    /// 返回值为原来的值便于进行链式编程
    @discardableResult
    public func color(_ color: UIColor) -> T {
        value.backgroundColor = color
        return value
    }
    
    @discardableResult
    public func addTo(superView: UIView) -> T {
        superView.addSubview(value)
        return value
    }
    
    @discardableResult
    public func frame(_ rect: CGRect) -> T {
        value.frame = rect
        return value
    }
    
    @discardableResult
    public func tap(target: Any?, action: Selector?) -> T {
        let gesture = UITapGestureRecognizer(target: target, action: action)
        value.addGestureRecognizer(gesture)
        return value
    }
}
