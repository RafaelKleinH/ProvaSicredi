//
//  Comenents.swift
//  ProvaSicredi
//
//  Created by Rafael Hartmann on 28/06/21.
//

import Foundation

class Components {
    func convertEpochDate(epoch: Int) -> String{
        let timeInterval = TimeInterval(epoch)
        let myDate = NSDate(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy 'ás' HH:mm"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: -3600*3)
        let ConvertedDate = dateFormatter.string(from: myDate as Date)
        return "\(ConvertedDate)"
    }
}
