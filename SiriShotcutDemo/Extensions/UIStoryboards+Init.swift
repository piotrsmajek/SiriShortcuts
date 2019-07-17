//
//  UIStoryboards+Init.swift
//  SiriShotcutDemo
//
//  Created by Piotr Smajek on 13/04/2019.
//  Copyright © 2019 Miquido. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    static func instantiateVC<T: UIViewController>(_ identifier: String) -> T {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
    
}
