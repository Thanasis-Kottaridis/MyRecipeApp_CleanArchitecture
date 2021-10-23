//
//  ViewController.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 23/10/21.
//

import UIKit
import Alamofire

class ViewController: UIViewController, Storyboarded {

    override func viewDidLoad() {
        super.viewDidLoad()

        //1
        let sessionManager: Session = {
          //2
          let configuration = URLSessionConfiguration.af.default
          //3
          configuration.timeoutIntervalForRequest = 30
          //4
          return Session(configuration: configuration)
        }()
        
//        AF.request("https://vivawallet.free.beeceptor.com/v1/api/products").response {response in
//            debugPrint(response)
//        }

    }


}

