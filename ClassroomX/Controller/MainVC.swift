//
//  MainVC.swift
//  ClassroomX
//
//  Created by Sean Saoirse on 14/05/19.
//  Copyright © 2019 Sean Saoirse. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
var loggedIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(sessionDetail.count < 1){
            print("this shudnt be possible")
            loggedIn = false
        }else{
            print(sessionDetail[0].session)
            loggedIn = true
        }
        // Do any additional setup after loading the view.
    }
    
}
