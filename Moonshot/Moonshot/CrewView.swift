//
//  CrewView.swift
//  Moonshot
//
//  Created by Matsvei Liapich on 2/13/26.
//

import SwiftUI

struct CrewView: View {
    let crew: [CrewMember]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        VStack(alignment: .leading, spacing: 10) {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(.rect(cornerRadius: 20, style: .continuous))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .strokeBorder(.white, lineWidth: 1)
                                }
                            
                            VStack(alignment: .leading) {
                                Text(crewMember.role)
                                    .foregroundStyle(.white.opacity(0.5))
                                
                                Text(crewMember.astronaut.name)
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                }
            }
        }
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    CrewView(crew: [CrewMember(role: "Commander", astronaut: astronauts["armstrong"]!)])
        .preferredColorScheme(.dark)
}
