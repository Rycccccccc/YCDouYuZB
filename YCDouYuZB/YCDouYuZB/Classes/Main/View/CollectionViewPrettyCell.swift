//
//  CollectionViewPrettyCell.swift
//  YCDouYuZB
//
//  Created by 任任义春 on 2020/9/2.
//  Copyright © 2020 renyichun. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewPrettyCell: CollectionBaseCell {
    
    // MARK: - 控件属性
    @IBOutlet weak var cityBtn: UIButton!
    
    // MARK: - 定义模型属性
    override var anchor: AnchorModel? {
        didSet {
            // 1. 将属性传递给父类
            super.anchor = anchor
            // 2. 所在城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
    
}
