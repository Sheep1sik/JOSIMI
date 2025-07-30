//
//  ProductScannerView.swift
//  Josimi
//
//  Created by 양원식 on 9/20/24.
//

import SwiftUI

struct ProductScannerView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = BarcodeScannerViewModel()
    @State private var isPressed = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    
    var body: some View {
        VStack {
            Text("조시미 스캐너")
                .font(.system(size: 30))
                .fontWeight(.bold)
            ScrollView {
                VStack {
                    BarcodeScannerView { code in
                        viewModel.updateScannedCode(with: code)
                        
                        // 스캔된 코드를 13자리로 나눠서 digits 배열에 저장
                        if viewModel.scannedCode.count == 13 {
                            for (index, character) in viewModel.scannedCode.enumerated() {
                                viewModel.digits[index] = String(character)
                            }
                        }
                    }
                    .frame(height: 600)
                    
                    Spacer()
                    
                    Image("barcord")
                        .resizable()
                        .frame(width: 570, height: 200)
                    
                    HStack {
                        ForEach(0..<13) { index in
                            if index == 0 || index == 6 {
                                TextField(viewModel.digits[index], text: $viewModel.digits[index])
                                    .keyboardType(.numberPad)
                                    .frame(width: 30, height: 40)
                                    .multilineTextAlignment(.center)
                                    .onChange(of: viewModel.digits[index]) { newValue in
                                        if newValue.count > 1 {
                                            viewModel.digits[index] = String(newValue.prefix(1))
                                        }
                                        // 각 자리값이 변경될 때, 전체 바코드를 업데이트
                                        viewModel.updateDigitsCode()
                                    }
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.trailing)
                            } else {
                                TextField(viewModel.digits[index], text: $viewModel.digits[index])
                                    .keyboardType(.numberPad)
                                    .frame(width: 30, height: 40)
                                    .multilineTextAlignment(.center)
                                    .onChange(of: viewModel.digits[index]) { newValue in
                                        if newValue.count > 1 {
                                            viewModel.digits[index] = String(newValue.prefix(1))
                                        }
                                        // 각 자리값이 변경될 때, 전체 바코드를 업데이트
                                        viewModel.updateDigitsCode()
                                    }
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                        }
                    }
                    .padding(.top, -50)
                    
                    Spacer()
                    
                }
                .navigationDestination(isPresented: $isPressed) {
                    if let product = viewModel.product {
                        ProductDetailsPageView(product: product)
                            .navigationBarBackButtonHidden(true)
                    } else {
                        Text("Product details not available.")
                    }
                }
                
                .navigationBarItems(leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.black)
                    }
                })
                
                
            }
            Button(action: {
                viewModel.fetchProductDetails { product in
                    if product != nil {
                        // 성공적으로 가져왔을 때
                        isPressed = true
                    } else {
                        // 실패했을 때
                        alertMessage = "성분 분석이 완료되지 않은 제품입니다. \n 분석 요청을 부탁드립니다."
                        showAlert = true
                    }
                }
            }, label: {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 766, height: 40)
                    .overlay {
                        Text("검색하기")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
            })
            .padding()
            // Alert modifier 추가
            .alert(isPresented: $showAlert) {
                Alert(title: Text("알림"), message: Text(alertMessage), dismissButton: .default(Text("확인").foregroundColor(.black)))
            }
        }
    }
}
struct ProductScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ProductScannerView()
            .navigationBarBackButtonHidden(true)
    }
}
