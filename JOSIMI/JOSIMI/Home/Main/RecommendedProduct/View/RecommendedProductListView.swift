//
//  RecommendedProductListView.swift
//  Josimi
//
//  Created by 양원식 on 9/22/24.
//

import SwiftUI

struct RecommendedProductListView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = RecommendedProductViewModel()
    @State var checkBoxToggle = false
    @State private var selectedOption: String = "인기순"
    @State private var inputText: String = ""
    @State private var isButtonEnabled: Bool = false
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.black)
                    })
                    Button(action: {}, label: {
                        Image("home2")
                    })
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        Image("shopping_cart")
                    })
                }
                .padding(.horizontal, 20)
                
                // ZStack의 중앙에 텍스트를 배치
                Text("조시미 추천 제품")
                    .font(.headline)
            }
            .frame(maxWidth: .infinity, maxHeight: 44) // 높이와 너비를 설정하여 HStack과 Text의 레이아웃을 일치시킴
            Divider()
            HStack {
            Button(action: {
                checkBoxToggle.toggle()
                
            }, label: {
                Image(systemName: checkBoxToggle ? "checkmark.square" : "square")
                    .foregroundColor(.gray)
            })
                Text("안맞는 성분 제외")
                    .foregroundColor(.black)
                    .font(.footnote)
                
                Spacer()
                
                Menu {
                    Button("인기순") {
                        selectedOption = "인기순"
                    }
                    Button("최신순") {
                        selectedOption = "최신순"
                    }
                    Button("높은 가격순") {
                        selectedOption = "높은 가격순"
                    }
                    Button("낮은 가격순") {
                        selectedOption = "낮은 가격순"
                    }
                } label: {
                    HStack {
                        Text(selectedOption)
                            .foregroundColor(.black)
                        Image(systemName: "chevron.down")
                            .foregroundColor(.black)
                    }
                }
                .font(.footnote)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
        }
        
        Divider()
        
        HStack{
            Text("총 \(viewModel.productAfters.count)개")
                .font(.system(size: 14))
            Spacer()
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 4), spacing: 20) {
                ForEach(viewModel.productAfters) { product in
                    RecommendedProductNormalItemView(productAfter: product)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
        Divider()
        
        VStack {
            HStack {
                Text("상품 입점 요청하기")
                    .font(.title2)
                Spacer()
            }
            // TextEditor 입력 필드
            TextEditor(text: $inputText)
                .frame(height: 100)
                .padding(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.5))
                )
                .cornerRadius(8)
                .overlay(
                    // Placeholder 구현
                    Group {
                        if inputText.isEmpty {
                            Text("원하는 상품이 있으시면 입점을 요청해주세요.")
                                .foregroundColor(.gray)
                                .padding(.horizontal, 15)
                                .padding(.vertical, 17)
                        }
                    }, alignment: .topLeading
                )
                .onChange(of: inputText) { newValue in
                    // 텍스트 변경 시 버튼 활성화 상태 업데이트
                    isButtonEnabled = !newValue.isEmpty
                }
            
            // 버튼
            Button(action: {
                // 버튼 클릭 시의 동작
                print("입점 요청 버튼 클릭됨")
                inputText = ""
                showAlert = true
            }) {
                Text("제품 입점 요청하기")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(inputText.isEmpty ? Color.gray : Color.accentColor)
                    .cornerRadius(8)
            }
            .disabled(inputText.isEmpty) // 입력 필드가 비어 있으면 버튼 비활성화
            .padding(.top, 10)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("성분요청 완료"), message: Text("성분분석 요청이 완료되었습니다. \n 분석이 완료되면 알림을 보내드릴게요."), dismissButton: .default(Text("확인").foregroundColor(.black)))
            }
        }
        .padding(.vertical, 30)
        .padding(.horizontal, 20)
        
    }
}

#Preview {
    RecommendedProductListView()
}
