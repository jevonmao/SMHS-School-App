//
//  SelectedDateView.swift
//  SMHSSchedule (iOS)
//
//  Created by Jevon Mao on 6/4/21.
//

import SwiftUI

struct SelectedDateView: View {
    var events: [CalendarEvent]
    var body: some View {
        VStack(spacing: 5) {
            ForEach(events, id: \.self){day in
                HStack {
                    Rectangle()
                        .fill(Color.primary)
                        .frame(width: 3, height: 35)
                        .padding(.trailing, 5)
                    
                    VStack(alignment: .leading) {
                        Text(day.title)
                            .font(.headline, weight: .medium)
                            .padding(.bottom, 0.5)
                        if day.isFullDay {
                            HStack {
                                Text(day.startTimeText)
                                Image(systemSymbol: .arrowRightSquare)
                                    .imageScale(.medium)
                                Text(day.endTimeText)
                            }
                            .font(.caption)
                            .foregroundColor(.platformSecondaryLabel)
                        }
                        else {
                            Text("Full Day")
                                .font(.caption)
                                .foregroundColor(.platformSecondaryLabel)
                        }
                    }
                    .foregroundColor(.platformLabel)
                    Spacer()
                }
                
            }
        }
        .padding(.horizontal, 10)
        .padding(.top)
    }
}