//
//  NetworkTools.swift
//  WanAndroidSwift
//
//  Created by SilenceZhou on 2019/11/24.
//  Copyright © 2019 zhouyun. All rights reserved.
//

import Foundation
import Alamofire

enum Errors: Error {
  case requestFailed
}

class NetworkTools {
    
    
    static func request<T : Convertible>(url: String,method: HTTPMethod = .get, parameters: Parameters? = nil) -> Observable<T>{
        
        
        return Observable.create { (observer)-> Disposable in
            
            let request =  AF.request(url, method: method, parameters: parameters)
            
            
            request.responseJSON { response in
                
                guard response.error == nil,
                    let dict = response.value ,
                    let jsons = JSON(dict).dictionaryObject else {
                        
                        print(response.value as Any)
                        print(response.error as Any)
                        observer.onError(Errors.requestFailed)
                        return
                }
                
                let models = model(from: jsons, T.self)
                observer.onNext(models)
                observer.onCompleted()
            }
           return  Disposables.create()
            
//            return Disposables.create {
////                request.cancel()
//            }
        }
    }
    
    static func rx_getBanner() ->  Observable<Banner>  {
        return NetworkTools.request(url: API.getUrl(API.banner))
    }
    
    
    static func rx_getWXarticle(id: Int = 408) -> Observable<Project>  {
        let url = API.getUrl(API.wxarticle + "/\(id)", page: 1)
        return NetworkTools.request(url: url)
    }
    
    static func rx_getRecommandProject(cid: Int = 402 ) ->  Observable<Project>  {
        let url = API.getUrl(API.list, page: 1) + "?\(cid)"
        return NetworkTools.request(url: url)
    }
    
    
    
    
    
    
    /// 首页banner
    static func getBanner(success: @escaping (([Banner]) -> () ))  {
        
        let url = API.getUrl(API.banner)
        AF.request(url).responseJSON { response in
            
            guard let dict = response.value ,
                let jsons = JSON(dict)["data"].arrayObject else { return }
            let models = modelArray(from: jsons, Banner.self)
            
            success(models)
        }
    }
    
    
    
    /// 首页公众号
    static func getWXarticle(id: Int = 408,  success: @escaping ((Project) -> () )) {
        
        let url = API.getUrl(API.wxarticle + "/\(id)", page: 1)
        
        AF.request(url).responseJSON { (response) in
            
            guard let dict = response.value ,
                let json = JSON(dict).dictionaryObject else { return }
            
           let amodel = model(from: json, Project.self)

            success(amodel)
        }
    }
    
    
    /// 首页推荐项目
    /// https://www.wanandroid.com/project/list/1/json?cid=402
    static func getRecommandProject(cid: Int = 402,  success: @escaping ((Project) -> () )) {
        
        
        let url = API.getUrl(API.list, page: 1) + "?\(cid)"
        
        AF.request(url).responseJSON { response in

            guard let dict = response.value ,
                 let json = JSON(dict).dictionaryObject else { return }
            let amodel = model(from: json, Project.self)

             success(amodel)
        }
    }
}
