//
//  Colors.swift
//  WanAndroidSwift
//
//  Created by SilenceZhou on 2019/12/12.
//  Copyright © 2019 zhouyun. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    func UIColorHex(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}


public enum  Styles {
    
    public enum Colors {
        public static let  app_main = UIColorHex(0x666666);
        static let  app_bg = UIColorHex(0xf5f5f5);

        static let  transparent_80 = UIColorHex(0x80000000); //<!--204-->
        static let  white_19 = UIColorHex(0x19FFFFFF);

        static let  text_dark = UIColorHex(0x333333);
        static let  text_normal = UIColorHex(0x666666);
        static let  text_gray = UIColorHex(0x999999);

        static let  divider = UIColorHex(0xe5e5e5);

        static let  gray_33 = UIColorHex(0x333333); //51
        static let  gray_66 = UIColorHex(0x666666); //102
        static let  gray_99 = UIColorHex(0x999999); //153
        static let  gray_ef = UIColorHex(0xEFEFEF); //153

        static let  gray_f5 = UIColorHex(0xf5f5f5); //<!--204-->
        static let  gray_cc = UIColorHex(0xcccccc); //<!--204-->
        static let  gray_ce = UIColorHex(0xcecece); //<!--206-->
        static let  green_1 = UIColorHex(0x009688); //<!--204-->
        static let  green_62 = UIColorHex(0x626262); //<!--204-->
        static let  green_e5 = UIColorHex(0xe5e5e5); //<!--204-->

        static let  green_de = UIColorHex(0xdedede);
        
        static func UIColorHex(_ rgbValue: UInt) -> UIColor {
            return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
        }
    }

    
}
