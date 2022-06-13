//
//  Helpers.swift
//  ui
//
//  Created by 김택현 on 2022/05/22.
//

import SwiftUI

class LoginParameter: ObservableObject {
    @Published var res = LoginResult()
}

func isValidEmail(testStr:String) -> Bool {
      let emailRegEx = "[a-z0-9._%+-]+@[a-z0-9.-]+\\.[A-Za-z]{2,64}"
      let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
      return emailTest.evaluate(with: testStr)
}
func isValidName(testStr:String) -> Bool {
    let nameRegEx = "[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]{3,}$"
    let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
    return nameTest.evaluate(with: testStr)
}
func isValidPassword(testStr:String) -> Bool {
    let passwordRegEx = "^(?=.*[A-Za-z])(?=.*[0-9]).{6,50}"
//    (?=.*[!@#$%^&*()_+=-])
    let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
    return passwordTest.evaluate(with: testStr)
}

func createBottomToastMessage(title : String, message : String) -> some View {
    HStack(alignment: .top,spacing: 10){
        VStack(alignment: .leading){
            Text(title)
                .fontWeight(.black)
                .foregroundColor(Color.white)
            
            Text(message)
                .font(.system(size: 14))
                .foregroundColor(Color.white)
            Divider().opacity(0)
        }
    }
    .padding(15)
    .frame(width: 300)
    .background(.tint)
    .cornerRadius(20)
}
enum Club: String, CaseIterable, Identifiable {
    case 줄울림
    case 재징유
    case 에어비트
    case 도스
    case 광끼
    
    var id: String { self.rawValue }
}

enum Major: String, CaseIterable, Identifiable {
    case 소프트웨어학과
    case 항공전자정보공학부
    case 항공우주및기계공학부
    case 신소재공학과
    case 항공교통물류학부
    
    var id: String { self.rawValue }
}

struct ClubSelectPickerView: View {
    // Binding to the selected items we want to track
    @Binding var selectedItems: [Club]
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
 
    var body: some View {
        Form {
            List {
                ForEach(Club.allCases, id: \.id) { item in
                    Button(action: {
                        print(selectedItems)
                        withAnimation {
                            if self.selectedItems.contains(item) {
                                // Previous comment: you may need to adapt this piece
                                self.selectedItems.removeAll(where: { $0 == item })
                            } else {
                                self.selectedItems.append(item)
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: "checkmark")
                                .opacity(self.selectedItems.contains(item) ? 1.0 : 0.0)
                            Text(item.rawValue)
                        }
                    }
                    .foregroundColor(.primary)
                }
            }
        }
        .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
        .navigationTitle("동아리 선택")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                },label: {Image(systemName: "chevron.backward")
                    .foregroundColor(.black)
                })
            }
        })
    }
}

struct MajorSelectPickerView: View {
    // Binding to the selected items we want to track
    @Binding var selectedItems: [Major]
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
 
    var body: some View {
        Form {
            List {
                ForEach(Major.allCases, id: \.id) { item in
                    Button(action: {
                        withAnimation {
                            if self.selectedItems.contains(item) {
                                // Previous comment: you may need to adapt this piece
                                self.selectedItems.removeAll(where: { $0 == item })
                            } else {
                                self.selectedItems.append(item)
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: "checkmark")
                                .opacity(self.selectedItems.contains(item) ? 1.0 : 0.0)
                            Text(item.rawValue)
                        }
                    }
                    .foregroundColor(.primary)
                }
            }
        }
        .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
        .navigationTitle("동아리 선택")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                },label: {Image(systemName: "chevron.backward")
                    .foregroundColor(.black)
                })
            }
        })
    }
}
