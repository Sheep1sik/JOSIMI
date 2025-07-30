//
//  AuthViewModel.swift
//  Josimi
//
//  Created by 양원식 on 8/17/24.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var username = ""
    @Published var phoneNumber = ""
    @Published var gender = ""
    @Published var age = ""
    @Published var disease = ""
}
