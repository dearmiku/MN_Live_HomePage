//
//  MK_HomePageProvider.swift
//  HomePage
//
//  Created by 杨尚达 on 2018/11/21.
//  Copyright © 2018年 杨尚达. All rights reserved.
//

import Alamofire
import Moya


///首页网络API
enum MK_HomePageTarget {
    
    
    ///首页推荐信息
    case home_recommand
    
    ///分类详情信息(分类ID)
    case categoryInfo(String)
    
}


extension MK_HomePageTarget : TargetType {
    
    var baseURL: URL {
        
        switch self{
            
        default:
            return URL.init(string: "https://www.douyu.com/")!
        }
    }
    
    var path: String {
        
        switch self{
            
        case .home_recommand:
            return ""
            
        case let .categoryInfo(cateID):
            return cateID
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self{
            
        case .home_recommand:
            return .get
            
        case .categoryInfo(_):
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self{
            
        case .home_recommand:
            return Task.requestParameters(parameters: [:], encoding: URLEncoding.default)
            
        case .categoryInfo(_):
            return Task.requestParameters(parameters: [:], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
    
}



