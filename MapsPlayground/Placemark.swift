//
//  Placemark.swift
//  MapsPlayground
//
//  Created by Roberta Jorgo on 3.2.21.
//

import Foundation

class Placemark {
    
    var name: String
    var website: String
    var telephone: String
    
    var latitude: Double
    var longitude: Double
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        
        self.website = "https://google.com"
        self.telephone = "123456"
    }
    
    static func mock() -> [Placemark] {
        return [
            Placemark(name: "Bashkia", latitude: 41.3274082, longitude: 19.8171285),
            Placemark(name: "Ministria 1", latitude: 41.3300837, longitude: 19.8297348),
            Placemark(name: "Ministria 2", latitude: 41.3325816, longitude: 19.8146956),
        ]
    }
    
}
