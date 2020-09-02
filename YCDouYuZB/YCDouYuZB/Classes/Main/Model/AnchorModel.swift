//
//  AnchorModel.swift
//  YCDouYuZB
//
//  Created by 任任义春 on 2020/9/2.
//  Copyright © 2020 renyichun. All rights reserved.
//

import UIKit
import KakaJSON

struct AnchorModel: Convertible {

    // 房间号
    var room_id: String = ""
    // 房间图片url
    var vertical_src: String = ""
    // 判断手机直播1 还是电脑直播0
    var isVertical: Int = 0
    // 房间名称
    var room_name: String = ""
    // 主播昵称
    var nickname: String = ""
    // 在线人数
    var online: String = ""
}
