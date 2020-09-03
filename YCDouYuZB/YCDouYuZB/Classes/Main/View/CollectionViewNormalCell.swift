//
//  CollectionViewNormalCell.swift
//  YCDouYuZB
//
//  Created by 任任义春 on 2020/9/2.
//  Copyright © 2020 renyichun. All rights reserved.
//

import UIKit

class CollectionViewNormalCell: CollectionBaseCell {
    
    // MARK: - 控件属性
    @IBOutlet weak var roomNameLabel: UILabel!
    
    // MARK: - 定义模型属性
    override var anchor: AnchorModel? {
        didSet {
            // 1. 将属性传递给父类
            super.anchor = anchor
            
            // 2 房间名称
            roomNameLabel.text = anchor?.room_name
        }
    }
    
}
