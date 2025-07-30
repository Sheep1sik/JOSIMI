//
//  AddPhoneNumberView.swift
//  Josimi
//
//  Created by 양원식 on 8/10/24.
//

import SwiftUI
import JSPhoneFormat

struct AddPhoneNumberView: View {
    
    enum Carriers: String, CaseIterable, Identifiable {
        case skt = "SKT"
        case kt = "KT"
        case lguPlus = "LGU+"
        case sktMVNO = "SKT 알뜰폰"
        case ktMVNO = "KT 알뜰폰"
        case lguPlusMVNO = "LGU+ 알뜰폰"
        
        
        var id: Self { self }
    }
    
    let phoneFormat = JSPhoneFormat(appenCharacter: "-") // 구분 Character
    @Environment(\.dismiss) var dismiss
    @StateObject private var smsService = SMSService() // SMSService 호출
    @State var selectedCarriers: Carriers = .skt
    @State var sendSMS = false
    @State var checkAuthCode = false
    @State private var shouldNavigate: Bool = false
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View {
        if #available(iOS 16.0, *) {
            VStack(spacing: 25) {
                
                // 진행 번호
                HStack {
                    ForEach(1...3, id: \.self) { index in
                        Circle()
                            .frame(width: 24, height: 24)
                            .foregroundColor(index == 2 ? .accentColor : Color(.systemGray4))
                            .overlay {
                                Text("\(index)")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity, maxHeight: 14.0, alignment: .center)
                            }
                    }
                    
                    Spacer()
                }
                
                // 인사말
                HStack {
                    VStack(alignment: .leading) {
                        Text("전화번호")
                            .fontWeight(.bold)
                        +
                        Text("를 입력해주세요")
                    }
                    .font(.title2)
                    Spacer()
                }
                
                // 통신사 선택
                VStack(alignment: .leading) {
                    Text("통신사")
                        .foregroundColor(.accentColor)
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.bottom, 6.5)
                    
                    HStack {
                        HStack {
                            Text(selectedCarriers.rawValue)  // 선택한 통신사 이름이 표시됨
                                .frame(width: 115)
                                .foregroundColor(.black)
                                .font(.system(size: 20))
                            
                            Menu {
                                ForEach(Carriers.allCases) { carrier in
                                    Button(action: {
                                        selectedCarriers = carrier
                                    }) {
                                        Text(carrier.rawValue)
                                            .foregroundColor(.black)
                                    }
                                }
                            } label: {
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.black)
                            }
                        }
                        .overlay(
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(.accentColor),
                            alignment: .bottom
                        )
                        
                        Spacer()
                    }
                    
                }
                
                VStack(alignment: .leading) {
                    Text("전화번호")
                        .foregroundColor(.accentColor)
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    // 전화번호 입력
                    TextField("전화번호", text: $smsService.phoneNumber)
                        .font(.title3)
                        .padding(.bottom, 7)
                        .onChange(of: smsService.phoneNumber) { newValue in
                            // 포맷팅된 번호를 화면에 표시하되, '-'가 없는 형태로 저장
                            let formattedNumber = phoneFormat.addCharacter(at: newValue)
                            
                            if formattedNumber.count <= 13 { // 전화번호는 11자리 이하로 제한
                                smsService.phoneNumber = formattedNumber
                            } else {
                                smsService.phoneNumber = String(formattedNumber.prefix(13))
                            }
                        }
                        .keyboardType(.numberPad)
                        .overlay(
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(.accentColor),
                            alignment: .bottom
                        )
                }
                
                HStack {
                    // 인증번호 입력
                    TextField("인증번호", text: $smsService.authCode)
                        .font(.title3)
                        .keyboardType(.numberPad)
                    VStack {
                        // 타이머 및 인증 확인
                        if smsService.isTimerRunning {
                            Text("남은 시간: \(smsService.timeRemaining)초")
                                .foregroundColor(.red)
                                .font(.caption)
                            
                            Button(action: {
                                smsService.sendSMS()
                            }, label: {
                                Text("인증번호 재발송")
                                    .foregroundColor(Color(.systemGray))
                                    .font(.caption)
                            })
                        }
                    }
                    if smsService.isCodeValid {
                        RoundedRectangle(cornerRadius: 10.0)
                            .frame(width: 70, height: 34)
                            .foregroundColor(.accentColor)
                            .overlay {
                                Text("인증성공")
                                    .foregroundColor(.white)
                                    .font(.caption)
                                    .fontWeight(.bold)
                            }
                            .padding(.bottom, 7)
                    } else {
                        Button(action: {
                            smsService.sendSMS()
                            sendSMS = !sendSMS
                            checkAuthCode = false
                            print(smsService.phoneNumber)
                        }, label: {
                            if sendSMS {
                                Button(action: {
                                    smsService.validateCode()
                                    checkAuthCode = true
                                    if smsService.isCodeValid {
                                        shouldNavigate = true
                                        viewModel.phoneNumber = smsService.phoneNumber
                                        
                                        print("저장 확인 : [ viewModel.phoneNumber : \(viewModel.phoneNumber) ] <- [ smsService.phoneNumber : \(smsService.phoneNumber) ] ")
                                    }
                                }, label: {
                                    RoundedRectangle(cornerRadius: 10.0)
                                        .frame(width: 70, height: 34)
                                        .overlay {
                                            Text("인증확인")
                                                .foregroundColor(.white)
                                                .font(.caption)
                                                .fontWeight(.bold)
                                        }
                                })
                                .disabled(smsService.authCode.isEmpty)
                            }
                            else {
                                RoundedRectangle(cornerRadius: 10.0)
                                    .frame(width: 70, height: 34)
                                    .overlay {
                                        Text("문자발송")
                                            .foregroundColor(.white)
                                            .font(.caption)
                                            .fontWeight(.bold)
                                    }
                            }
                        })
                        .padding(.bottom, 7)
                    }
                }
                .overlay(
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.accentColor),
                    alignment: .bottom
                )
                // 인증 결과 메시지
                if smsService.isCodeValid {
                    Text("인증 성공!")
                        .foregroundColor(.green)
                        .font(.caption)
                } else if smsService.authCode.isEmpty == false && smsService.timeRemaining == 0 {
                    Text("인증 실패. 시간 초과.")
                        .foregroundColor(.red)
                        .font(.caption)
                } else if smsService.authCode.isEmpty == false && checkAuthCode == true{
                    Text("인증 실패. 다시 시도하세요.")
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                Spacer()
                
            }
            .padding(.horizontal, 30)
            .padding(.top, 20)
            // navigationDestination을 사용하여 화면 전환을 관리
            .navigationDestination(isPresented: $shouldNavigate) {
                //AddGenderView()
                    //.navigationBarBackButtonHidden(true)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    // 타이틀
                    Text("조시미")
                        .font(.title)
                        .fontWeight(.bold)
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}



#Preview {
    AddPhoneNumberView()
        .environmentObject(RegistrationViewModel())
}
