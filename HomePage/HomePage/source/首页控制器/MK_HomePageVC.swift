//
//  MK_HomePageVC.swift
//  HomePage
//
//  Created by 杨尚达 on 2018/11/21.
//  Copyright © 2018年 杨尚达. All rights reserved.
//

import SnapKit
import Base


///首页控制器
class MK_HomePageVC: MK_BaseVC {
    
    
    ///首页功能指示框
    lazy var indicateV = { () -> MK_HomePageFuncControlBar in
        let res = MK_HomePageFuncControlBar()
        view.addSubview(res)
        return res
    }()
    
    ///首页内容控制器
    lazy var contentVC = { () -> MK_HomePageContainerVC in
        let res = MK_HomePageContainerVC.init(
            transitionStyle: UIPageViewController.TransitionStyle.pageCurl,
            navigationOrientation: UIPageViewController.NavigationOrientation.horizontal,
            options: [UIPageViewController.OptionsKey.spineLocation:NSNumber.init(value: UIPageViewController.SpineLocation.min.rawValue)]
            )
        view.addSubview(res.view)
        return res
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isShowNavigationBar = false
        
        indicateV.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(MK_Device.navigationBarHight)
        }
        contentVC.view.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(indicateV.snp.bottom)
        }
        
        ///将内容控制器下标与指示器绑定
        contentVC.currentIndex.filter { (res) -> Bool in
            return (0 <= res && res < 3)
            }.map { (res) -> MK_HomePageFuncControlBar.State in
                return MK_HomePageFuncControlBar.State.init(rawValue: res)!
        }.bind(to: indicateV.state).disposed(by: bag)
        
        
        
    }
    
}
