//
//  APIMethods.swift
//  ProvaSicredi
//
//  Created by Rafael Hartmann on 28/06/21.
//

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
    
}
