//
//  CollectionCycleCell.swift
//  YCDouYuZB
//
//  Created by 任任义春 on 2020/9/4.
//  Copyright © 2020 renyichun. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {

    
    // MARK: - 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    

    // MARK: - 定义模型属性
    var cycleModel: CycleModel? {
        
        didSet {
            titleLabel.text = cycleModel?.title
            iconImageView.kf.setImage(with: URL(string: cycleModel?.pic_url ?? ""))
        }
        
    }

    
    
    
    
    
}
