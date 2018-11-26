//
//  MK_CateTopRoomCell.swift
//  HomePage
//
//  Created by 杨尚达 on 2018/11/23.
//  Copyright © 2018年 杨尚达. All rights reserved.
//

import SnapKit
import Base
import Kingfisher
import RxSwift


extension MK_CateTopRoomV {
    
    ///直播间Cell
    class Item : UICollectionViewCell {
        
        /* 类属性 */
        
        static let clickCateID = BehaviorSubject<String?>.init(value: nil)
        
        /********/
        
        var bag = DisposeBag()
        
        ///标题
        lazy var titleLa = { () -> UILabel in
            let res = UILabel()
            addSubview(res)
            return res
        }()
        
        ///更多按钮
        lazy var moreBu = { () -> UIButton in
            let res = UIButton()
            res.setTitle("更多", for: UIControl.State.normal)
            res.setTitleColor(UIColor.black, for: UIControl.State.normal)
            res.titleLabel?.font = UIFont.systemFont(ofSize: 10)
            addSubview(res)
            return res
        }()
        
        ///直播间1
        lazy var room1 = { () -> MK_CateTopRoomV.LiveRoom in
            let res = LiveRoom()
            addSubview(res)
            return res
        }()
        
        ///直播间2
        lazy var room2 = { () -> MK_CateTopRoomV.LiveRoom in
            let res = LiveRoom()
            addSubview(res)
            return res
        }()
        
        ///直播间3
        lazy var room3 = { () -> MK_CateTopRoomV.LiveRoom in
            let res = LiveRoom()
            addSubview(res)
            return res
        }()
        
        ///直播间4
        lazy var room4 = { () -> MK_CateTopRoomV.LiveRoom in
            let res = LiveRoom()
            addSubview(res)
            return res
        }()
        
        ///模型
        var model:Model? {
            didSet{
                guard let res = model else {return}
                
                titleLa.text = res.title                
                room1.model = res.room1Model
                room2.model = res.room2Model
                room3.model = res.room3Model
                room4.model = res.room4Model
                
            }
        }
        
        
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            self.backgroundColor = UIColor.white
            self.layer.cornerRadius = 3
            
            titleLa.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(6)
                make.top.equalToSuperview().offset(3)
            }
            moreBu.snp.makeConstraints { (make) in
                make.right.equalToSuperview().offset(-6)
                make.top.equalToSuperview().offset(3)
            }
            room1.snp.makeConstraints { (make) in
                make.left.equalTo(titleLa)
                make.top.equalToSuperview().offset(30)
                make.width.equalTo((ScreenWidth/2)-20)
                make.height.equalTo((ScreenWidth/2)-50)
            }
            room2.snp.makeConstraints { (make) in
                make.width.height.equalTo(room1)
                make.right.equalToSuperview().offset(-6)
                make.top.equalTo(room1)
            }
            room3.snp.makeConstraints { (make) in
                make.width.height.left.equalTo(room1)
                make.top.equalTo(room1.snp.bottom).offset(3)
            }
            room4.snp.makeConstraints { (make) in
                make.right.width.height.equalTo(room2)
                make.top.equalTo(room3)
            }
            
            
            ///对全部按钮点击事件进行监听
            moreBu.rx.tap.asObservable().subscribe(onNext: {[weak self] (_) in
                
                guard let sf = self,let res = sf.model else {return}
                
                Item.clickCateID.onNext(res.cateID)
                
            }).disposed(by: bag)
        
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
    }
    
    ///分类推荐模型
    struct Model {
        
        ///标题
        var title:String = ""
        
        ///分类ID
        var cateID:String = ""
        
        ///1号房间模型
        var room1Model:MK_LiveRoomCellModelProtocol?
        
        ///2号房间模型
        var room2Model:MK_LiveRoomCellModelProtocol?
        
        ///3号房间模型
        var room3Model:MK_LiveRoomCellModelProtocol?
        
        ///4号房间模型
        var room4Model:MK_LiveRoomCellModelProtocol?
        
        
        
    }
    
    
    
    ///直播间控件
    class LiveRoom : UIControl {
        
        ///房间缩略图
        lazy var roomImV = { () -> UIImageView in
            let res = UIImageView()
            addSubview(res)
            return res
        }()
        
        ///主播头像
        lazy var liverHeadImV = { () -> UIImageView in
            let res = UIImageView()
            addSubview(res)
            return res
        }()
        
        ///房间名称
        lazy var roomNameLa = { () -> UILabel in
            let res = UILabel()
            res.font = UIFont.systemFont(ofSize: 10)
            addSubview(res)
            return res
        }()
        
        ///主播名称
        lazy var liverName = { () -> UILabel in
            let res = UILabel()
            res.font = UIFont.systemFont(ofSize: 8)
            addSubview(res)
            return res
        }()
        
        ///热度
        lazy var hotNumLa = { () -> UILabel in
            let res = UILabel()
            res.font = UIFont.systemFont(ofSize: 8)
            addSubview(res)
            return res
        }()
        
        var model:MK_LiveRoomCellModelProtocol? {
            didSet{
                guard let res = model else {return}
                
                roomNameLa.text = res.roomNameStr
                liverName.text = res.liverNameStr
                hotNumLa.text = res.hotNumStr
                
                if let url = URL.init(string: res.liveHeadImStr) {
                    liverHeadImV.kf.setImage(with: ImageResource.init(downloadURL: url))
                }
                
                if let url = URL.init(string: res.liveRoomImStr) {
                    roomImV.kf.setImage(with: ImageResource.init(downloadURL: url))
                }
                
            }
        }
        
        init(){
            super.init(frame: CGRect.zero)
            
            self.backgroundColor = UIColor.white
            
            roomImV.snp.makeConstraints { (make) in
                make.left.top.equalToSuperview().offset(3)
                make.right.equalToSuperview().offset(-3)
                make.height.equalTo(ScreenWidth/4)
            }
            liverHeadImV.snp.makeConstraints { (make) in
                make.width.height.equalTo(30)
                make.left.equalTo(roomImV)
                make.top.equalTo(roomImV.snp.bottom).offset(6)
            }
            roomNameLa.snp.makeConstraints { (make) in
                make.top.equalTo(liverHeadImV)
                make.left.equalTo(liverHeadImV.snp.right).offset(3)
                make.right.equalToSuperview().offset(-3)
            }
            liverName.snp.makeConstraints { (make) in
                make.bottom.equalTo(liverHeadImV)
                make.left.equalTo(roomNameLa)
            }
            hotNumLa.snp.makeConstraints { (make) in
                make.bottom.equalTo(liverHeadImV)
                make.right.equalToSuperview().offset(-3)
            }
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
    
    
}
