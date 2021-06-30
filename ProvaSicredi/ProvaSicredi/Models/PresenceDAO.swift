

import Foundation

class PresenceDAO: Codable {
    var email: String
    var name: String
    var eventId: String
    
    init(email: String, name: String, eventId: String) {
        self.email = email
        self.name = name
        self.eventId = eventId
    }
}
