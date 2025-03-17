//
//  LocationView.swift
//  Destinations
//
//  Created by Akhilesh Mishra on 10/03/25.
//

import SwiftUI
import MapKit

struct LocationView: View {
    
    @EnvironmentObject private var vm: LocationViewModel
    
    var body: some View {
        
        ZStack {
            mapLayer
            
            VStack(spacing: 0) {
                header
                    .padding()
                Spacer()
                locationPreviewStack
            }
        }
        .sheet(item: $vm.sheetLocation) { location in
            LocationDetailView(location: location)
        }
    }
}

#Preview {
    LocationView()
        .environmentObject(LocationViewModel())
}

extension LocationView {
    
    private var mapLayer: some View {
        
        Map(position: .constant(vm.cameraPosition)) {
            ForEach(vm.locations) { location in
                Annotation(
                    location.name,
                    coordinate: location.coordinates) {
                        MapAnnotations()
                            .scaleEffect(
                                location == vm.mapLocation ? 1.0 : 0.7
                            )
                            .shadow(radius: 10)
                            .onTapGesture {
                                vm.showNextLocation(location)
                            }
                }
            }
        }
    }
    
    private var header: some View {
        
        VStack {
            Button {
                vm.toggleLocationList()
            } label: {
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundStyle(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundStyle(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: (vm.showLocationList ? 180 : 0)))
                    }
            }
            .foregroundStyle(.primary)
            
            if vm.showLocationList {
                LocationListView()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3),
                radius: 20,
                x: 0,
                y: 15)
    }
    
    private var locationPreviewStack: some View {
        
        ZStack {
            ForEach(vm.locations) { location in
                if vm.mapLocation == location {
                    LocationPreview(location: location)
                        .shadow(color: Color.black.opacity(0.3),
                                radius: 20)
                        .padding()
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
    }
}
