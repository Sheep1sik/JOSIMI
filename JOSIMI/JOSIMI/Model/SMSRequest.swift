//
//  SMSRequest.swift
//  Josimi
//
//  Created by 양원식 on 8/12/24.
//

import Foundation

// SMS 요청을 위한 데이터 모델
struct SMSRequest: Codable {
    let key: String
    let user_id: String
    let sender: String
    let receiver: String
    let msg: String
    let title: String
    let testmode_yn: String? // 연동 테스트 모드를 위한 파라미터, 옵셔널로 추가
    
    // 초기화 함수
    init(key: String, user_id: String, sender: String, receiver: String, msg: String, title: String, testmode_yn: String? = nil) {
        self.key = key
        self.user_id = user_id
        self.sender = sender
        self.receiver = receiver
        self.msg = msg
        self.title = title
        self.testmode_yn = testmode_yn
    }
}

