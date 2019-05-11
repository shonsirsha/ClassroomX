//
//  Sys.swift
//  ClassroomX
//
//  Created by Sean Saoirse on 10/05/19.
//  Copyright © 2019 Sean Saoirse. All rights reserved.
//

import Foundation
import UIKit
struct System {
    static func clearNavigationBar(forBar navBar: UINavigationBar) {
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
    }
}
