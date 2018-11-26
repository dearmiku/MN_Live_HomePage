//
//  MK_HomePageOpenVC.swift
//  HomePage
//
//  Created by 杨尚达 on 2018/11/23.
//  Copyright © 2018年 杨尚达. All rights reserved.
//

import Base


///首页入口控制器
class MK_HomePageEntranVC:MK_BaseNavigationVC {
    
    public init(){
        let vc = MK_HomePageVC()
        super.init(rootViewController: vc)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
