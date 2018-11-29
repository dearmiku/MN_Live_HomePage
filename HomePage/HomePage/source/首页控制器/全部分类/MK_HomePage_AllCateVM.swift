//
//  MK_HomePage_AllCateVM.swift
//  HomePage
//
//  Created by 杨尚达 on 2018/11/29.
//  Copyright © 2018年 杨尚达. All rights reserved.
//

import RxSwift
import Moya


class MK_HomePage_AllCateVM {
    
    let provider = MoyaProvider<MK_HomePageTarget>()
    
    var bag = DisposeBag()
    
    ///分类模型数组~
    let modelArr = BehaviorSubject<[MK_HomePage_AllCateContentV.Model]>.init(value: [])
    
    
    ///加载数据
    func loadData(){
        
        ///请求全部分类信息
        provider.rx.request(MK_HomePageTarget.allCategory).mapString().subscribe(onSuccess: {[weak self] (res) in
            
            guard let sf = self else {return}
            
            let arr = MK_HomePageAPI_Plug.analyAllCategoryDataSwith(str: res)
            
            sf.modelArr.onNext(arr)
            
        }) { (err) in
            
            }.disposed(by: bag)
        
    }
    
}
