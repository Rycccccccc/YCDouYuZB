//
//  CollectionViewNormalCell.swift
//  YCDouYuZB
//
//  Created by 任任义春 on 2020/9/2.
//  Copyright © 2020 renyichun. All rights reserved.
//

import UIKit

class CollectionViewNormalCell: UICollectionViewCell {

    
    // MARK: - 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var roomNameLabel: UILabel!
    
    // MARK: - 定义模型属性
    var anchor: AnchorModel? {
    
        didSet {
            
            // 0. 校验模型是否有值
            guard let anchor = anchor else { return }
            
            var onlineStr = ""
            let onlineInt = Int(anchor.online)!
            if onlineInt >= 10000 {
                onlineStr = "\(Int(onlineInt / 10000))万在线"
            } else {
                onlineStr = "\(onlineInt)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            nickNameLabel.text = anchor.nickname
            roomNameLabel.text = anchor.room_name
            iconImageView.kf.setImage(with: URL(string: anchor.vertical_src))
            
        }
    }

}
