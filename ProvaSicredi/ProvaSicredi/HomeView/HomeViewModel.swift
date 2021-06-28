//
//  HomeViewModel.swift
//  ProvaSicredi
//
//  Created by Rafael Hartmann on 28/06/21.
//

import Foundation

final class HomeViewModel {
    
    var homeCoordinator: HomeCoordinator
    var events: [Event] = []
    
    init(coordinator: HomeCoordinator) {
        homeCoordinator = coordinator
    }
    
    
    func getEvents(successIndicator: @escaping (Bool) -> Void){
        APIMethods().getEvents { (events, error) in
            if error == nil{
                if let events = events {
                    self.events = events
                    successIndicator(true)
                }
                else{
                    successIndicator(false)
                }
                
            }else{
                successIndicator(false)
            }
        }
        
    }
}
