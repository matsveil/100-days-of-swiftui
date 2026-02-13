//
//  ContentView.swift
//  Moonshot
//
//  Created by Matsvei Liapich on 11/5/24.
//

import SwiftUI

struct ContentView: View {
    let astranauts: [String: Astranaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            Text("Detail View")
                        } label: {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                Text(mission.title)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
