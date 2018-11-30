//
//  MK_HomePage_AllLiveVM.swift
//  HomePage
//
//  Created by 杨尚达 on 2018/11/29.
//  Copyright © 2018年 杨尚达. All rights reserved.
//

import Moya
import RxSwift



class MK_HomePage_AllLiveVM {
    
    var bag = DisposeBag()
    
    let provider = MoyaProvider<MK_HomePageTarget>()

    ///分类下直播间数组
    let liveRoomV = BehaviorSubject<[LiveRoomModel]>.init(value: [])
    
    
    ///全部直播的分类id
    let allLiveCateID:String = "directory/all"
    
    
    ///加载数据
    func loadData(){
        
        provider.rx
            .request(MK_HomePageTarget.categoryInfo(allLiveCateID))
            .mapString()
            .subscribe(onSuccess: {[weak self] (res) in
                
                guard let sf = self else {return}
                
                if let (_,roomModelArr) = MK_HomePageAPI_Plug.analyCategoryWith(str: res){
                    
                    ///直播间数组
                    sf.liveRoomV.onNext(roomModelArr)
                }
                
            }) { (err) in
                
            }.disposed(by: bag)
        
    }
    
}
