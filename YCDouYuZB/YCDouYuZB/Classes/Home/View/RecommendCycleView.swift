//
//  RecommendCycleView.swift
//  YCDouYuZB
//
//  Created by 任任义春 on 2020/9/3.
//  Copyright © 2020 renyichun. All rights reserved.
//

import UIKit


private let kCycleCellID = "kCycleCellID"

class RecommendCycleView: UIView {

    
    // MARK: - 定义属性
    var cycleModels: [CycleModel]? {

        didSet {
            collectionView.reloadData()
            // 设置pageControl 的个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
        }
    }
    
    // MARK: - 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: - 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 注册cell
        
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 设置CollectionView 的Layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        
    }
    
}

// MARK: - 提供一个快速创建view的方法
extension RecommendCycleView {
    
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

// MARK: - 遵守 UICollectionViewDataSource
extension RecommendCycleView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cycleModel = cycleModels![indexPath.item]
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        
        cell.cycleModel = cycleModel
        
        return cell
        
    }
    
    
}

// MARK: - 遵守 UICollectionView 的代理协议
extension RecommendCycleView: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
        // 1. 获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        // 2. 计算pageControl 的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width)
    }
    
}
