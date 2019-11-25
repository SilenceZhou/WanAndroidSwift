//
//  Project.swift
//  WanAndroidSwift
//
//  Created by zhouyun on 2019/11/25.
//  Copyright © 2019 zhouyun. All rights reserved.
//

import Foundation

// MARK: - Project
struct Project: Convertible {
    
    let data: ProjectData? = nil
    let errorCode: Int = 0
    let errorMsg: String = ""
}

// MARK: - ProjectData
struct ProjectData: Convertible {
    let curPage: Int = 0
    let datas: [DataElement]? = nil
    let offset: Int = 0
    let over: Bool = false
    let pageCount = 0
    let size = 0
    let total: Int = 0
}

// MARK: - DataElement
struct DataElement: Convertible {
    let apkLink: String = ""
    let audit: Int = 0
    let author: String = ""
    let chapterID: Int = 0
    let chapterName: String = ""
    let collect: Bool = false
    let courseID: Int = 0
    let desc = ""
    let envelopePic: String = ""
    let fresh: Bool = false
    let id: Int = 0
    let link: String = ""
    let niceDate: String = ""
    let niceShareDate: String = ""
    let origin: String = ""
    let dataPrefix: String = ""
    let projectLink: String = ""
    let publishTime: Int = 0
    let selfVisible: Int = 0
    let shareDate: Int = 0
    let shareUser: String = ""
    let superChapterID: Int = 0
    let superChapterName: String = ""
    let tags: [Tag]? = nil
    let title: String = ""
    let type: Int = 0
    let userID: Int = 0
    let visible:Int = 0
    let zan:Int = 0
}


// MARK: - Tag
struct Tag: Convertible {
    let name: String = ""
    let url: String = ""
}
