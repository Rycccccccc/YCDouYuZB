//
//  Common.swift
//  YCDouYuZB
//
//  Created by 任任义春 on 2020/8/31.
//  Copyright © 2020 renyichun. All rights reserved.
//

import UIKit

let kStatusBarH : CGFloat = kIsFullScreen ? 44 : 20
let kNaviBarContentH : CGFloat = 44
let kNavigationBarH : CGFloat = kStatusBarH + kNaviBarContentH


let kTabBarSafeAreaH : CGFloat = kIsFullScreen ? 34 : 0
let kTabBarH : CGFloat = kTabBarSafeAreaH + 44;


let kScreenW = UIScreen.main.bounds.size.width
let kScreenH = UIScreen.main.bounds.size.height

let kIsFullScreen = isFullScreen



var isFullScreen: Bool {
    if #available(iOS 11, *) {
          guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
              return false
          }
          if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
              print(unwrapedWindow.safeAreaInsets)
              return true
          }
    }
    return false
}
