//
//  AddNameView.swift
//  Josimi
//
//  Created by 양원식 on 8/10/24.
//


import SwiftUI

struct AddNameView: View {
    @EnvironmentObject var viewModel: RegistrationViewModel
    @State private var shouldNavigate: Bool = false
    @State private var isValidUsername = true
    @Binding var progress: Double
    @Binding var path: NavigationPath
    @Environment(\.dismiss) var dismiss
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        VStack(spacing: 30) {
            
            HStack {
                ProgressView(value: progress)
                    .frame(height: 11)
            }
            
            // 인사말
            HStack {
                VStack(alignment: .leading) {
                    Text("반갑습니다!")
                    Text("닉네임")
                        .fontWeight(.bold)
                    +
                    Text("을 입력해주세요.")
                }
                .font(.system(size: 32))
                Spacer()
            }
            
            // 이름 입력칸
            HStack {
                VStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(viewModel.username == "" ? Color(.systemGray3) : viewModel.username != "" && isValidUsername ? Color.accentColor : Color.red, lineWidth: 2)
                        .foregroundColor(Color(.systemGray3))
                        .frame(height: 80)
                        .overlay (
                            HStack {
                                TextField("닉네임", text: $viewModel.username)
                                    .submitLabel(.send)
                                    .font(.system(size: 32))
                                    .focused($isTextFieldFocused) // 포커스 설정
                                    .onAppear {
                                        isTextFieldFocused = true // 화면이 나타날 때 포커스 설정
                                    }
                                    .onChange(of: viewModel.username) { _ in
                                        validateUsername()
                                    }
                                    .onSubmit {
                                        shouldNavigate = isValidUsername // 유효한 경우에만 이동 설정
                                    }
                                Spacer()
                                Text("\(viewModel.username.count) / 10")
                                    .font(.system(size: 24))
                                    .foregroundColor(Color(.systemGray3))
                            }
                            .padding(30)
                        )
                    
                    // 유효하지 않은 입력일 경우 오류 메시지 표시
                    if !isValidUsername {
                        Text("올바른 닉네임을 입력해 주세요.")
                            .font(.system(size: 14))
                            .foregroundColor(.red)
                    }
                }
                .animation(.default, value: viewModel.username != "")
            }
            Spacer()
            
            // Button 클릭 시 path에 AddGenderView 추가
            Button(action: {
                if viewModel.username != "" && isValidUsername {
                    progress += 0.25
                    path.append("AddGenderView")  // AddGenderView로 이동
                }
            }, label: {
                RoundedRectangle(cornerRadius: 76)
                    .frame(height: 95)
                    .foregroundColor(viewModel.username != "" && isValidUsername ? .accentColor : Color(.systemGray4))
                    .overlay {
                        Text("다음")
                            .foregroundColor(viewModel.username != "" && isValidUsername ? .black : Color(.systemGray))
                            .font(.system(size: 32))
                    }
            })
            .padding(.bottom, 40)
        }
        .padding(.horizontal, 30)
        .padding(.top, 20)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss()
                    }
            }
            ToolbarItem(placement: .principal) {
                Text("닉네임 설정")
                    .font(.title)
            }
        }
    }
    
    // 유저네임의 유효성 검사 함수
    private func validateUsername() {
        let specialCharacterPattern = "[^A-Za-z0-9가-힣]"
        let consonantPattern = "[ㄱ-ㅎ]"
        
        let containsSpecialCharacters = viewModel.username.range(of: specialCharacterPattern, options: .regularExpression) != nil
        let containsConsonants = viewModel.username.range(of: consonantPattern, options: .regularExpression) != nil
        
        isValidUsername = !containsSpecialCharacters && !containsConsonants && viewModel.username.count <= 10
    }
}


#Preview {
    AddNameView(progress: .constant(0.25), path: .constant(NavigationPath()))
        .environmentObject(RegistrationViewModel())
}
