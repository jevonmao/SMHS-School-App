//
//  LoginButton.swift
//  SMHSSchedule (iOS)
//
//  Created by Jevon Mao on 7/26/21.
//

import SwiftUI

struct LoginButton: View {
    @ObservedObject var gradesViewModel: GradesViewModel
    
    var body: some View {
        Button(action: {
            withAnimation {
                gradesViewModel.loginAndFetch()
            }
        }){
            ZStack {
                Text("Log In")
                    .fontWeight(.semibold)
                    .padding(10)
            }
            .frame(width: min(CGFloat(400), UIScreen.screenWidth - 100))
            .background(.primary)
            .foregroundColor(.platformBackground)
            .roundedCorners(cornerRadius: 10)
     
        }
        .disabled(gradesViewModel.isLoading)
        .padding(.bottom)
    }
}
