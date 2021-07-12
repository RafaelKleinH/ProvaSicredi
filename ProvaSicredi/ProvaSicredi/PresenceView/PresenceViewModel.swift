import Foundation
import RxSwift
import RxCocoa

final class PresenceViewModel {
    
    var coordinator: PresenceCoordinator
    var event: Event
    let pop = Popup()
    let apiMethods = APIMethods()
    let components = Components()
    var presenceViewString = PresenceViewStrings()
    var nameTextFieldText = PublishSubject<String>()
    var emailTextFieldText = PublishSubject<String>()
    var disposeBag = DisposeBag()
    
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
    
    func validateTextFields() -> Observable<Bool> {
        return Observable.combineLatest(nameTextFieldText.asObserver().startWith(""), emailTextFieldText.asObserver().startWith("")).map { (name, email) in
            
            if name != "" && email != ""{
                return true
            }else{
                return false
            }
        }
    }
}
