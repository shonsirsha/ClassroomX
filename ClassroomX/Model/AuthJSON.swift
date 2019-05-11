//
//  AuthJSON.swift
//  ClassroomX
//
//  Created by Sean Saoirse on 11/05/19.
//  Copyright © 2019 Sean Saoirse. All rights reserved.
//

import Foundation
struct StatusLoggedIn: Decodable{
    let uname: String?
    let sessionUID: Int?
    let status: String?
}
