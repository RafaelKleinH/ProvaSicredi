//
//  APIService.swift
//  ProvaSicredi
//
//  Created by Rafael Hartmann on 28/06/21.
//

import Foundation

enum HTTPMethod {
    case GET
    case POST
}
enum ErrorType {
    case statusCode
    case decodable
    case url
}

final class APIService: Decodable {
    
    func callAPI(HTTPMethod: HTTPMethod = .GET, body: Data?, urlStringToRequest: String ,completion: @escaping (Data?, ErrorType?) -> Void) {
    
        guard let url = URL(string: urlStringToRequest) else {
            completion(nil, .url)
            return
            
        }
        var request = URLRequest(url:url)
         
        switch HTTPMethod {
        case .GET:
            let httpMethod: String = "GET"
            request.httpMethod = httpMethod
        case .POST:
            let httpMethod: String = "POST"
            request.httpMethod = httpMethod
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("*/*", forHTTPHeaderField: "accept")
            request.httpBody = body
        }
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if(error == nil){
                guard let response = response as? HTTPURLResponse, let _ = data else{
                    completion(nil, .statusCode)
                    return
                    
                }
                if response.statusCode == 200 {
                    if let data = data{
                        
                        completion(data, nil)
                        
                       
                    }
                }
                else{
                    completion(nil, .statusCode)
                    print(response.statusCode)
                }
        }
        else{
            completion(nil, .statusCode)
        }
        
            
    
        }.resume()
    
}
}
