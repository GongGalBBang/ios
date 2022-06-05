//
//  Helpers.swift
//  ui
//
//  Created by 김택현 on 2022/05/22.
//

import SwiftUI

func isValidEmail(testStr:String) -> Bool {
      let emailRegEx = "[a-z0-9._%+-]+@[a-z0-9.-]+\\.[A-Za-z]{2,64}"
      let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
      return emailTest.evaluate(with: testStr)
}
func isValidName(testStr:String) -> Bool {
    let nameRegEx = "^[가-힣]{2,4}$"
    let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
    return nameTest.evaluate(with: testStr)
}
func isValidPassword(testStr:String) -> Bool {
    let passwordRegEx = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{6,50}"
    let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
    return passwordTest.evaluate(with: testStr)
}

func createBottomToastMessage(title : String, message : String) -> some View {
    HStack(alignment: .top,spacing: 10){
        VStack(alignment: .leading){
            let _ = print(title)
            Text(title)
                .fontWeight(.regular)
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
