//
//  HomeViewController.swift
//  WanAndroidSwift
//
//  Created by zhouyun on 2019/11/21.
//  Copyright © 2019 zhouyun. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.randomColor
        title = "首页"
        
        
        
        
        
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        Observable.zip(NetworkTools.rx_getBanner(),
                       NetworkTools.rx_getWXarticle(),
                       NetworkTools.rx_getRecommandProject())
            .subscribe(onNext: { (banner, article, project) in
                
                print("banner = \(banner)")
                print("\n\n\n\n\n")
                print("article = \(article)")
                print("\n\n\n\n\n")
                print("article = \(project)")
                print("\n\n\n\n\n")
                
            }, onError: { error in
                print(error)
            }, onCompleted: {
                print("完成")
            }, onDisposed: {
                print("销毁")
            }).disposed(by: disposeBag)
        
    }
}
