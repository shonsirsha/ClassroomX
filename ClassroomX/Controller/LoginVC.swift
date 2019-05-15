//
//  LoginVC.swift
//  ClassroomX
//
//  Created by Sean Saoirse on 11/05/19.
//  Copyright © 2019 Sean Saoirse. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    let appDel = UIApplication.shared.delegate as? AppDelegate

 
    @IBOutlet weak var pwTfield: UITextField!
    @IBOutlet weak var unameTfield: UITextField!
    
    
    
   let alert = UIAlertController(title: nil, message: "Logging in...", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sentShowHelloVCWhenDismissed = false
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
            
            self.pwTfield.resignFirstResponder()
            self.unameTfield.resignFirstResponder()

            present(alert, animated: true, completion: nil)
            guard let managedContext = appDel?.persistentContainer.viewContext else {return}
                        AuthService.instance.login(email: self.unameTfield.text!, pass: self.pwTfield.text!, handler: { (status2) in
                            if(status2[0] == "0" || status2[0] == "-1"){
                                
                                DispatchQueue.main.sync {
                                    self.alert.dismiss(animated: true, completion: nil)
                                    let alert2 = UIAlertController(title: "Sorry! 😢", message: "There was an error signing you in. Please check your connection and try again.", preferredStyle: .alert)
                                    
                                    alert2.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction) in
                                        print("OK")
                                    }))
                                    self.present(alert2, animated: true, completion: nil)
                                }
                                
                                
                            }else{
                                if(status2[0] == "wrongpw"){
                                    
                                    DispatchQueue.main.sync {
                                        self.alert.dismiss(animated: true, completion: nil)
                                        let alert2 = UIAlertController(title: "Oops... 😳", message: "Sorry, the password you have entered is invalid. Please try again.", preferredStyle: .alert)
                                        
                                        alert2.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction) in
                                            print("OK")
                                        }))
                                        self.present(alert2, animated: true, completion: nil)
                                        self.pwTfield.becomeFirstResponder()

                                    }
                                    
                                }else if(status2[0] == "failed"){
                                    
                                    DispatchQueue.main.sync {
                                        self.alert.dismiss(animated: true, completion:nil)
                                        
                                        let alert2 = UIAlertController(title: "Uh-oh... 😧", message: "Sorry, we can't find that username. Have you signed up?", preferredStyle: .alert)
                                        
                                        alert2.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction) in
                                            print("OK")
                                        }))
                                        self.present(alert2, animated: true, completion: nil)
                                        self.unameTfield.becomeFirstResponder()
                                    }
                                    
                                }else if(status2[0] == "success"){
                                    let user = SessionStore(context: managedContext)
                                    DispatchQueue.main.async {
                                        user.username = self.unameTfield.text!

                                    }
                                    guard let session  = Int32(status2[1]) else {return}
                                    user.session = session
                                    
                                    do{
                                        try managedContext.save()
                                    }catch{
                                        print("Error saving sesh:: \(error.localizedDescription)")
                                    }
                                    
                                    DispatchQueue.main.async {
                                   
                                        self.alert.dismiss(animated: true, completion: {
                                        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                                        })
                                    }
                                }
                                
                                print("AAAXX")
                            }
                        })
                    
        }else{
            let alert2 = UIAlertController(title: "No Connection 😴", message: "No internet connection. Connect your device to the internet and try again.", preferredStyle: .alert)
            
            alert2.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction) in
                print("OK")
            }))
            self.present(alert2, animated: true, completion: nil)
        }
        
        
        
    }
    
    
    
    
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
