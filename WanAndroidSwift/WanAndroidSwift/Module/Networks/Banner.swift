//
//  Banner.swift
//  WanAndroidSwift
//
//  Created by SilenceZhou on 2019/11/24.
//  Copyright © 2019 zhouyun. All rights reserved.
//

// MARK: - Banner
struct Banner: Convertible {
    let data: [Datum]? = nil
    let errorCode: Int = 0
    let errorMsg: String = ""
}

// MARK: - Datum
struct Datum: Convertible {
    let desc : String = ""
    let id : Int = 0
    let imagePath : String  = ""
    let isVisible : Int = 0
    let order : Int = 0
    let title : String  = ""
    let type : Int = 0
    let url : String  = ""
}
