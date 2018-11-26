//
//  MK_CategoryShowVC.swift
//  HomePage
//
//  Created by 杨尚达 on 2018/11/23.
//  Copyright © 2018年 杨尚达. All rights reserved.
//

import Base
import SnapKit
import RxCocoa
import RxSwift
import LivingRoom


///分类展示控制器
class MK_CategoryShowVC : MK_BaseVC {
    
    var vm:MK_CategoryShowVM
    
    ///分类详情界面
    lazy var cateInfoV = { () -> MK_CategoryInfoV in
        let res = MK_CategoryInfoV()
        view.addSubview(res)
        return res
    }()
    
    
    
    ///分类下直播间数组
    lazy var liveRoomV = { () -> MK_liveRoomListContentV in
        let res = MK_liveRoomListContentV.init()
        view.addSubview(res)
        return res
    }()
    
    
    init(cateID:String){
        
        vm = MK_CategoryShowVM.init(caetID: cateID)
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "分类详情"
        
        cateInfoV.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(MK_Device.navigationBarHight + 6)
            make.left.equalToSuperview().offset(6)
            make.right.equalToSuperview().offset(-6)
            make.height.equalTo(60)
        }
        
        
        liveRoomV.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(cateInfoV.snp.bottom).offset(10)
        }
        
        
        ///将vm分类详情信息订阅
        vm.cateInfoV.subscribe(onNext: {[weak self] (res) in
            
            guard let sf = self,
                let model = res else {return}
            
            sf.cateInfoV.model = model
            
        }).disposed(by: bag)
        
        ///对vm分类下直播间数组进行监听
        vm.liveRoomV.subscribe(onNext: {[weak self] (res) in
            guard let sf = self else {return}
            
            sf.liveRoomV.contentArr.onNext(res)
        }).disposed(by: bag)
        
        
        ///对直播间点击进行监听
        liveRoomV.clickRoomIDV.subscribe(onNext: { (res) in
            
            guard res.count != 0 else {return}
            let vc = MK_LiveRoomVC()
            
            vc.roomIdV.onNext(res)
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }).disposed(by: bag)
    }
    
}
