//
//  MK_CateTopRoomV.swift
//  HomePage
//
//  Created by 杨尚达 on 2018/11/23.
//  Copyright © 2018年 杨尚达. All rights reserved.
//

import SnapKit
import RxSwift
import Base


///分类前四推荐展示
class MK_CateTopRoomV : UICollectionView {
    
    let cellID = "CellID"
    
    let emptyCellID = "EmptyCellID"
    
    var bag = DisposeBag()
    
    ///内容数组
    lazy var contentArr = BehaviorSubject<[Model]>.init(value: [])
    
    ///布局方法
    var CollVlayout:MK_AppleMessageCollectionViewLayout!
    
    
    ///点击房间号
    let clickRoomIDV = BehaviorSubject<String>.init(value: "")
    
    init(){
        
        let layout = MK_AppleMessageCollectionViewLayout()
        
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        
        super.init(frame: CGRect.zero, collectionViewLayout: layout)
        
        CollVlayout = layout
        
        self.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.00)
        
        self.register(Item.self, forCellWithReuseIdentifier: cellID)
        self.register(UICollectionViewCell.self, forCellWithReuseIdentifier: emptyCellID)
        
        self.delegate = self
        self.dataSource = self
        
        self.contentInset = UIEdgeInsets.init(top: 10, left: 0, bottom: 10, right: 0)
        
        
        contentArr.asObserver().subscribe(onNext: {[weak self] (res) in
            
            self?.reloadData()
            self?.CollVlayout.reStareLayout()
            
        }).disposed(by: bag)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


///collectionView 代理方法
extension MK_CateTopRoomV : UICollectionViewDelegate,UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let arr = (try? contentArr.value()) ?? []
        
        return arr.count * 3
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (indexPath.row - 1)%3 == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! Item
            
            if let arr = try? contentArr.value(){
                cell.model = arr[(indexPath.row - 1)/3]
            }
            return cell
            
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: emptyCellID, for: indexPath)
            cell.backgroundColor = UIColor.clear
            return cell
        }
        
        
    }
    
    
}

extension MK_CateTopRoomV : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if (indexPath.row - 1)%3 == 0 {
            return CGSize.init(width: self.frame.width-25, height: 320)
        }else{
            return CGSize.init(width: 10, height: 300)
        }
        
    }
    
}
