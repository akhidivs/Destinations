//
//  LocationViewModel.swift
//  Destinations
//
//  Created by Akhilesh Mishra on 10/03/25.
//

import Foundation
import SwiftUI
import MapKit

class LocationViewModel: ObservableObject {
    
    // all the locations
    @Published var locations: [Location]
    
    // current map region
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    // show location menu
    @Published var showLocationList: Bool = false
    
    // show detail sheet
    @Published var sheetLocation: Location? = nil
    
    // current camera position
    var cameraPosition: MapCameraPosition {
        return MapCameraPosition.region(mapRegion)
    }
    
    // current map span
    private var mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    
    init() {
        
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        
        self.updateMapRegion(location: mapLocation)
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeOut) {
            mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
        }
    }
    
    func toggleLocationList() {
        withAnimation(.easeInOut) {
            showLocationList = !showLocationList
        }
    }
    
    func showNextLocation(_ location: Location) {
        withAnimation {
            mapLocation = location
            showLocationList = false
        }
    }
    
    func nextButtonPressed() {
        
        // get current index
        guard let currentIndex = locations.firstIndex(where: { location in
            location == mapLocation
        }) else { return }
        
        let nextIndex = currentIndex + 1
        if nextIndex < locations.count {
            showNextLocation(locations[nextIndex])
        } else {
            showNextLocation(locations[0])
        }
    }
}
