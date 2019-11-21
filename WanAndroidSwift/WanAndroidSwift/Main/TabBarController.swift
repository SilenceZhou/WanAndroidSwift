//
//  TabBarController.swift
//  WanAndroidSwift
//
//  Created by zhouyun on 2019/11/21.
//  Copyright © 2019 zhouyun. All rights reserved.
//

import UIKit


class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setValue(TabBar(), forKeyPath: "tabBar")
        tabBar.barTintColor = UIColor.white
        addChild("首页", "home",  HomeViewController.self)
        addChild("项目", "project", ProjectViewController.self)
        addChild("动态", "dynamic",  DynamicViewController.self)
        addChild("标签", "tag",  TagViewController.self)
        addChild("我的", "profile",  ProfileViewController.self)
    }
    
    
    func addChild(_ title: String,
                  _ image: String,
                  _ type: UIViewController.Type) {
        let child = NavigationController(rootViewController: type.init())
        child.title = title
        child.navigationItem.title = title
        child.tabBarItem.image = UIImage(named: image)
        child.tabBarItem.selectedImage = UIImage(named: image + "selected")
        
        child.tabBarItem.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.rgbHex(0x1781D2)
        ], for: .selected)
        addChild(child)
    }
}
