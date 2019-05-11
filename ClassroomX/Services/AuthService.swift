//
//  AuthService.swift
//  ClassroomX
//
//  Created by Sean Saoirse on 11/05/19.
//  Copyright © 2019 Sean Saoirse. All rights reserved.
//

import Foundation
class AuthService{
    static let instance = AuthService()
    let BASE_URL = "https://ae3392f5.ngrok.io/classroomx/"
    
    func login(email: String, pass: String, handler: @escaping(_ done: Bool)->()){
        let request = NSMutableURLRequest(url: NSURL(string: "\(BASE_URL)login.php")! as URL)
        request.httpMethod = "POST"
        let postString = "uname=\(email)&password=\(pass)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(String(describing: error))")
                handler(false)
            }else{
                print("response = \(String(describing: response))")
              
                
                handler(true)
            }
            
           
        }
        task.resume()
    }
    
    func checkLogin(email: String, pass: String,handler: @escaping(_ done: Bool)->()){
        let request = NSMutableURLRequest(url: NSURL(string: "\(BASE_URL)login.php")! as URL)
        request.httpMethod = "POST"
        let postString = "uname=\(email)&password=\(pass)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(String(describing: error))")
                handler(false)
            }else{
                
                guard let data = data else {return}
                
                do{
                    let user = try JSONDecoder().decode([StatusLoggedIn].self, from: data)
                    print(user[0].sessionUID!)
                    print(user[0].uname!)
                    if(user[0].status! == "success"){
                        handler(true)
                    }else{
                        print(user[0].status!)
                        
                        handler(false)
                    }
                    
                    
                }catch let jsonErr{
                    handler(false)
                    print("Error in fetching json: ", jsonErr)
                }
                
                
            }
            
            
        }
        task.resume()
       
    
}
}
