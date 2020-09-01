//
//  PageContentView.swift
//  YCDouYuZB
//
//  Created by 任任义春 on 2020/8/31.
//  Copyright © 2020 renyichun. All rights reserved.
//

import UIKit


protocol PageContentViewDelegate: class {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}


private let kContentCellID = "kContentCellID"

class PageContentView: UIView {

    // MARK: - 定义属性
    private var childVcs: [UIViewController]
    private weak var parentViewController: UIViewController?
    private var startOffsetX: CGFloat = 0
    private var isForbidScrollDelegate: Bool = false
    weak var delegate: PageContentViewDelegate?
    
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
        collectionView.delegate = self
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

// MARK: - 遵守 UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate {
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 0. 判断是否是点击事件
        if isForbidScrollDelegate { return }
        
        // 1. 获取数据
        var progress: CGFloat = 0
        var scourceIndex: Int = 0
        var targetIndex: Int = 0
        
        // 2. 判断左划还是右划
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        if currentOffsetX > startOffsetX {
            // 左划
            // 1. 计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            // 2. 计算sourceIndex
            scourceIndex = Int(currentOffsetX / scrollViewW)
            
            targetIndex = scourceIndex + 1
            
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1;
            }
            
            // 3.如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = scourceIndex
            }
            
        } else {
            // 右划
            // 1. 计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))

            // 2. 计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            // 3. 计算scorceIndex
            scourceIndex = targetIndex + 1
            
            if scourceIndex >= childVcs.count {
                scourceIndex = childVcs.count - 1;
            }
        }
        
        // 3. 将progress, tagetIndex, sourceIndex 传给titleView
        
        print("progress:\(progress)   sourceIndex:\(scourceIndex)  targetIndex:\(targetIndex)")
        
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: scourceIndex, targetIndex: targetIndex)
        
    }
}

// MARK: - 对外暴露方法
extension PageContentView {
    
    func setCurrentIndex(currentIndex: Int){
        // 1.记录需要禁止直行代理的方法
        isForbidScrollDelegate = true
            
        // 2. 滚动到正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
    
}
