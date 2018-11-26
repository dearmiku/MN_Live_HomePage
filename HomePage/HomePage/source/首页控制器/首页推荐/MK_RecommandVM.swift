//
//  MK_RecommandVM.swift
//  HomePage
//
//  Created by 杨尚达 on 2018/11/22.
//  Copyright © 2018年 杨尚达. All rights reserved.
//

import Moya
import RxSwift


///推荐控制器VM
class MK_RecommandVM {
    
    var bag = DisposeBag()
    
    let provider = MoyaProvider<MK_HomePageTarget>()
    
    
    ///推荐直播间数组
    let recommandRoomArr = BehaviorSubject<[LiveRoomModel]>.init(value: [])
    
    ///分类推荐数组
    let cateRecommandRoomArr = BehaviorSubject<[MK_CateTopRoomV.Model]>.init(value: [])
    
    
    ///刷新数据
    func loadNewData(){
        
        provider.rx
            .request(MK_HomePageTarget.home_recommand)
            .mapString()
            .subscribe(onSuccess: {[weak self] (res) in
                
                guard let sf = self else {return}
                
                let (reCo,cateReco) = MK_HomePageAPI_Plug.analyHomePageDataWith(str: res)
                
                sf.recommandRoomArr.onNext(reCo)
                sf.cateRecommandRoomArr.onNext(cateReco)
                
            }) { (err) in
                
        }.disposed(by: bag)
        
    }
    
}
