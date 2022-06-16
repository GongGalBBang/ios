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
    let nameRegEx = "[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]{2,}$"
    let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
    return nameTest.evaluate(with: testStr)
}
func isValidPassword(testStr:String) -> Bool {
    let passwordRegEx = "^(?=.*[A-Za-z])(?=.*[0-9]).{6,50}"
//    (?=.*[!@#$%^&*()_+=-])
    let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
    return passwordTest.evaluate(with: testStr)
}

func isValidPhoneNumber(testStr:String) -> Bool {
    let phoneRegEx = "^010[0-9]{8}$"
    let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
    return phoneTest.evaluate(with: testStr)
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
    case 조커
    
    var id: String { self.rawValue }
}

enum Major: String, CaseIterable, Identifiable {
    case 소프트웨어학과
    case 항공전자정보공학부
    case 항공우주및기계공학부
    case 신소재공학과
    case 항공운항학과
    
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

func getRoomName(room : RoomResult) -> String {
    if(room.className < 200) {
        switch room.className {
        case 101:
            return Major.allCases[0].rawValue
        case 102:
            return Major.allCases[1].rawValue
        case 103:
            return Major.allCases[2].rawValue
        case 104:
            return Major.allCases[3].rawValue
        case 105:
            return Major.allCases[4].rawValue
        default:
            return "."
        }
    }
    else {
        switch room.className {
        case 200:
            return Club.allCases[0].rawValue
        case 201:
            return Club.allCases[1].rawValue
        case 202:
            return Club.allCases[2].rawValue
        case 203:
            return Club.allCases[3].rawValue
        case 204:
            return Club.allCases[4].rawValue
        default:
            return "."
        }
    }
}

func getMajorSelected(majorSelectedItems : [Major]) -> String {
    var major = ""
    for item in majorSelectedItems {
        switch item {
        case .소프트웨어학과:
            if major == "" {
                major += "1"
            }
            else {
                major += ",1"
            }
        case .항공전자정보공학부:
            if major == "" {
                major += "2"
            }
            else {
                major += ",2"
            }
        case .항공우주및기계공학부:
            if major == "" {
                major += "3"
            }
            else {
                major += ",3"
            }
        case .신소재공학과:
            if major == "" {
                major += "4"
            }
            else {
                major += ",4"
            }
        case .항공운항학과:
            if major == "" {
                major += "5"
            }
            else {
                major += ",5"
            }
        }
    }
    return major
}

func getClubSelected(clubSelectedItems : [Club]) -> String {
    var club = ""
    for item in clubSelectedItems {
        switch item {
        case .줄울림:
            if club == "" {
                club += "0"
            }
            else {
                club += ",0"
            }
        case .도스:
            if club == "" {
                club += "1"
            }
            else {
                club += ",1"
            }
        case .에어비트:
            if club == "" {
                club += "2"
            }
            else {
                club += ",2"
            }
        case .재징유:
            if club == "" {
                club += "3"
            }
            else {
                club += ",3"
            }
        case .조커:
            if club == "" {
                club += "4"
            }
            else {
                club += ",4"
            }
        }
    }
    return club
}

func getConfuse(date: [Datee], time: String) -> String {
    var ans = ""
    for date in date {
        if(date.date == time) {
            switch date.member {
            case 0...3:
                ans = "원활"
            case 3...6:
                ans = "보통"
            case 6...10:
                ans = "복잡"
            default:
                ans = "확인 불가"
            }
        }
    }
    return ans
}

func getHour() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH"
    let currentDate = formatter.string(from: Date())
    return currentDate
}

func getConfuseColor(confuse : String) -> Color {
    var color : Color
    if(confuse == "원활") {
        color = .green
    }
    else if(confuse == "보통") {
        color = .black
    }
    else if(confuse == "복잡") {
        color = .red
    }
    else {
        color = .gray
    }
    return color
}

func phoneformat(num : String) -> String{
    let regex = try? NSRegularExpression(pattern: "(010)([0-9]{4})([0-9]{4})", options: .caseInsensitive)
    
    let modString = regex!.stringByReplacingMatches(in: num, options: [], range: NSRange(num.startIndex..., in: num), withTemplate: "$1-$2-$3")

    return modString
}
