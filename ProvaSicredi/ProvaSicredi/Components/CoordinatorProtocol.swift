//
//  CoordinatorProtocol.swift
//  ProvaSicredi
//
//  Created by Rafael Hartmann on 28/06/21.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    init(navigationController: UINavigationController )
        
    func start()
}
