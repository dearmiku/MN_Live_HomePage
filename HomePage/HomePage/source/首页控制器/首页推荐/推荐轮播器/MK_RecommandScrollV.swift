//
//  MK_HomePageRecommandV.swift
//  HomePage
//
//  Created by 杨尚达 on 2018/11/21.
//  Copyright © 2018年 杨尚达. All rights reserved.
//

import SnapKit
import LLCycleScrollView
import RxSwift


///首页推荐轮播器
class MK_RecommandScrollV : UIView {
    
    var bag = DisposeBag()
    
    ///轮播模型数组
    let showModelArr = BehaviorSubject<[LiveRoomModel]>.init(value: [])
    
    ///选中房间号
    let selectRoomID = BehaviorSubject<String>.init(value: "")
    
    
    ///轮播控件
    lazy var contentV = { () -> LLCycleScrollView in
        let res = LLCycleScrollView()
        res.autoScroll = true
        res.delegate = self
        addSubview(res)
        return res
    }()
    
    init(){
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = UIColor.white
        contentV.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
        ///对轮播数组监听
        showModelArr.subscribe(onNext: {[weak self] (res) in
            
            guard let sf = self else {return}
            
            sf.contentV.imagePaths = res.map({ (model) -> String in
                return model.roomImStr
            })
            
            sf.contentV.titles = res.map({ (model) -> String in
                return model.roomName
            })
            
        }).disposed(by: bag)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MK_RecommandScrollV : LLCycleScrollViewDelegate {
    
    
    func cycleScrollView(_ cycleScrollView: LLCycleScrollView, didSelectItemIndex index: NSInteger) {
        
        guard let roomID = (try? showModelArr.value())?[index].roomID else {return}
        
        selectRoomID.onNext(roomID)
    }
    
    
    
    
}
