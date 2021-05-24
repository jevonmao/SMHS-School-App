//
//  InformationCardItem.swift
//  SMHSSchedule (iOS)
//
//  Created by Jevon Mao on 5/24/21.
//

import SwiftUI

struct InformationCardItem: View {
    @Environment(\.colorScheme) var colorScheme
    var card: InformationCard
    
    var body: some View {
        ZStack {
            card.image
                .resizable()
                .scaledToFill()
                .saturation(0)
                .frame(width: 180, height: 130)
            Color.clear.blurEffect().opacity(0.9)
            LinearGradient(gradient: Gradient(colors: [card.backgroundColor.opacity(0.3), card.backgroundColor]), startPoint: .leading, endPoint: .trailing)
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            Text(card.title)
                .fontWeight(.bold)
                .minimumScaleFactor(0.7)
                .lineLimit(card.lineLimit)
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .adaptableTitleColor(colorScheme)
        }
        .blurEffectStyle(.systemUltraThinMaterial)
        .roundedCorners(cornerRadius: 10)
        .vibrancyEffectStyle(.secondaryLabel)
        .shadow(color: card.backgroundColor.opacity(0.3), radius: 8, x: 4, y: 4)
    }
}

struct InformationCardItem_Previews: PreviewProvider {
    static var previews: some View {
        InformationCardItem(card: InformationCard.informationCards.first!)
    }
}

fileprivate extension View {
    func adaptableTitleColor(_ colorScheme: ColorScheme) -> AnyView {
        if colorScheme == .light {
            return self.foregroundColor(.platformBackground).typeErased()
        }
        else {return self.vibrancyEffect().typeErased()}
    }
}