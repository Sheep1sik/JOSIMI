//
//  UserNameViewModel.swift
//  JOSIMI
//
//  Created by 양원식 on 11/17/24.
//

import Foundation
import Combine
import SwiftUI

class UserNameViewModel: ObservableObject {
    @Published var username: String = "" // 유저가 입력하는 닉네임
    @Published var errorMessage: String? = nil // 오류 메시지
    @Published var validationStatus: ValidationStatus = .neutral // 유효성 상태
    
    private var cancellables = Set<AnyCancellable>() // Combine의 구독 관리
    
    // Validation 상태
    enum ValidationStatus {
        case valid
        case invalid
        case neutral
    }
    
    init() {
        // 디바운싱 설정
        $username
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main) // 0.5초 대기
            .sink { [weak self] newUsername in
                self?.validateUsername(newUsername) // 유효성 검사 실행
            }
            .store(in: &cancellables)
    }
    
    // 유효성 검사 로직
    private func validateUsername(_ username: String) {
        // 조건 1: 빈 문자열이 아님
        guard !username.isEmpty else {
            validationStatus = .invalid
            errorMessage = "닉네임을 입력해주세요."
            return
        }
        // 조건 2: 숫자로 시작하면 안 됨
        if username.first?.isNumber == true {
            validationStatus = .invalid
            errorMessage = "닉네임은 숫자로 시작할 수 없습니다."
            return
        }
        // 조건 3: 닉네임에 단독 자음/모음 포함 금지
        let invalidPattern = "(?<![가-힣a-zA-Z0-9])[ㄱ-ㅎㅏ-ㅣ](?![가-힣a-zA-Z0-9])"
        if let _ = username.range(of: invalidPattern, options: .regularExpression) {
            validationStatus = .invalid
            errorMessage = "닉네임에 자음 또는 모음 단독으로 포함할 수 없습니다."
            return
        }
        // 조건 4: 공백 포함 금지
        if username.contains(" ") {
            validationStatus = .invalid
            errorMessage = "닉네임에 공백을 포함할 수 없습니다."
            return
        }
        // 조건 5: 특수 문자 포함 금지
        let specialCharacterPattern = "[^가-힣a-zA-Z0-9]"
        if let _ = username.range(of: specialCharacterPattern, options: .regularExpression) {
            validationStatus = .invalid
            errorMessage = "닉네임에 특수 문자를 포함할 수 없습니다."
            return
        }
        // 조건 6: 금지 단어 검사
        let bannedWords = ["admin", "test"]
        if bannedWords.contains(where: { username.localizedCaseInsensitiveContains($0) }) {
            validationStatus = .invalid
            errorMessage = "닉네임에 금지된 단어가 포함되어 있습니다."
            return
        }
        // 조건 7: 최대 10글자 제한
        if username.count > 10 {
            validationStatus = .invalid
            errorMessage = "닉네임은 최대 10글자까지 가능합니다."
            return
        }
        
        // 모든 조건 통과
        validationStatus = .valid
        errorMessage = nil
    }
    
    // MARK: - Stroke Color
    var strokeColor: Color {
        switch validationStatus {
        case .valid:
            return .green
        case .invalid:
            return .orange
        case .neutral:
            return Color(.systemGray3)
        }
    }
}

