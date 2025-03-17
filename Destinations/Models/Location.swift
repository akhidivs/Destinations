//
//  Location.swift
//  Destinations
//
//  Created by Akhilesh Mishra on 10/03/25.
//

import Foundation
import MapKit

struct Location: Identifiable, Equatable {
    
    var id: String { return name + cityName }
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageNames: [String]
    let link: String
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
