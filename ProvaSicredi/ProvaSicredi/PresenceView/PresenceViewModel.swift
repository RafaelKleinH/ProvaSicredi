

import Foundation

final class PresenceViewModel {
    
    var coordinator: PresenceCoordinator
    var event: Event
    let pop = Popup()
    
    let navigationItemText = "Inscrição"
    let leftBarButtonImage = "arrow"
    let submitButtonTitle = "Enviar"
    let nameTextFieldPlaceHolder = "Nome"
    let emailTextFieldPlaceHolder = "Email"
    let emailErrorText = "Insira um email válido."
    let nameErrorText = "Insira um nome válido"
    
    init(coordinator: PresenceCoordinator, event: Event) {
        self.coordinator = coordinator
        self.event = event
    }
    
    func postPresence(email:String, name:String,completion: @escaping (ErrorType?) -> Void){
        let presence = PresenceDAO(email: email, name: name, eventId: event.id)
        
        APIMethods().PostPresence(onComplete: { (error) in
            completion(error)
        }, body: presence)
    }
}
