//
//  ContentView.swift
//  SMHS Schedule
//
//  Created by Jevon Mao on 3/15/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ScheduleView()
                .tabItem{
                    VStack{
                        Image(systemName: "calendar")
                        Text("Schedule")
                    }
                }

            TodayView()
                .tabItem{
                    VStack{
                        Image(systemName: "square.grid.2x2.fill")
                        Text("Today")
                    }
                }
        }
        .accentColor(Color.primary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
