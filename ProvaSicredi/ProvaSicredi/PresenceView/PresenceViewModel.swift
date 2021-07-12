import Foundation

final class PresenceViewModel {
    
    var coordinator: PresenceCoordinator
    var event: Event
    let pop = Popup()
    let apiMethods = APIMethods()
    var presenceViewString = PresenceViewStrings()
    
    init(coordinator: PresenceCoordinator, event: Event) {
        self.coordinator = coordinator
        self.event = event
    }
    
    func postPresence(email:String, name:String,completion: @escaping (ErrorType?) -> Void){
        let presence = PresenceDAO(email: email, name: name, eventId: event.id)
        
        apiMethods.PostPresence(onComplete: { (error) in
            completion(error)
        }, body: presence)
    }
}
