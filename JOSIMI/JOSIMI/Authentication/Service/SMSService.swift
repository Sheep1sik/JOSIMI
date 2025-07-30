//
//  SMSViewModel.swift
//  Josimi
//
//  Created by 양원식 on 8/12/24.
//

import Foundation
import Combine

// SMS API 호출 및 타이머 관리를 위한 ViewModel
class SMSService: ObservableObject {
    @Published var phoneNumber: String = ""
    @Published var authCode: String = ""
    @Published var isTimerRunning = false
    @Published var timeRemaining: Int = 180 // 3분 (180초)
    @Published var isCodeValid: Bool = false
    
    private var generatedAuthCode: String? // 생성된 인증번호를 저장
    private var timer: AnyCancellable?
    
    // 6자리 랜덤 인증코드 생성 함수
    private func generateAuthCode() -> String {
        return String(format: "%06d", Int.random(in: 0...999999))
    }
    
    func sendSMS() {
        // 6자리 랜덤 인증번호 생성 및 저장
        generatedAuthCode = generateAuthCode()
        guard let generatedAuthCode = generatedAuthCode else { return }
        
        let url = URL(string: "https://apis.aligo.in/send/")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // SMS 요청 데이터 생성
        let smsRequest = SMSRequest(
            key: "3akt3afdfx36fp0jhf3neuz9z7thalbk",
            user_id: "bohg6799",
            sender: "010-3975-4323", // 발신자 번호
            receiver: phoneNumber.replacingOccurrences(of: "-", with: ""), // 수신자 번호
            msg: "[조시미 인증문자] 인증번호 \(generatedAuthCode)를 입력해주세요.",
            title: "[Web발신]", // SMS 제목
            testmode_yn: "Y" // 테스트 모드 설정 : Y or nil
        )
        
        // 요청 데이터를 URL 인코딩 형식으로 변환
        let postData = smsRequest.asQueryString().data(using: .utf8)
        request.httpBody = postData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Network error: \(String(describing: error))")
                return
            }

            // 서버 응답을 문자열로 출력해보기
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response data: \(responseString)")
            }

            // API 응답 처리
            if let response = try? JSONDecoder().decode(SMSResponse.self, from: data) {
                print("SMS Response: \(response)")
                print(generatedAuthCode)
                DispatchQueue.main.async {
                    self.startTimer()
                }
            } else {
                print("Failed to decode response")
            }
        }.resume()
    }

    
    // 타이머 시작 함수
    func startTimer() {
        isTimerRunning = true
        timeRemaining = 180
        
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.stopTimer()
                }
            }
    }
    
    // 타이머 정지 함수
    func stopTimer() {
        isTimerRunning = false
        timer?.cancel()
        timer = nil
    }
    
    // 입력된 인증코드가 올바른지 확인하는 함수
    func validateCode() {
        if let generatedAuthCode = generatedAuthCode, authCode == generatedAuthCode, timeRemaining > 0 {
            isCodeValid = true
            stopTimer()
        } else {
            isCodeValid = false
        }
    }
}

// URL 인코딩을 위한 확장
extension SMSRequest {
    func asQueryString() -> String {
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "key", value: key),
            URLQueryItem(name: "user_id", value: user_id),
            URLQueryItem(name: "sender", value: sender),
            URLQueryItem(name: "receiver", value: receiver),
            URLQueryItem(name: "msg", value: msg),
            URLQueryItem(name: "title", value: title)
        ]
        
        // testmode_yn이 nil이 아닌 경우에만 쿼리 아이템에 추가
        if let testmode = testmode_yn {
            components.queryItems?.append(URLQueryItem(name: "testmode_yn", value: testmode))
        }
        
        return components.url?.query ?? ""
    }
}
