//
//  AnchorGroup.swift
//  YCDouYuZB
//
//  Created by 任任义春 on 2020/9/2.
//  Copyright © 2020 renyichun. All rights reserved.
//

import UIKit
import KakaJSON

struct AnchorGroup: Convertible {

    // 该组中对应的房间信息
    var room_list: [AnchorModel]?
    // 该组显示的标题
    var tag_name: String = ""
    // 该组显示的图标
    var icon_name: String = "home_header_normal"
    
}
