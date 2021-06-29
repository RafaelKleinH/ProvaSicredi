//
//  DetailsViewmodel.swift
//  ProvaSicredi
//
//  Created by Rafael Hartmann on 28/06/21.
//

import Foundation
import CoreLocation

final class DetailsViewModel {
    
    
    var coordinator: DetailsViewCoordinator
    var event: Event
    
    required init(coordinator:DetailsViewCoordinator, event: Event) {
        self.coordinator = coordinator
        self.event = event
    }
    
    func getLocation(dateFormatted: @escaping (String) -> Void) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = event.latitude
        //21.228124
        let lon: Double = event.longitude
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon

        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)


        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error)  in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]

                if pm.count > 0 {
                    let pm = placemarks![0]
                    var addressString : String = ""
                    if pm.name != nil{
                        addressString = addressString + pm.name! + ", "
                    }
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + " "
                    }
                    

                    dateFormatted(addressString)
                  
              }
                
        })
        
    }
}
