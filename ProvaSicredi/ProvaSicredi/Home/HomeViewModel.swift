//
//  HomeViewModel.swift
//  ProvaSicredi
//
//  Created by Rafael Hartmann on 28/06/21.
//

import Foundation

final class HomeViewModel {
    
    var homeCoordinator: HomeCoordinator
    
    let test = "Prova Sicredi Test do commit inicial"
    
    init(coordinator: HomeCoordinator) {
        homeCoordinator = coordinator
    }
    
}
