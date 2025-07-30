//
//  LoginView.swift
//  Josimi
//
//  Created by 양원식 on 11/9/24.
//

import SwiftUI

struct LoginView: View {
    @Binding var progress: Double
    @StateObject private var viewModel = RegistrationViewModel()
    @Binding var path: NavigationPath
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Spacer()
                
                Image("logo")
                
                Spacer()
                
                NavigationLink(value: "AddNameView") {
                    Image("btn_cta_ios")
                }
                
                NavigationLink(value: "AddNameView") {
                    Image("btn_cta_ios2")
                }
                Spacer()
            }
            .navigationDestination(for: String.self) { value in
                if value == "AddNameView" {
                    AddNameView(progress: $progress, path: $path)
                        .environmentObject(viewModel)
                        .navigationBarBackButtonHidden(true)
                }
                if value == "AddGenderView" {
                    AddGenderView(progress: $progress, path: $path)
                        .environmentObject(viewModel)
                        .navigationBarBackButtonHidden(true)
                }
                if value == "AddAgeView" {
                    AddAgeView(progress: $progress, path: $path)
                        .environmentObject(viewModel)
                        .navigationBarBackButtonHidden(true)
                }
                if value == "AddDiseaseView" {
                    AddDiseaseView(progress: $progress, path: $path)
                        .environmentObject(viewModel)
                        .navigationBarBackButtonHidden(true)
                }
                if value == "CompletsSignUpView" {
                    CompletsSignUpView(path: $path, progress: $progress)
                        .environmentObject(viewModel)
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}




#Preview {
    LoginView(progress: .constant(0.25), path: .constant(NavigationPath()))
}
