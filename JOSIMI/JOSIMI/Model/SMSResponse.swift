//
//  SMSResponse.swift
//  Josimi
//
//  Created by 양원식 on 8/12/24.
//

import Foundation

// SMS API 응답 데이터를 처리하기 위한 구조체
struct SMSResponse: Codable {
    let result_code: String      // 서버에서 문자열로 반환될 가능성이 높으므로 String
    let message: String
    let msg_id: String?          // 문자열로 반환
    let success_cnt: Int?        // 서버에서 이 값은 Int로 반환될 수 있으므로 Int
    let error_cnt: Int?          // 서버에서 이 값은 Int로 반환될 수 있으므로 Int
    let msg_type: String?
}
