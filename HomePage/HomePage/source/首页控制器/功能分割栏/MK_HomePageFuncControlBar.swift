//
//  MK_HomePageFuncSwitchBar.swift
//  HomePage
//
//  Created by 杨尚达 on 2018/11/27.
//  Copyright © 2018年 杨尚达. All rights reserved.
//

import Base
import SnapKit
import RxSwift



///首页功能控制栏
class MK_HomePageFuncControlBar : UIView {
    
    var bag = DisposeBag()
    
    ///状态
    let state = BehaviorSubject<State>.init(value: MK_HomePageFuncControlBar.State.homePageRecommand)
    
    
    
    ///分类La
    lazy var cateLa = { () -> UILabel in
        let res = UILabel()
        res.text = "分类"
        addSubview(res)
        return res
    }()
    
    ///首页La
    lazy var homePageLa = { () -> UILabel in
        let res = UILabel()
        res.text = "首页"
        addSubview(res)
        return res
    }()
    
    ///全部直播La
    lazy var allLiveLa = { () -> UILabel in
        let res = UILabel()
        res.text = "直播"
        addSubview(res)
        return res
    }()
    
    
    
    init(){
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = UIColor.white
        
        cateLa.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-6)
        }
        homePageLa.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(cateLa)
        }
        allLiveLa.snp.makeConstraints { (make) in
            make.bottom.equalTo(cateLa)
            make.right.equalToSuperview().offset(-12)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension MK_HomePageFuncControlBar {
    
    ///状态
    enum State {
        
        ///分类
        case allCate
        
        ///首页
        case homePageRecommand
        
        ///全部直播
        case allLive
    }
    
}
