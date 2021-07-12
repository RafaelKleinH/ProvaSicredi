import Foundation

enum SetupHomeConstraintsEnum {
    case loading
    case table
    case error
}
enum EnumRemoveType {
    case tableView
    case error
}

final class HomeViewModel {
    
    var homeCoordinator: HomeCoordinator
    var events: [Event] = []
    let homeViewStrings = HomeViewStrings()
    
    init(coordinator: HomeCoordinator) {
        homeCoordinator = coordinator
    }
    
    func getEvents(successIndicator: @escaping (Bool) -> Void){
        APIMethods().getEvents { [weak self] (events, error) in
            if let events = events {
                self?.events = events
                successIndicator(true)
            }
            else{
                successIndicator(false)
            }
        }
    }
}
