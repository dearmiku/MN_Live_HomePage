//
//  MK_CategoryInfoV.swift
//  HomePage
//
//  Created by 杨尚达 on 2018/11/23.
//  Copyright © 2018年 杨尚达. All rights reserved.
//

import Base
import Kingfisher


///分类详情控件
class MK_CategoryInfoV : UIView {
    
    ///分类示意图
    lazy var cateShowImV = { () -> UIImageView in
        let res = UIImageView()
        addSubview(res)
        return res
    }()
    
    ///分类名称
    lazy var cateNameLa = { () -> UILabel in
        let res = UILabel()
        addSubview(res)
        return res
    }()
    
    ///分类描述
    lazy var cateDesLa = { () -> UILabel in
        let res = UILabel()
        res.font = UIFont.systemFont(ofSize: 8)
        res.numberOfLines = 0
        addSubview(res)
        return res
    }()
    
    var model:Model?{
        didSet{
            guard let res = model else {return}
            
            cateNameLa.text = res.cateName
            cateDesLa.text = res.cateDesStr
            
            if let url = URL.init(string: res.cateImStr){
               cateShowImV.kf.setImage(with: ImageResource.init(downloadURL: url))
            }
            
        }
    }
    
    
    init(){
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = UIColor.white
        
        cateShowImV.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.left.equalToSuperview().offset(6)
            make.centerY.equalToSuperview()
        }
        cateNameLa.snp.makeConstraints { (make) in
            make.top.equalTo(cateShowImV)
            make.left.equalTo(cateShowImV.snp.right).offset(6)
            make.height.equalTo(10)
        }
        cateDesLa.snp.makeConstraints { (make) in
            make.bottom.equalTo(cateShowImV)
            make.left.equalTo(cateNameLa)
            make.top.equalTo(cateNameLa.snp.bottom)
            make.right.equalToSuperview().offset(-6)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension MK_CategoryInfoV {
    
    struct Model {
        
        ///分类示意图
        var cateImStr:String = ""
        
        ///分类名称
        var cateName:String = ""
        
        ///分类描述
        var cateDesStr:String = ""
        
    }
    
}
