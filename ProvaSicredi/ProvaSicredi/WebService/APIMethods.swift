
import Foundation

final class APIMethods {
    
    func getEvents(onComplete: @escaping ([Event]?, ErrorType?) -> Void){
        let url = "http://5f5a8f24d44d640016169133.mockapi.io/api/events"
        
        APIService().callAPI(body: nil, urlStringToRequest: url) { (data, error) in
            if error == nil{
                if let data = data{
                    do{
                        let data = try JSONDecoder().decode([Event].self, from: data)
                        onComplete(data, nil)
                    }
                    catch{
                        print("JSON Serialization error")
                        onComplete(nil,.decodable)
                    }
                }
            }else{
                onComplete(nil,error)
            }
        }
    }
    
    func PostPresence(onComplete: @escaping (ErrorType?) -> Void ,body: PresenceDAO) {
        let url = "http://5f5a8f24d44d640016169133.mockapi.io/api/checkin"
        guard let body = try? JSONEncoder().encode(body) else {return}
        
        APIService().callAPI(HTTPMethod: .POST ,body: body, urlStringToRequest: url) { (data, error) in
            if error == nil{
                onComplete( nil)
            }else{
                onComplete(.decodable)
            }
        }
    }
}
