//
//  LocationPreview.swift
//  Destinations
//
//  Created by Akhilesh Mishra on 11/03/25.
//

import SwiftUI

struct LocationPreview: View {
    
    @EnvironmentObject var vm: LocationViewModel
    let location: Location
    
    var body: some View {
        
        HStack(alignment: .bottom, spacing: 0) {
            
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                titleSection
            }
            
            VStack(spacing: 8) {
                learnMoreButton
                nextButton
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
                .cornerRadius(10)
        )
        
    }
}

#Preview {
    ZStack {
        Color.green.ignoresSafeArea()
        
        LocationPreview(location: LocationViewModel().locations.first!)
            .padding()
            .environmentObject(LocationViewModel())
    }
}

extension LocationPreview {
    
    private var imageSection: some View {
        
            ZStack {
                if let imageName = location.imageNames.first {
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                }
            }
            .padding(6)
            .background(.white)
            .cornerRadius(10)
        
    }
    
    private var titleSection: some View {
        
        VStack(alignment: .leading, spacing: 4) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            Text(location.cityName)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var learnMoreButton: some View {
        
        Button {
            vm.sheetLocation = location
        } label: {
            Text("Learn more")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View {
        
        Button {
            vm.nextButtonPressed()
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.bordered)
    }
}
