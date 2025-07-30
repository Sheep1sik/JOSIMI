//
//  AddDiseaseView.swift
//  Josimi
//
//  Created by 양원식 on 11/9/24.
//

import SwiftUI

struct AddDiseaseView: View {
    @State var diabetes: Bool = false
    @State var heartAttack: Bool = false
    @State var heartDisease: Bool = false
    @State var bloodSugarDiet: Bool = false
    @Binding var progress: Double
    @EnvironmentObject var viewModel: RegistrationViewModel
    @Binding var path: NavigationPath  // 경로 타입을 NavigationPath로 변경
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                ProgressView(value: progress)
                    .frame(height: 11)
            }
            
            // 인사말
            HStack {
                VStack(alignment: .leading) {
                    Text("회원님의 원하는")
                    
                    Text("목표")
                        .fontWeight(.bold)
                    +
                    Text("를 선택해주세요.")
                }
                .font(.system(size: 32))
                Spacer()
            }
            
            // 질병 선택 버튼들
            diseaseButton(title: "당뇨", diseaseType: "당뇨", description: "설명", isSelected: $diabetes)
            diseaseButton(title: "심근경색", diseaseType: "", description: "추후 업데이트 예정", isSelected: .constant(false))
            diseaseButton(title: "심혈관질환", diseaseType: "", description: "추후 업데이트 예정",isSelected: .constant(false))
            diseaseButton(title: "혈당다이어트", diseaseType: "", description: "추후 업데이트 예정",isSelected: .constant(false))
            
            Spacer()
            
            // 다음 버튼 클릭 시 path에 CompletsSignUpView 추가
            Button(action: {
                if viewModel.disease != "" {
                    path.append("CompletsSignUpView")  // CompletsSignUpView로 이동
                }
            }) {
                RoundedRectangle(cornerRadius: 76)
                    .frame(height: 95)
                    .foregroundColor(viewModel.disease != "" ? Color.accentColor : Color(.systemGray4))
                    .overlay {
                        Text("다음")
                            .foregroundColor(viewModel.disease != "" ? .black : Color(.systemGray))
                            .font(.system(size: 32))
                    }
            }
            .padding(.bottom, 40)
        }
        .padding(.horizontal, 30)
        .padding(.top, 20)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .onTapGesture {
                        progress -= 0.25
                        dismiss()
                    }
            }
            ToolbarItem(placement: .principal) {
                Text("목표 설정")
                    .font(.title)
            }
        }
    }

    // 질병 버튼을 동적으로 생성하는 헬퍼 함수
    private func diseaseButton(title: String, diseaseType: String, description: String, isSelected: Binding<Bool>) -> some View {
        Button(action: {
            viewModel.disease = diseaseType
            resetSelection()
            isSelected.wrappedValue = true
        }) {
            RoundedRectangle(cornerRadius: 10)
                .fill(isSelected.wrappedValue ? Color.accentColor : Color.clear)  // 선택되면 색상 채우기
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: isSelected.wrappedValue ? 0 : 1)  // 선택되면 테두리 제거
                        .foregroundColor(isSelected.wrappedValue ? Color.accentColor : Color(.systemGray3))
                )
                .frame(height: 100)
                .overlay(
                    HStack {
                        VStack(alignment: .leading) {
                            Text(title)
                                .foregroundColor(.black)
                                .font(.system(size: 32))
                            Text(description)
                                .font(.system(size: 32))
                                .foregroundColor(Color(.systemGray3))
                        }
                        .padding(30)
                        Spacer()
                    }
                )
        }
    }
    
    // 다른 버튼을 선택했을 때 이전 선택을 초기화하는 함수
    private func resetSelection() {
        diabetes = false
        heartAttack = false
        heartDisease = false
        bloodSugarDiet = false
    }
}



#Preview {
    AddDiseaseView(progress: .constant(1), path: .constant(NavigationPath()))
        .environmentObject(RegistrationViewModel())
}
