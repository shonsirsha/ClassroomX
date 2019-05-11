//
//  LoginVC.swift
//  ClassroomX
//
//  Created by Sean Saoirse on 11/05/19.
//  Copyright © 2019 Sean Saoirse. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
 
    @IBOutlet weak var pwTfield: UITextField!
    @IBOutlet weak var unameTfield: UITextField!
    
    
    
   let alert = UIAlertController(title: nil, message: "Logging in...", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Reachability.isConnectedToNetwork(){
            
        }else{
            print("No internet connection detected")

        }
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        pwTfield.resignFirstResponder()
        unameTfield.resignFirstResponder()
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        
        if Reachability.isConnectedToNetwork(){

            present(alert, animated: true, completion: nil)
           
            AuthService.instance.login(email: unameTfield.text!, pass: pwTfield.text!) { (status) in
                if(status){
                    DispatchQueue.main.async {
                        AuthService.instance.checkLogin(email: self.unameTfield.text!, pass: self.pwTfield.text!, handler: { (status2) in
                            if(status2){
                                DispatchQueue.main.async {
                                    self.pwTfield.resignFirstResponder()
                                    self.unameTfield.resignFirstResponder()
                                    self.alert.dismiss(animated: true, completion: {
                                        self.dismiss(animated: true, completion: nil)
                                    })
                                }
                                
                               
                            }else{
                                print("AAAXX")
                            }
                        })
                    }
                }else{
                    print("GGGG")
                }
            }
        }else{
            print("No internet connection detected")
        }
        
        
        
    }
    
    
    
    
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
