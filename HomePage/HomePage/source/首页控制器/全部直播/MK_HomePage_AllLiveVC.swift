//
//  MK_HomePage_AllLiveVC.swift
//  HomePage
//
//  Created by 杨尚达 on 2018/11/28.
//  Copyright © 2018年 杨尚达. All rights reserved.
//

import SnapKit
import Base
import LivingRoom


///全部直播展示控制器
class MK_HomePage_AllLiveVC : MK_BaseVC {
    
    
    let vm = MK_HomePage_AllLiveVM()
    
    
    lazy var contentV = { () -> MK_liveRoomListContentV in
        let res = MK_liveRoomListContentV.init()
        view.addSubview(res)
        return res
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentV.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        ///对vm分类下直播间数组进行监听
        vm.liveRoomV.subscribe(onNext: {[weak self] (res) in
            guard let sf = self else {return}
            
            sf.contentV.contentArr.onNext(res)
        }).disposed(by: bag)
        
        
        ///对直播间点击进行监听
        contentV.clickRoomIDV.subscribe(onNext: { (res) in
            
            guard res.count != 0 else {return}
            let vc = MK_LiveRoomVC()
            
            vc.roomIdV.onNext(res)
            
            MK_HomePageEntranVC.showVC?.pushViewController(vc, animated: true)
            
        }).disposed(by: bag)
        
        OperationQueue.main.addOperation {
            self.vm.loadData()
        }
    }
    
    
    
}
