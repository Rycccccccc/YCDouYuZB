//
//  CollectionGameCell.swift
//  YCDouYuZB
//
//  Created by 任任义春 on 2020/9/5.
//  Copyright © 2020 renyichun. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {

    // MARK: - 控件属性
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    // MARK: - 定义属性
    var group: AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            iconImageView.kf.setImage(with: URL(string: group?.icon_url ?? ""), placeholder: UIImage(named: "home_more_btn"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
    // MARK: -  系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
}
