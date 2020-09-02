//
//  NSDate-Extension.swift
//  YCDouYuZB
//
//  Created by 任任义春 on 2020/9/2.
//  Copyright © 2020 renyichun. All rights reserved.
//

import Foundation

extension NSDate {
    class func getCurrentTime() ->String {
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}
