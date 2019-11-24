//
//  NetworkTools.swift
//  WanAndroidSwift
//
//  Created by SilenceZhou on 2019/11/24.
//  Copyright © 2019 zhouyun. All rights reserved.
//

import Foundation
import Alamofire

class NetworkTools {
    
    static func getBanner(success: @escaping (([Banner]) -> () ))  {
        
        AF.request(API.getUrl(API.banner)).responseJSON { response in
            
            guard let dict = response.value ,
                let jsons = JSON(dict)["data"].arrayObject else { return }
            let models = modelArray(from: jsons, Banner.self)
            
            success(models)
        }
    }
        
        
}
