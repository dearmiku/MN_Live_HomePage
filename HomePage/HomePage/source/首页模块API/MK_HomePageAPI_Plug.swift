//
//  MK_HomePageAPI_Plug.swift
//  HomePage
//
//  Created by 杨尚达 on 2018/11/21.
//  Copyright © 2018年 杨尚达. All rights reserved.
//

import SwiftSoup


///首页API返回数据解析插件~
class MK_HomePageAPI_Plug {
    
    
    ///对首页HTML数据进行解析->([推荐直播间数组],[分类推荐数组])
    static func analyHomePageDataWith(str:String)->([LiveRoomModel],[MK_CateTopRoomV.Model]){
        
        guard let doc = try? SwiftSoup.parse(str) else {
            return ([],[])
        }
        
        /* 解析首页推荐直播间 */
        guard let recommandEl = try? doc.getElementsByClass("c-items"),
            let recommandArr = try? recommandEl.select("li") else {
                return ([],[])
        }
        ///遍历推荐直播间
        var recommandRoomArr :[LiveRoomModel] = []
        
        for item in recommandArr.array(){
            
            var model = LiveRoomModel()
            
            ///房间号
            if let roomID = try? item.attr("data-id") {
                model.roomID = roomID
            }
            
            ///房间缩略图
            if let roomImStr = try? item.select("img").attr("data-original") {
                
                model.roomImStr = roomImStr
            }
            
            ///房间名称
            if let roomName = try? item.getElementsByClass("txt").text(){
                
                model.roomName = roomName
            }
            
            recommandRoomArr.append(model)
        }
        
        
        /* 解析分类推荐直播信息 */
        
        guard let cateRecommadnEl = try? doc.getElementsByClass("row row-pack") else {
            return ([],[])
        }
        
        var cateModelArr:[MK_CateTopRoomV.Model] = []
        
        ///遍历分类信息
        for item in cateRecommadnEl.array() {
            
            var model = MK_CateTopRoomV.Model()
            
            ///分类名称
            if let cateName = try? item.attr("data-name") {
                model.title = cateName
            }
            ///若无法获取分类title 则是获取全部直播~
            if model.title.count == 0 {
                model.title = "全部直播"
            }
            
            ///分类ID
            if let cateID = try? item.select("a").attr("href") {
                
                model.cateID = (cateID as NSString).replacingOccurrences(of: "https://www.douyu.com/", with: "")
            }
            
            
            ///获取当前分类前4直播间
            if let contetArr = try? item.getElementsByClass("play-list clearfix").select("li").array(),
                contetArr.count >= 4 {
                
                ///房间1
                let room1 = contetArr[0]
                
                if let roomID = try? room1.attr("data-rid"),
                    let roomName = try? room1.select("a").attr("title"),
                    let roomImStr = try? room1.getElementsByClass("imgbox").select("img").attr("data-original"),
                    let liverHeadImStr = try? room1.getElementsByClass("mes").select("img").attr("data-original"),
                    let liverName = try? room1.getElementsByClass("dy-name ellipsis fl").text(),
                    let hotNumStr = try? room1.getElementsByClass("dy-num fr").text(){
                    
                    var roomModel = LiveRoomModel()
                    
                    roomModel.roomID = roomID
                    roomModel.roomImStr = roomImStr
                    roomModel.liverHeadStr = liverHeadImStr
                    roomModel.liverName = liverName
                    roomModel.hotNum = hotNumStr
                    roomModel.roomName = roomName
                    
                    model.room1Model = roomModel
                }
                
                ///房间2
                let room2 = contetArr[1]
                
                if let roomID = try? room2.attr("data-rid"),
                    let roomName = try? room2.select("a").attr("title"),
                    let roomImStr = try? room2.getElementsByClass("imgbox").select("img").attr("data-original"),
                    let liverHeadImStr = try? room2.getElementsByClass("mes").select("img").attr("data-original"),
                    let liverName = try? room2.getElementsByClass("dy-name ellipsis fl").text(),
                    let hotNumStr = try? room2.getElementsByClass("dy-num fr").text(){
                    
                    var roomModel = LiveRoomModel()
                    
                    roomModel.roomID = roomID
                    roomModel.roomImStr = roomImStr
                    roomModel.liverHeadStr = liverHeadImStr
                    roomModel.liverName = liverName
                    roomModel.hotNum = hotNumStr
                    roomModel.roomName = roomName
                    
                    model.room2Model = roomModel
                }
                
                ///房间3
                let room3 = contetArr[2]
                
                if let roomID = try? room3.attr("data-rid"),
                    let roomName = try? room3.select("a").attr("title"),
                    let roomImStr = try? room3.getElementsByClass("imgbox").select("img").attr("data-original"),
                    let liverHeadImStr = try? room3.getElementsByClass("mes").select("img").attr("data-original"),
                    let liverName = try? room3.getElementsByClass("dy-name ellipsis fl").text(),
                    let hotNumStr = try? room3.getElementsByClass("dy-num fr").text(){
                    
                    var roomModel = LiveRoomModel()
                    
                    roomModel.roomID = roomID
                    roomModel.roomImStr = roomImStr
                    roomModel.liverHeadStr = liverHeadImStr
                    roomModel.liverName = liverName
                    roomModel.hotNum = hotNumStr
                    roomModel.roomName = roomName
                    
                    model.room3Model = roomModel
                }
                
                ///房间4
                let room4 = contetArr[3]
                
                if let roomID = try? room4.attr("data-rid"),
                    let roomName = try? room4.select("a").attr("title"),
                    let roomImStr = try? room4.getElementsByClass("imgbox").select("img").attr("data-original"),
                    let liverHeadImStr = try? room4.getElementsByClass("mes").select("img").attr("data-original"),
                    let liverName = try? room4.getElementsByClass("dy-name ellipsis fl").text(),
                    let hotNumStr = try? room4.getElementsByClass("dy-num fr").text(){
                    
                    var roomModel = LiveRoomModel()
                    
                    roomModel.roomID = roomID
                    roomModel.roomImStr = roomImStr
                    roomModel.liverHeadStr = liverHeadImStr
                    roomModel.liverName = liverName
                    roomModel.hotNum = hotNumStr
                    roomModel.roomName = roomName
                    
                    model.room4Model = roomModel
                }
                
                
            }
            cateModelArr.append(model)
            
        }
        return (recommandRoomArr,cateModelArr)
    }
    
