//
//  InformationCardsView.swift
//  SMHSSchedule (iOS)
//
//  Created by Jevon Mao on 5/14/21.
//

import SwiftUI

struct InformationCardsView: View {
    @State var showWebView = false
    @State private var informationCard: InformationCard?
    let columns = Array.init(repeating: GridItem(.adaptive(minimum: 180)), count: 1)
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack {
                    LazyVGrid(columns: columns, spacing: 30, content: {
                        ForEach(InformationCard.informationCards){card in
                            Button(action: {informationCard = card; showWebView = true}, label: {
                                InformationCardItem(card: card)
                            })
                        }
                    })
                    .padding(.horizontal)
                    .padding(.vertical, 30)
                }
    
                
            }
        }
        .navigationBarTitle("Search")
        .introspectNavigationController{
            $0.navigationBar.titleTextAttributes = [.foregroundColor : UIColor(Color.primary)]
            $0.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor(Color.primary)]
        }
        .fullScreenCover(item: $informationCard){
            SafariView(url: $0.link).edgesIgnoringSafeArea(.all)
        }
    }
    
}

struct InformationCardsView_Previews: PreviewProvider {
    static var previews: some View {
        InformationCardsView()
    }
}