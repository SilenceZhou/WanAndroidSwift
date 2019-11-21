//
//  TabBar.swift
//  WanAndroidSwift
//
//  Created by zhouyun on 2019/11/21.
//  Copyright © 2019 zhouyun. All rights reserved.
//

import UIKit

class TabBar: UITabBar {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for button in subviews where button is UIControl  {
            var frame = button.frame
            frame.origin.y = -2
            button.frame = frame
        }
    }

}
