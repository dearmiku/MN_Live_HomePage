//
//  MK_HomePageVCContainer.swift
//  HomePage
//
//  Created by 杨尚达 on 2018/11/28.
//  Copyright © 2018年 杨尚达. All rights reserved.
//

import Base
import RxSwift



///首页控制器容器~
class MK_HomePageContainerVC : UIPageViewController {
    
    ///控制器数组
    lazy var vcArr:[UIViewController] = [
        MK_RecommandVC(),
        MK_RecommandVC(),
        MK_RecommandVC(),
        ]
    
    ///当前控制器下标
    let currentIndex = BehaviorSubject<Int>.init(value: 0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        self.setViewControllers([vcArr[0]], direction: UIPageViewController.NavigationDirection.reverse, animated: false, completion: nil)
    }
    
}

extension MK_HomePageContainerVC : UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = try? currentIndex.value() else {
            return nil
        }
        
        if index == 0 {
            return nil
        }else{
            
            currentIndex.onNext(index-1)
            return vcArr[index-1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = try? currentIndex.value() else {
            return nil
        }
        
        if index == vcArr.count - 1 {
            return nil
        }else{
            
            currentIndex.onNext(index+1)
            return vcArr[index+1]
        }
    }
    
}
