//
//  PresenceViewModel.swift
//  ProvaSicredi
//
//  Created by Rafael Hartmann on 29/06/21.
//

import Foundation

final class PresenceViewModel {
    
    var coordinator: PresenceCoordinator
    var event: Event
    
    init(coordinator: PresenceCoordinator, event: Event) {
        self.coordinator = coordinator
        self.event = event
    }
    
    func postPresence(email:String, name:String){
        let presence = PresenceDAO(email: email, name: name, eventId: event.id)
        
        APIMethods().PostPresence(onComplete: { (error) in
            if error == nil{
                
            }else{
                
            }
        }, body: presence)
    }
}
