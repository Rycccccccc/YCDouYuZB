//
//  UIColor+Extension.swift
//  YCDouYuZB
//
//  Created by 任任义春 on 2020/8/31.
//  Copyright © 2020 renyichun. All rights reserved.
//

import UIKit

extension UIColor {
    
    // r.g.b
    convenience init(r: CGFloat , g: CGFloat , b: CGFloat) {
        
        self.init(red: r / 255.0, green:  g / 255.0, blue:  b / 255.0, alpha: 1.0)
    }
    
    
    // 随机颜色
    class var randomColor: UIColor  {
        
        UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)));
    }
}

