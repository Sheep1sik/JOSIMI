//
//  AddGenderView.swift
//  Josimi
//
//  Created by 양원식 on 8/14/24.
//

import SwiftUI

struct AddGenderView: View {
    @State private var man = false
    @State private var woman = false
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
                    
                    Text("성별")
                        .fontWeight(.bold)
                    +
                    Text("을 선택해주세요.")
                }
                .font(.system(size: 32))
                Spacer()
            }
            
            // 성별 선택 버튼
            Button(action: {
                viewModel.gender = "남성"
                man = true
                woman = false
            }, label: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(man ? Color.accentColor : Color.clear)  // 선택되면 색상 채우기
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: man ? 0 : 1)  // 선택되면 테두리 제거
                            .foregroundColor(man ? Color.accentColor : Color(.systemGray3))
                    )
                    .frame(height: 80)
                    .overlay(
                        Text("남성")
                            .foregroundColor(.black)
                            .font(.system(size: 32))
                    )
            })
            
            Button(action: {
                viewModel.gender = "여성"
                man = false
                woman = true
            }, label: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(woman ? Color.accentColor : Color.clear)  // 선택되면 색상 채우기
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: woman ? 0 : 1)  // 선택되면 테두리 제거
                            .foregroundColor(woman ? Color.accentColor : Color(.systemGray3))
                    )
                    .frame(height: 80)
                    .overlay(
                        Text("여성")
                            .foregroundColor(.black)
                            .font(.system(size: 32))
                    )
            })
                
            Spacer()
            
            // 다음 버튼
            Button(action: {
                if man || woman {
                    progress += 0.25
                    path.append("AddAgeView")  // AddAgeView로 이동
                }
            }) {
                RoundedRectangle(cornerRadius: 76)
                    .frame(height: 95)
                    .foregroundColor(man || woman ? Color.accentColor : Color(.systemGray4))
                    .overlay {
                        Text("다음")
                            .foregroundColor(man || woman ? .black : Color(.systemGray))
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
                Text("성별 선택")
                    .font(.title)
            }
        }
    }
}

#Preview {
    AddGenderView(progress: .constant(0.5), path: .constant(NavigationPath()))
        .environmentObject(RegistrationViewModel())
}
