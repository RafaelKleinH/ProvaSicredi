import Foundation
import CoreLocation
import UIKit
import MapKit
import RxSwift

final class DetailsViewModel {
    
    var coordinator: DetailsViewCoordinator
    var event: Event
    let assets = Assets()
    let detailsViewString = DetailsViewStrings()
    let components = Components()
    let disposeBag = DisposeBag()
    
    required init(coordinator:DetailsViewCoordinator, event: Event) {
        self.coordinator = coordinator
        self.event = event
    }
    
    func getEventLocation(localFormatted: @escaping (String) -> Void) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = event.latitude
        let lon: Double = event.longitude
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        ceo.reverseGeocodeLocation(loc, completionHandler: {(placemarks, error) in
            if let pm = placemarks{
                
                if pm.count > 0 {
                    let pm = placemarks?[0]
                    var addressString : String = ""
                    
                    if let pm = pm {
                        if let pmName = pm.name{
                            addressString = "\(addressString) \(pmName)"
                        }
                        if let pmSubLocality = pm.subLocality {
                            addressString = "\(addressString), \(pmSubLocality)"
                        }
                        if let pmLocality = pm.locality {
                            addressString = "\(addressString), \(pmLocality)"
                        }
                        if let pmCountry = pm.country {
                            addressString = "\(addressString), \(pmCountry)"
                        }
                        addressString = "\(addressString)."
                        localFormatted(addressString)
                    }else{
                        localFormatted("Erro ao buscar o local no mapa")
                    }
                }
            }else{
                localFormatted("Erro ao buscar o local no mapa")
                
            }
        })
    }
    
    func eventPinLocation(eventMap: MKMapView){
        let eventMKPoint = MKPointAnnotation()
        eventMKPoint.title = DetailsViewStrings().mapPinText
        eventMKPoint.coordinate = CLLocationCoordinate2D(latitude: self.event.latitude, longitude: event.longitude)
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.event.latitude, longitude: event.longitude), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        eventMap.addAnnotation(eventMKPoint)
        eventMap.setRegion(region, animated: true)
        
    }
    
    func shareEvent(with event: Event, image: UIImage?,onComplete: @escaping (UIActivityViewController) -> Void) {
        let title = "\(event.title)"
        let date = "Data: \(assets.convertEpochDateToString(epoch: event.date))"
        let price = "RS: \(event.price)"
        var activityController = UIActivityViewController(activityItems: [title, price, date], applicationActivities: nil)
        if let image = image {
            activityController = UIActivityViewController(activityItems: [title, price, date, image], applicationActivities: nil)
        }
        onComplete(activityController)
    }
    
    func decodeImageFromAPI(onComplete: @escaping (UIImage) -> Void){
        let url = URL(string: event.image)
        if let url = url {
            assets.getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                onComplete((UIImage(data:data) ?? UIImage(named: "imageError"))!)
                
            }
        }
    }
}
