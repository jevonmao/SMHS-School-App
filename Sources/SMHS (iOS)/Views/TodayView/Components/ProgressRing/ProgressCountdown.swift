//
//  ProgressCountdown.swift
//  SMHSSchedule (iOS)
//
//  Created by Jevon Mao on 5/11/21.
//

import SwiftUI

struct ProgressCountDown: View {
    var scheduleDay: ScheduleDay?
    @EnvironmentObject var userSettings: UserSettings
    @Binding var selectionMode: PeriodCategory
    @Binding var countDown: TimeInterval?
    var mockDate: Date?
    var text: String {
        if let periodNumber = scheduleDay?.getCurrentPeriod(selectionMode: selectionMode)?.periodNumber {
            guard let matchingPeriod = userSettings.editableSettings.filter({$0.periodNumber == periodNumber}).first,
                  matchingPeriod.textContent != "" else {
                return "PERIOD \(periodNumber)"
            }
            return matchingPeriod.textContent
            
        }
        else if let nutritionSchedule = scheduleDay?.getCurrentPeriod(selectionMode: selectionMode)?.periodCategory,
                nutritionSchedule.isLunch {
            return "NUTRITION"
        }
        else if scheduleDay?.getCurrentPeriod(selectionMode: selectionMode)?.periodCategory == .officeHour {
            return "Office Hours"
        }
        else if scheduleDay == nil {
            return "NO SCHOOL 🙌"
        }
        else { 
            return "SCHEDULE UNAVAILABLE"
        }
    }
    var body: some View {
        VStack {
            
            Text(text)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.bottom, 20)
                .minimumScaleFactor(0.5)
                .lineLimit(2)
                .frame(maxWidth: 200, maxHeight: 50)
           if let countDown = countDown, let (hours, minutes, seconds) = countDown.secondsToHoursMinutesSeconds() {
            HStack {
                Text("\(hours)")
                    .fontWeight(.medium)
                Text(":")
                    .fontWeight(.medium)
                    .padding(.horizontal, -4)
                Text("\(minutes)")
                    .fontWeight(.medium)
                Text(":")
                    .fontWeight(.medium)
                    .padding(.horizontal, -4)
                Text("\(seconds)")
                    .fontWeight(.medium)
            }
            .fixedSize()
            .font(.title)
            .availableMonospacedDigit()

            Text("REMAINING")
                .font(.body)
                .foregroundColor(.platformSecondaryLabel)
                .multilineTextAlignment(.center)
            }
        }
        .onAppear{
            self.countDown = scheduleDay?.getCurrentPeriodRemainingTime(selectionMode: selectionMode)
        }
    }
}

struct ProgressCountdown_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCountDown(scheduleDay: ScheduleDay.sampleScheduleDay, selectionMode: .constant(.firstLunch), countDown: .constant(TimeInterval(10)))
        ProgressCountDown(scheduleDay: ScheduleDay.sampleScheduleDay, selectionMode: .constant(.firstLunch), countDown: .constant(TimeInterval(10)))
    }
}

fileprivate extension View {
    func availableMonospacedDigit() -> some View {
        if #available(iOS 15, *) {
            return self
                .monospacedDigit()
                .typeErased()
        }
        else {
            return self.font(Font.system(.title, design: .default))
                .typeErased()
        }
    }
}
