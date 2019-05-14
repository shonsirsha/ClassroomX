//
//  AuthService.swift
//  ClassroomX
//
//  Created by Sean Saoirse on 11/05/19.
//  Copyright © 2019 Sean Saoirse. All rights reserved.
//

import Foundation
import UIKit
import CoreData
var sessionDetail = [SessionStore]()

class AuthService{
    static let instance = AuthService()
    let BASE_URL = "https://6e00fca1.ngrok.io/classroomx/"
    let appDel = UIApplication.shared.delegate as? AppDelegate
    
    func login(email: String, pass: String,handler: @escaping(_ done: [String])->()){ // checks if login successful
        var arrHandler = [String]()

        let request = NSMutableURLRequest(url: NSURL(string: "\(BASE_URL)login.php")! as URL)
        request.httpMethod = "POST"
        let postString = "uname=\(email)&password=\(pass)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(String(describing: error))")
                arrHandler = ["0", "fatalerr1", "fatalerr1", "fatalerr1"]
                handler(arrHandler)
            }else{
                
                guard let data = data else {return}
                
                do{
                    let user = try JSONDecoder().decode([StatusLoggedIn].self, from: data)
                 
                    
                    arrHandler = ["\(user[0].status!)", "\(user[0].sessionUID!)", "\(user[0].uname!)"]
                    
                    handler(arrHandler)

                    
                    
                    
                }catch let jsonErr{
                    arrHandler = ["-1", "fatalerr0", "fatalerr0", "fatalerr0"]
                    handler(arrHandler)
                    print("Error iXXXXXn fetching json: ", jsonErr)
                }
                
                
            }
            
            
        }
        task.resume()
       
    
}
    
    func checkSession(handler: @escaping(_ result: Int)->()){
        let jsonURLString = "\(BASE_URL)test.php"
        
        guard let url = URL(string: jsonURLString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            // check err
            // check response status 200 OK
            guard let data = data else {return}
            do{
                let sessionStatus = try JSONDecoder().decode([SessionStatus].self, from: data)
                handler(sessionStatus[0].status!)
                /*let defaults = UserDefaults.standard*/
                
            }catch let jsonErr{
                print("Error in fetching json: ", jsonErr)
            }
            }.resume()
        
    }
    
    func fetchSeshLocal(handler: @escaping(_ done: Bool)->()){
        
        guard let managedContext = appDel?.persistentContainer.viewContext else {return}
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "SessionStore")
        
        do{
            sessionDetail = try managedContext.fetch(fetchReq) as! [SessionStore]
            handler(true)
        }catch{
            debugPrint("Error cant save \(error.localizedDescription)")
            handler(false)
        }
        
    }
    
}
