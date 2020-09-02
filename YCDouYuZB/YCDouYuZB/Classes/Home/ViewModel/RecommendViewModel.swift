//
//  RecommendViewModel.swift
//  YCDouYuZB
//
//  Created by 任任义春 on 2020/9/2.
//  Copyright © 2020 renyichun. All rights reserved.
//

import UIKit
import KakaJSON

class RecommendViewModel {

    // MARK: - 懒加载属性
    private lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
    
}


// MARK: - 发送网络请求
extension RecommendViewModel {
    
    func requestData() {
        
        
        // 1. 请求第一部分的推荐数据
        // 2. 请求第二部分的颜值数据
        // 3. 请求第三部分的游戏数据
        // http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1599035450
        print(NSDate.getCurrentTime())
        NetworkTools.requestData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit":"4","offset":"0","time":NSDate.getCurrentTime()
        ]) { (result) in
            
            print("ryc +++++++\(result)")
            // 1. 将result 转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2. 根据data获取key, 获取数组
            guard let dataArray =  resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3. 转成模型数组
            self.anchorGroups =  dataArray.kj.modelArray(AnchorGroup.self)
    
        }
    }
    
}
