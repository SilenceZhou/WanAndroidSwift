//
//  API.swift
//  WanAndroidSwift
//
//  Created by zhouyun on 2019/11/21.
//  Copyright © 2019 zhouyun. All rights reserved.
//

import Foundation

struct API {
    
    /// base url
    static let baseUrl = "https://www.wanandroid.com/"
    
    /// 首页banner http://www.wanandroid.com/banner/json
    static let banner = "banner"
    
    /// 首页推荐公众号
    /// 查看某个公众号历史数据 http://wanandroid.com/wxarticle/list/405/1/json
    /// 在某个公众号中搜索历史文章 http://wanandroid.com/wxarticle/list/405/1/json?k=Java
    static let wxarticle = "wxarticle/list"
    
    static let list = "project/list"
    
    
    
    static func getUrl(_ path: String, page: Int = -1, resType: String? = "json") -> String{
        
        var urlString = API.baseUrl + path
        
        if page >= 0 {
            urlString.append("/\(page)")
        }
        
        if let resT = resType {
            urlString.append("/\(resT)")
        }
        
        return urlString
    }
    
    
    
}
