//
//  MK_HomePage_AllCateVC.swift
//  HomePage
//
//  Created by 杨尚达 on 2018/11/28.
//  Copyright © 2018年 杨尚达. All rights reserved.
//

import Base
import SnapKit


///全部分类
class MK_HomePage_AllCateVC : MK_BaseVC {
    
    let vm = MK_HomePage_AllCateVM()
    
    ///内容视图
    lazy var contentV = { () -> MK_HomePage_AllCateContentV in
        let res = MK_HomePage_AllCateContentV()
        self.view.addSubview(res)
        return res
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentV.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        ///将vm数据源绑定
        vm.modelArr.bind(to: contentV.modelArr).disposed(by: bag)
        
        OperationQueue.main.addOperation {
            self.vm.loadData()
        }
        
    }
    
    
}
