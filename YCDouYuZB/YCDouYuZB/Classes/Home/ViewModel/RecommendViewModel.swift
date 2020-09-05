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
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
    lazy var cycleModels: [CycleModel] = [CycleModel]()
    private lazy var bigDataGroups: AnchorGroup = AnchorGroup()
    private lazy var prettyGroups: AnchorGroup = AnchorGroup()
    
}


// MARK: - 发送网络请求
extension RecommendViewModel {
    
    // 请求推荐数据
    func requestData(finishCallBack: @escaping ()-> ()) {
        
        // 0. 定义参数
        let parameters = ["limit":"4","offset":"0","time":NSDate.getCurrentTime()]
        
        // 2. 创建Group
        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue(label: "request_queue")
        
        // 1. 请求第一部分的推荐数据
        dispatchGroup.enter()
        dispatchQueue.async {
            
            // http://capi.douyucdn.cn/api/v1/getbigDataRoom?time=1599035450
            NetworkTools.requestData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time":NSDate.getCurrentTime()]) { (result) in
                
                // 1. 将result 转成字典类型
                guard let resultDict = result as? [String : NSObject] else { return }
                // 2. 根据data获取key, 获取数组
                guard let dataArray =  resultDict["data"] as? [[String : NSObject]] else { return }
                
                // 3. 转成模型数组
                self.bigDataGroups.tag_name = "热门"
                self.bigDataGroups.icon_name = "home_header_hot"
                self.bigDataGroups.room_list =  dataArray.kj.modelArray(AnchorModel.self)
                
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        dispatchQueue.async {
            
            // 2. 请求第二部分的颜值数据
            // http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&time=1599035450
            NetworkTools.requestData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
                
                // 1. 将result 转成字典类型
                guard let resultDict = result as? [String : NSObject] else { return }
                // 2. 根据data获取key, 获取数组
                guard let dataArray =  resultDict["data"] as? [[String : NSObject]] else { return }
                
                // 3. 转成模型数组
                self.prettyGroups.tag_name = "颜值"
                self.prettyGroups.icon_name = "home_header_phone"
                self.prettyGroups.room_list =  dataArray.kj.modelArray(AnchorModel.self)
                
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        dispatchQueue.async {
            
            // 3. 请求第三部分的游戏数据
            // http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1599035450
            print(NSDate.getCurrentTime())
            NetworkTools.requestData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
                
                // 1. 将result 转成字典类型
                guard let resultDict = result as? [String : NSObject] else { return }
                // 2. 根据data获取key, 获取数组
                guard let dataArray =  resultDict["data"] as? [[String : NSObject]] else { return }
                
                // 3. 转成模型数组
                self.anchorGroups =  dataArray.kj.modelArray(AnchorGroup.self)
                
                dispatchGroup.leave()
            }
        }
        
       
        // 所以的数据请求完成后，进行排序
        dispatchGroup.notify(queue: dispatchQueue) {
            
            self.anchorGroups.insert(self.prettyGroups, at: 0)
            self.anchorGroups.insert(self.bigDataGroups, at: 0)
            
            finishCallBack()
            
        }
    }
    
    // 请求无线轮播数据
    func requestCycleData(finishCallBack: @escaping ()-> ()) {
        
        // http://www.douyutv.com/api/v1/slide/?version&2.300
        NetworkTools.requestData(.GET, URLString: "http://www.douyutv.com/api/v1/slide/", parameters: ["version":"2.300"]) { (result) in
            
            // 1. 将result 转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            // 2. 根据data获取key, 获取数组
            guard let dataArray =  resultDict["data"] as? [[String : NSObject]] else { return }
            
            self.cycleModels =  dataArray.kj.modelArray(CycleModel.self)
            
            finishCallBack()
        }
    }
}
