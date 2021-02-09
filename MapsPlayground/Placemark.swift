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
            Placemark(name: "Bashkia", latitude: 43.312342323, longitude: 19.321423423),
            Placemark(name: "Ministria 1", latitude: 43.2332423342, longitude: 19.2342353),
            Placemark(name: "Ministria 2", latitude: 43.234234234, longitude: 19.3342234),
        ]
    }
    
}
