//
//  PresenceCoordinator.swift
//  ProvaSicredi
//
//  Created by Rafael Hartmann on 29/06/21.
//

import Foundation
import UIKit


final class PresenceCoordinator: Coordinator {
    var navigationController: UINavigationController
    var event: Event
    
    init(navigationController: UINavigationController, event: Event ) {
        self.navigationController = navigationController
        self.event = event
    }
    
    func start() {
        let viewModel = PresenceViewModel(coordinator: self, event: event)
        let viewController = PresenceViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func popToPrevius() {
        
        navigationController.popViewController(animated: true)
        
    }
    
    
    
}
