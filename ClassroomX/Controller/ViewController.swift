//
//  ViewController.swift
//  ClassroomX
//
//  Created by Sean Saoirse on 09/05/19.
//  Copyright © 2019 Sean Saoirse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        if(sentShowHelloVCWhenDismissed){
            performSegue(withIdentifier: "goToLogin", sender: self)
        }else{
            print("NOT SHOWING")
        }
       
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       /* let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)// This will show in the next view controller being pushed*/
    }

}

