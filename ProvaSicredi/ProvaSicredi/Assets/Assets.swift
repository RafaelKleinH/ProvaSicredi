//
//  Assets.swift
//  ProvaSicredi
//
//  Created by Rafael Hartmann on 09/07/21.
//

import Foundation

class Assets {
    func convertEpochDateToString(epoch: Int) -> String{
        let timeInterval = TimeInterval(epoch)
        let myDate = NSDate(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy 'às' HH:mm"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: -3600*3)
        let ConvertedDate = dateFormatter.string(from: myDate as Date)
        return "\(ConvertedDate)"
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}
