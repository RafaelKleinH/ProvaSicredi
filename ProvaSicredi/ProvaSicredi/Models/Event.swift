//
//  Event.swift
//  ProvaSicredi
//
//  Created by Rafael Hartmann on 28/06/21.
//

import Foundation


class Event: Codable {
    var people:[People]
    var date: Int
    var description: String
    var image: String
    var longitude: Double
    var latitude: Double
    var price: Double
    var title: String
    var id: String
//  var cupons:[cupom] <- comentado pois esta inutilizavel por falta de informações, mas existe na API.
}
