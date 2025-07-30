//
//  AddGenderSheetView.swift
//  Josimi
//
//  Created by 양원식 on 8/17/24.
//

import SwiftUI

struct AddAgeView: View {
    
    @State var age10_20: Bool = false
    @State var age30_40: Bool = false
    @State var age50_60: Bool = false
    @State var age70: Bool = false
    @Binding var progress: Double
    @EnvironmentObject var viewModel: RegistrationViewModel
    @Binding var path: NavigationPath
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
                    Text("회원님의")
                    
                    Text("연령대")
                        .fontWeight(.bold)
                    +
                    Text("를 선택해주세요.")
                }
                .font(.system(size: 32))
                Spacer()
            }
            
            // 연령대 선택 버튼
            ageButton(title: "10 - 20대", ageRange: "10-20", isSelected: $age10_20)
            ageButton(title: "30 - 40대", ageRange: "30-40", isSelected: $age30_40)
            ageButton(title: "50 - 60대", ageRange: "50-60", isSelected: $age50_60)
            ageButton(title: "70대 이상", ageRange: "70+", isSelected: $age70)
            
            Spacer()
            
            // 다음 버튼 클릭 시 path에 AddDiseaseView 추가
            Button(action: {
                if viewModel.age != "" {
                    progress += 0.25
                    path.append("AddDiseaseView")  // AddDiseaseView로 이동
                }
            }) {
                RoundedRectangle(cornerRadius: 76)
                    .frame(height: 95)
                    .foregroundColor(viewModel.age != "" ? Color.accentColor : Color(.systemGray4))
                    .overlay {
                        Text("다음")
                            .foregroundColor(viewModel.age != "" ? .black : Color(.systemGray))
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
                Text("연령대 선택")
                    .font(.title)
            }
        }
    }

    // 연령대 선택 버튼을 생성하는 헬퍼 함수
    private func ageButton(title: String, ageRange: String, isSelected: Binding<Bool>) -> some View {
        Button(action: {
            viewModel.age = ageRange
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
                .frame(height: 80)
                .overlay(
                    Text(title)
                        .foregroundColor(.black)
                        .font(.system(size: 32))
                )
        }
    }
    
    // 다른 버튼을 선택했을 때 이전 선택을 초기화하는 함수
    private func resetSelection() {
        age10_20 = false
        age30_40 = false
        age50_60 = false
        age70 = false
    }
}


#Preview {
    AddAgeView(progress: .constant(0.75), path: .constant(NavigationPath()))
        .environmentObject(RegistrationViewModel())
}
