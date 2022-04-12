//
//  ContentView.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/04/07.
//

import SwiftUI

struct ContentView: View {
    @State var emailAddress = ""
    @State var password = ""
    var body: some View {
        HStack {
            Spacer()
            VStack{
                Text("Log In")
                    .font(.title)
                    .padding(EdgeInsets(top: 70, leading: 0, bottom: 50, trailing: 0))
                
                VStack(alignment: .leading) {
                    Text("Email address")
                    TextField("Enter your Email address", text: $emailAddress)
                        .textFieldStyle(.roundedBorder)
                }
                .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 50))
                
                VStack(alignment: .leading) {
                    Text("Password")
                    SecureField("Enter your Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                }
                .padding(EdgeInsets(top: 0, leading: 50, bottom: 80, trailing: 50))
                Button(action: {
                    print("login tapped!")
                }) {
                    Text("Log In")
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                        .font(.title3)
                }
                    .buttonStyle(LoginStyle())
                    .padding()
                
                Button(action: {
                    print("sign up tapped!")
                }) {
                    Text("Don't have account? Sign Up")
                        .fontWeight(.light)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 70, trailing: 0))
            }.border(.black, width: 2)
            Spacer()
        }
    }
}
struct LoginStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(.vertical, 12)
      .padding(.horizontal, 45)
      .foregroundColor(Color.black)
      .background(Color.white)
      .cornerRadius(8)
      .overlay(RoundedRectangle(cornerRadius: 8)
                .stroke(.black, lineWidth: 2)
      )
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
