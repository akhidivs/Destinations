//
//  LocationListView.swift
//  Destinations
//
//  Created by Akhilesh Mishra on 11/03/25.
//

import SwiftUI

struct LocationListView: View {
    
    @EnvironmentObject private var vm: LocationViewModel
    
    var body: some View {
        
        List {
            ForEach(vm.locations) { location in
                listItems(location)
                    .padding(.vertical, 4)
                    .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
        
    }
}

#Preview {
    LocationListView()
        .environmentObject(LocationViewModel())
}

extension LocationListView {
    
    private func listItems(_ location: Location) -> some View {
        
        Button {
            vm.showNextLocation(location)
        } label: {
            HStack {
                if let imageName = location.imageNames.first {
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 45, height: 45)
                        .cornerRadius(10)
                }
                
                VStack(alignment: .leading) {
                    Text(location.name)
                        .font(.headline)
                        .foregroundStyle(.primary)
                    Text(location.cityName)
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .foregroundStyle(.primary)
    }
}
