//
//  Storyboarded.swift
//  BumpTestApp
//
//  Created by Iain McLean on 21/10/2019.
//  Copyright © 2019 Iain McLean. All rights reserved.
//

import Foundation
import UIKit

protocol StoryBoarded {
    
    static func instantiate() -> Self
}

extension StoryBoarded where Self: UIViewController {
    
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(identifier: id) as! Self
    }
}

