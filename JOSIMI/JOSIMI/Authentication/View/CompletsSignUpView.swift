//
//  CompletsSignUpView.swift
//  Josimi
//
//  Created by 양원식 on 8/17/24.
//

import SwiftUI

struct CompletsSignUpView: View {
    @EnvironmentObject var viewModel: RegistrationViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var navigateToTabbarView: Bool = false
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @Binding var path: NavigationPath
    @Binding var progress: Double

    var body: some View {
        VStack {
            Spacer()
            
            // 이미지
            Image("Image")
                .resizable()
                .scaledToFit()
                .frame(width: 207, height: 207)
                .foregroundColor(.accentColor)
            
            // 텍스트: 회원가입 완료 메시지
            VStack {
                Text("\(viewModel.username)")
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
                +
                Text(" 님,")
                Text("가입이 완료되었어요!")
            }
            .font(.system(size: 32))
            .padding(.top, 20)
            
            Spacer()
            
            // 확인 버튼
            Button(action: {
                // 회원가입 완료 후 로그인 상태 업데이트
                isLoggedIn = true
                
                // path 초기화하여 화면 전환
                path = .init()
                // 경로 리셋: 경로 배열을 비워서 다른 화면으로 이동
                progress = 0.25
                // 회원가입 정보 출력
                print("회원가입 완료")
                print("회원가입정보 [ 이름 : \(viewModel.username), 전화번호 : \(viewModel.phoneNumber), 성별 : \(viewModel.gender), 나이 : \(viewModel.age), 관심질병 : \(viewModel.disease == "" ? "미선택" : viewModel.disease) ]")
                
                // 추후 화면 전환 로직 추가
            }) {
                RoundedRectangle(cornerRadius: 76)
                    .frame(height: 95)
                    .foregroundColor(Color.accentColor) // 활성화된 버튼 색상
                    .overlay {
                        Text("확인")
                            .foregroundColor(.black)
                            .font(.system(size: 32))
                    }
            }
            .padding(.bottom, 40)
            .padding(.horizontal, 30)
        }
        .navigationBarBackButtonHidden(true) // 뒤로 가기 버튼 숨기기
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss()
                    }
            }
        }
    }
}




#Preview {
    CompletsSignUpView(path: .constant(NavigationPath()), progress: .constant(1.0))
        .environmentObject(RegistrationViewModel())
}
