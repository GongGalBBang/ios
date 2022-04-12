//
//  ContentView.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/04/07.
//

import SwiftUI

struct ContentView: View {
    @State var showDetails = false
    var body: some View {
        VStack{
            Text("Log In")
                .font(.title)
                .padding()
            
            VStack {
                Text("Email address")
            }
            
            Button(action: {
                print("login tapped!")
            }) {
                Text("로그인")
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .font(.title3)
            }.buttonStyle(LoginStyle())
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
