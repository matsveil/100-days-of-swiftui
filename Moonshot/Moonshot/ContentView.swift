//
//  ContentView.swift
//  Moonshot
//
//  Created by Matsvei Liapich on 11/5/24.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let columns = [
        GridItem(.adaptive(minimum: 130))
    ]
    
    @State private var view: ViewType = .grid
    
    private enum ViewType {
        case list
        case grid
        
        var icon: String {
            switch self {
            case .list:
                "list.bullet"
            case .grid:
                "square.grid.2x2"
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Group {
                    switch view {
                    case .grid:
                        LazyVGrid(columns: columns) {
                            MissionCardView(missions: missions, astronauts: astronauts)
                        }
                    case .list:
                        LazyVStack(spacing: 20) {
                            MissionCardView(missions: missions, astronauts: astronauts)
                        }
                    }
                }
                .padding([.horizontal, .bottom])
                .toolbar {
                    Menu {
                        Button {
                            view = .grid
                        } label: {
                            Image(systemName: "square.grid.2x2")
                            Text("Grid")
                        }
                        
                        Button {
                            view = .list
                        } label: {
                            Image(systemName: "list.bullet")
                            Text("List")
                        }
                    } label: {
                        Image(systemName: view.icon)
                    }
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
}
