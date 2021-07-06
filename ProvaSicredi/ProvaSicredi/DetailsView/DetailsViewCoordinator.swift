//
//  DetailsViewCoordinator.swift
//  ProvaSicredi
//
//  Created by Rafael Hartmann on 28/06/21.
//

import Foundation
import UIKit

final class DetailsViewCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var event: Event
    
    required init(navigationController: UINavigationController, event: Event) {
        self.navigationController = navigationController
        self.event = event
    }
    
    func start() {
        let viewModel = DetailsViewModel(coordinator:self, event: event)
        let viewController = DetailsViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func popToPrevius() {
        navigationController.popViewController(animated: true)
    }
    func goToPresenceView(){
        PresenceCoordinator(navigationController: navigationController, event: event).start()
    }
}
