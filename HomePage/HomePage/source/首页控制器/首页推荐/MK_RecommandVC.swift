//
//  MK_RecommandVC.swift
//  HomePage
//
//  Created by 杨尚达 on 2018/11/22.
//  Copyright © 2018年 杨尚达. All rights reserved.
//

import SnapKit
import RxSwift
import RxCocoa
import Base


///推荐控制器
class MK_RecommandVC : MK_BaseVC {
    
    let vm = MK_RecommandVM()
    
    ///推荐轮播控件
    lazy var recommandV = { () -> MK_RecommandScrollV in
        let res = MK_RecommandScrollV()
        view.addSubview(res)
        return res
    }()
    
    ///分类推荐
    lazy var cateRecommandV = { () -> MK_CateTopRoomV in
        let res = MK_CateTopRoomV()
        view.addSubview(res)
        return res
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.00)
        self.isShowNavigationBar = false
        
        recommandV.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(MK_Device.safeArre.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(ScreenWidth*1/2)
        }
        cateRecommandV.snp.makeConstraints { (make) in
            make.top.equalTo(recommandV.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        
        ///将推荐房间信息绑定
        vm.recommandRoomArr.bind(to: recommandV.showModelArr).disposed(by: bag)
        
        ///将分类推荐信息绑定
        vm.cateRecommandRoomArr.bind(to: cateRecommandV.contentArr).disposed(by: bag)
        
        
        vm.loadNewData()
    }
}
