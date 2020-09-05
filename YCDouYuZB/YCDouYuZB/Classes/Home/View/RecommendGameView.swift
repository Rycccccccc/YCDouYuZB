//
//  RecommendGameView.swift
//  YCDouYuZB
//
//  Created by 任任义春 on 2020/9/5.
//  Copyright © 2020 renyichun. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kEdgeInsetMgr: CGFloat = 10;

class RecommendGameView: UIView {

    
    // MARK: - 定义数据的属性
    var groups: [AnchorGroup]? {
        
        didSet {
            // 1. 先移除前两组数据
            groups?.removeFirst()
            groups?.removeFirst()
            
            // 2. 添加我们的更多组
            var moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            collectionView.reloadData()
        }
    }
    
    // MARK: - 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 注册cell
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMgr, bottom: 0, right: kEdgeInsetMgr)
    }

}

// MARK: - 创建类方法
extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
    
}


// MARK: - 遵守UICollectionViewDataSource 的数据源协议
extension RecommendGameView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        let group = groups?[indexPath.item]
        
        cell.group = group
        
        return cell
        
    }
    
    
}