    ///分类信息解析
    static func analyCategoryWith(str:String)->(MK_CategoryInfoV.Model,[LiveRoomModel])?{
        
        guard let doc = try? SwiftSoup.parse(str) else {
            return nil
        }
        
        /* 获取分类描述信息 */
        guard let cateInfoEl = try? doc.getElementsByClass("listcustomize-topcon") else {
                return nil
        }
        
        var cateInfoModel = MK_CategoryInfoV.Model()
        
        ///分类描述图片
        if let cateImStr = try? cateInfoEl.select("img").attr("src"){
            cateInfoModel.cateImStr = cateImStr
        }
        
        ///分类名称
        if let cateNameStr = (try? cateInfoEl.array().first?.getElementsByClass("listcustomize-topcon-p").attr("title")) as? String{
            cateInfoModel.cateName = cateNameStr
        }
        
        ///分类描述
        if let cateDesStr = (try? cateInfoEl.array().first?.getElementsByClass("listcustomize-topcon-p").select("span").text()) as? String{
            cateInfoModel.cateDesStr = cateDesStr
        }
        
        /* 分类下直播间数组 */
        guard let roomListElArr = (try? doc.getElementById("live-list-contentbox")?.select("li")) as? Elements else {
            return nil
        }
        
        var roomModelArr:[LiveRoomModel] = []
        
        ///遍历直播间元素
        for item in roomListElArr.array() {
            
            var room = LiveRoomModel()
            
            ///直播间标题
            if let roomName = try? item.select("a").attr("title") {
                room.roomName = roomName
            }
            
            ///直播间缩略图
            if let roomImStr = try? item.select("img").attr("data-original"){
                room.roomImStr = roomImStr
            }
            
            ///直播间ID
            if let roomID = try? item.select("a").attr("data-rid"){
                room.roomID = roomID
            }
            
            ///主播名称
            if let liverName = try? item.getElementsByClass("dy-name ellipsis fl").text() {
                room.liverName = liverName
            }
            
            ///房间热度
            if let roomHotNum = try? item.getElementsByClass("dy-num fr").text() {
                room.hotNum = roomHotNum
            }
            
            room.catName = cateInfoModel.cateName
            room.liverHeadStr = cateInfoModel.cateImStr
            
            roomModelArr.append(room)
        }
        
        return (cateInfoModel,roomModelArr)
    }
    
    
}
