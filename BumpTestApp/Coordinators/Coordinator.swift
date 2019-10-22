//
//  Coordinator.swift
//  BumpTestApp
//
//  Created by Iain McLean on 21/10/2019.
//  Copyright © 2019 Iain McLean. All rights reserved.
//

import Foundation
import UIKit


protocol Coordinator : AnyObject {
    
    var navigationController: UINavigationController { get set }
    
    func start()
}
