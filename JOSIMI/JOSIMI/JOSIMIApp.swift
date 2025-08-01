//
//  JosimiApp.swift
//  Josimi
//
//  Created by 양원식 on 8/10/24.
//

import SwiftUI

@main
struct JosimiApp: App {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @StateObject private var viewModel = RegistrationViewModel()
    @State private var path = NavigationPath()
    @State var progress: Double = 0.25
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path){
                if isLoggedIn {
                    // 로그인 후 TabbarView로 이동
                    TabbarView()
                } else {
                    // 로그인 화면으로 이동
                    LoginView(progress: $progress, path: $path)
                }
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

