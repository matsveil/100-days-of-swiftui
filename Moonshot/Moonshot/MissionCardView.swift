//
//  MissionCardView.swift
//  Moonshot
//
//  Created by Matsvei Liapich on 2/13/26.
//

import SwiftUI

struct MissionCardView: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    var body: some View {
        ForEach(missions) { mission in
            NavigationLink {
                MissionView(mission: mission, astronauts: astronauts)
            } label: {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding()
                    
                    VStack {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundStyle(.white)
                        
                        Text(mission.formattedLaunchDate)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.5))
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(.lightBackground)
                }
                .clipShape(.rect(cornerRadius: 20, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(.lightBackground)
                )
            }
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    MissionCardView(missions: missions, astronauts: astronauts)
}
