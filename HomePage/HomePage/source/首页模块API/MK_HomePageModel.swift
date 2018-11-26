//
//  MK_HomePageModel.swift
//  HomePage
//
//  Created by 杨尚达 on 2018/11/21.
//  Copyright © 2018年 杨尚达. All rights reserved.
//

import Foundation
import Base


///直播间模型
struct LiveRoomModel : MK_LiveRoomCellModelProtocol {
    
    ///房间号
    var roomID:String = ""
    
    ///房间名称
    var roomName:String = ""
    
    ///房间缩略图
    var roomImStr:String = ""
    
    ///分类名称
    var catName:String = ""
    
    ///主播名称
    var liverName:String = ""
    
    ///主播头像
    var liverHeadStr:String = ""
    
    ///关注数
    var fansNum:String = ""
    
    ///热度
    var hotNum:String = ""
    
    
    /* 协议属性 */
    var roomNameStr: String {
        get{
            return roomName
        }
    }
    
    var cateNameStr: String {
        get{
            return catName
        }
    }
    
    var hotNumStr: String {
        get{
            return fansNum
        }
    }
    
    var liverNameStr: String {
        get{
            return liverName
        }
    }
    
    var liveHeadImStr: String {
        get{
            return liverHeadStr
        }
    }
    
    var liveRoomImStr: String {
        get {
            return roomImStr
        }
    }
    
    var roomIdStr: String {
        get {
            return roomID
        }
    }
}
