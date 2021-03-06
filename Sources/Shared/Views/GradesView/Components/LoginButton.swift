//
//  LoginButton.swift
//  SMHSSchedule (iOS)
//
//  Created by Jevon Mao on 7/26/21.
//

import SwiftUI

struct LoginButton: View {
    @StateObject var gradesViewModel: GradesViewModel
    
    var body: some View {
        Button(action: {
            withAnimation {
                gradesViewModel.userInitiatedLogin = true
                gradesViewModel.loginAndFetch()
            }
        }){
            ZStack {
                Text("Log In")
                    .fontWeight(.semibold)
                    .padding()
            }
            .frame(width: min(CGFloat(400), UIScreen.screenWidth - 100))
            .background(Color.appPrimary)
            .foregroundColor(.platformBackground)
            .roundedCorners(cornerRadius: 10)
     
        }
        .disabled(gradesViewModel.isLoading)
        .padding(.bottom)
    }
}

