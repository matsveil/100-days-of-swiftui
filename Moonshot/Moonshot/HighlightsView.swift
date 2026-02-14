//
//  HighlightsView.swift
//  Moonshot
//
//  Created by Matsvei Liapich on 2/13/26.
//

import SwiftUI

struct HighlightsView: View {
    let mission: Mission
    
    var body: some View {
        Image(mission.image)
            .resizable()
            .scaledToFit()
            .containerRelativeFrame(.horizontal) { width, axis in
                width * 0.6
            }
        
        Text("Launched on \(mission.formattedLaunchDate)")
            .font(.headline)
            .foregroundStyle(.white.opacity(0.5))
            .padding(.top)
        
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
            .padding(.horizontal)
        
        VStack(alignment: .leading) {
            Text("Highlights")
                .font(.title.bold())
                .fontDesign(.monospaced)
                .padding(.bottom, 5)
            
            Text(mission.description)
            
            Rectangle()
                .frame(height: 2)
                .foregroundStyle(.lightBackground)
                .padding(.vertical)
            
            Text("Crew")
                .font(.title.bold())
                .fontDesign(.monospaced)
                .padding(.bottom, 5)
        }
        .padding(.horizontal)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")

    HighlightsView(mission: missions.first!)
        .preferredColorScheme(.dark)
}
