//
//  LocationDetailView.swift
//  Destinations
//
//  Created by Akhilesh Mishra on 11/03/25.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    
    @EnvironmentObject var vm: LocationViewModel
    
    let location: Location
    
    var body: some View {
        
        ScrollView {
            VStack {
                imageSection
                    .shadow(color: Color.black.opacity(0.3),
                            radius: 20,
                            x: 0,
                            y: 10)
                
                VStack(alignment: .leading) {
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayer
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
        .overlay(alignment: .topLeading) {
            closeButton
        }
    }
}

#Preview {
    LocationDetailView(location: LocationViewModel().locations.first!)
        .environmentObject(LocationViewModel())
}

extension LocationDetailView {
    
    private var imageSection: some View {
        
        TabView {
            ForEach(location.imageNames, id: \.self) { imageName in
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(.page)
    }
    
    private var titleSection: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundStyle(.secondary)
        }
    }
    
    private var descriptionSection: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            Text(location.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            if let url = URL(string: location.link) {
                Link("Read more on Wekepedia", destination: url)
                    .font(.headline)
                    .tint(.blue)
            }
        }
    }
    
    private var mapLayer: some View {
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let mapRegion = MKCoordinateRegion(center: location.coordinates, span: span)
        let cameraPosition = MapCameraPosition.region(mapRegion)
        
        return Map(position: .constant(cameraPosition)) {
                    Annotation(
                        location.name,
                        coordinate: location.coordinates) {
                            MapAnnotations()
                                .shadow(radius: 10)
                    }
                }
        .aspectRatio(1, contentMode: .fit)
        .allowsHitTesting(false)
        .cornerRadius(30)
    }
    
    private var closeButton: some View {
        
        Button {
            vm.sheetLocation = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundStyle(.primary)
                .background(.thickMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
            
        }

    }
}
