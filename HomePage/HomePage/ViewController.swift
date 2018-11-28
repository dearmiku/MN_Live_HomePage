//
//  ViewController.swift
//  HomePage
//
//  Created by 杨尚达 on 2018/11/21.
//  Copyright © 2018年 杨尚达. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import Base

class ViewController: UIViewController {
    
    var bag = DisposeBag()
    
    let provider = MoyaProvider<MK_HomePageTarget>()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
//        provider.rx.request(MK_HomePageTarget.home_recommand).mapString().subscribe(onSuccess: { (res) in
//
//            MK_HomePageAPI_Plug.analyHomePageDataWith(str: res)
//
//        }) { (err) in
//            print(err)
//        }.disposed(by: bag)
        

        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        
        let vc = MK_HomePageVC()
        
        //let vc = MK_CategoryShowVC.init(cateID: "g_jdqs")
        
        let nvc = MK_BaseNavigationVC.init(rootViewController: vc)
        self.present(nvc, animated: true, completion: nil)
    }

}

