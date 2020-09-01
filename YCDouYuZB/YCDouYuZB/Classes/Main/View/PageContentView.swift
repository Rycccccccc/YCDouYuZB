//
//  PageContentView.swift
//  YCDouYuZB
//
//  Created by 任任义春 on 2020/8/31.
//  Copyright © 2020 renyichun. All rights reserved.
//

import UIKit

private let kContentCellID = "kContentCellID"

class PageContentView: UIView {

    // MARK: - 定义属性
    private var childVcs: [UIViewController]
    private weak var parentViewController: UIViewController?
    
    // MARK: - 懒加载属性
    private lazy var collectionView: UICollectionView = { [weak self] in
        // 1. 创建Layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 2. 创建collectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellID)
        
        return collectionView
    }()
    
    // MARK: - 自定义构造函数
    init(frame: CGRect, childVcs: [UIViewController], parentViewController: UIViewController?) {
        
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        
        // 设置UI
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

// MARK: - 设置UI界面
extension PageContentView {
    
    private func setupUI(){
        
        // 1. 将所有的子控制器添加到父控制器中
        for childVc in childVcs {
            parentViewController?.addChild(childVc)
        }
        
        // 2.添加UICollectionView ，用于在cell 中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
        
        
    }
    
    
    
}

// MARK: - 遵守 UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 1. 创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellID, for: indexPath)
        
        // 2. 给cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        childVc.view.backgroundColor = UIColor.randomColor
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}

// MARK: - 对外暴露方法
extension PageContentView {
    
    func setCurrentIndex(currentIndex: Int){
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
    
}
