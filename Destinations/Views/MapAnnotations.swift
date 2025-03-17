//
//  MapAnnotations.swift
//  Destinations
//
//  Created by Akhilesh Mishra on 11/03/25.
//

import SwiftUI

struct MapAnnotations: View {
    var body: some View {
        
        VStack(spacing: 0) {
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .font(.headline)
                .foregroundStyle(.white)
                .padding(6)
                .background(.accent)
                .cornerRadius(36)
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.accent)
                .frame(width: 10, height: 10)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -3)
                .padding(.bottom, 35)
                
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        MapAnnotations()
    }
}
