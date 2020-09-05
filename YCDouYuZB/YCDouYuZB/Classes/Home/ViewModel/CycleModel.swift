//
//  CycleModel.swift
//  YCDouYuZB
//
//  Created by 任任义春 on 2020/9/4.
//  Copyright © 2020 renyichun. All rights reserved.
//

import UIKit
import KakaJSON

struct CycleModel: Convertible {

    // 标题
    var title: String = ""
    // 图片地址
    var pic_url: String = ""
    // 主播信息
    var room:AnchorModel?
    
}
