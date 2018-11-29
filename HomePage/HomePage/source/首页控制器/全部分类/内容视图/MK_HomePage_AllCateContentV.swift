//
//  MK_HomePage_AllCateContentV.swift
//  HomePage
//
//  Created by 杨尚达 on 2018/11/29.
//  Copyright © 2018年 杨尚达. All rights reserved.
//

import SnapKit
import Kingfisher
import Base
import RxSwift


///首页全部分类内容视图
class MK_HomePage_AllCateContentV : UICollectionView {
    
    var bag = DisposeBag()
    
    let cellId = "cellID"
    
    ///模型数组
    let modelArr = BehaviorSubject<[Model]>.init(value: [])
    
    init(){
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        
        layout.itemSize = CGSize.init(width: ScreenWidth / 4 - 10, height: (ScreenWidth / 4 - 10)*1.8)
        
        super.init(frame: CGRect.zero, collectionViewLayout: layout)
        
        self.contentInset = UIEdgeInsets.init(top: 3, left: 6, bottom: 3, right: 6)
        self.backgroundColor = UIColor.white
        self.register(Item.self, forCellWithReuseIdentifier: cellId)
        self.delegate = self
        self.dataSource = self
        
        ///对数据源进行监听
        modelArr.subscribe(onNext: {[weak self] (_) in
            
            guard let sf = self else {return}
            sf.reloadData()
            
        }).disposed(by: bag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MK_HomePage_AllCateContentV : UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let arr = try? modelArr.value() else {
            return 0
        }
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! Item
        
        if let arr = try? modelArr.value() {
            cell.model = arr[indexPath.row]
        }
        return cell
    }
    
    ///点击分类
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let arr = try? modelArr.value() {
            let model = arr[indexPath.row]
            
            let vc = MK_CategoryShowVC.init(cateID: model.cateId)
            MK_HomePageEntranVC.showVC?.pushViewController(vc, animated: true)
        }
    }
    
    
}


extension MK_HomePage_AllCateContentV {
    
    struct Model {
        
        ///分类示意图URL字符串
        var imURLStr:String = ""
        
        ///分类名称
        var cateNameStr:String = ""
        
        ///分类ID
        var cateId:String = ""
        
    }
    
    
    
    class Item : UICollectionViewCell {
        
        
        ///分类示意图
        lazy var cateImV = { () -> UIImageView in
            let res = UIImageView()
            addSubview(res)
            return res
        }()
        
        ///分类名称La
        lazy var cateLa = { () -> UILabel in
            let res = UILabel()
            res.textColor = UIColor.gray
            res.font = UIFont.systemFont(ofSize: 10)
            addSubview(res)
            return res
        }()
        
        var model:Model? {
            didSet{
                guard let res = model else {return}
                
                if let url = URL.init(string: res.imURLStr){
                    cateImV.kf.setImage(with: ImageResource.init(downloadURL: url))
                }
                
                cateLa.text = res.cateNameStr
                
            }
        }
        
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            self.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.00)
            
            self.layer.cornerRadius = 3
            self.layer.masksToBounds = true
            
            cateImV.snp.makeConstraints { (make) in
                make.left.right.top.equalToSuperview()
                make.bottom.equalToSuperview().offset(-20)
            }
            
            cateLa.snp.makeConstraints { (make) in
                make.bottom.equalToSuperview().offset(-3)
                make.centerX.equalToSuperview()
            }
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
    
    
}
