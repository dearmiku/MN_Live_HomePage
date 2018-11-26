//
//  MK_CateShowVM.swift
//  HomePage
//
//  Created by 杨尚达 on 2018/11/23.
//  Copyright © 2018年 杨尚达. All rights reserved.
//

import Moya
import RxSwift


class MK_CategoryShowVM {
    
    var bag = DisposeBag()
    
    let provider = MoyaProvider<MK_HomePageTarget>()
    
    ///分类详情信息
    let cateInfoV = BehaviorSubject<MK_CategoryInfoV.Model?>.init(value: nil)
    
    ///分类下直播间数组
    let liveRoomV = BehaviorSubject<[LiveRoomModel]>.init(value: [])
    
    ///分类ID
    var cateID:String
    
    init(caetID:String){
        self.cateID = caetID
        
        provider.rx
            .request(MK_HomePageTarget.categoryInfo(caetID))
            .mapString()
            .subscribe(onSuccess: {[weak self] (res) in
                
                guard let sf = self else {return}
                
                if let (cateInfoModel,roomModelArr) = MK_HomePageAPI_Plug.analyCategoryWith(str: res){
                   
                    ///分类详情
                    sf.cateInfoV.onNext(cateInfoModel)
                    
                    ///直播间数组
                    sf.liveRoomV.onNext(roomModelArr)
                }
                
            }) { (err) in
                
            }.disposed(by: bag)
        
    }
    
}
