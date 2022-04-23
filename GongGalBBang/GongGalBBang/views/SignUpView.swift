//
//  SignUpView.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/04/14.
//

import SwiftUI

struct SignUpView: View {
    @State var fullName = ""
    @State var emailAddress = ""
    @State var password = ""
    @State var emailUpdate = false
    @Environment(\.presentationMode) var presentationMode
    @State var STATE: Int? = 0
    
    var body: some View {
        NavigationView {
            HStack {
                Spacer()
                Spacer()
                VStack {
                    NavigationLink(destination: MainView().navigationBarHidden(true), tag: 1, selection: $STATE) {
                        EmptyView()
                    }
                    
                    // full name
                    VStack(alignment: .leading) {
                        Text("Full Name")
                            .foregroundColor(.black)
                        TextField("Enter your Full Name", text: $fullName)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.black)
                    }
                    
                    // email
                    VStack(alignment: .leading) {
                        Text("Email")
                            .foregroundColor(.black)
                        TextField("Enter your Email", text: $emailAddress)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.black)
                    }
                    
                    // password
                    VStack(alignment: .leading) {
                        Text("Password")
                            .foregroundColor(.black)
                        SecureField("Must be at least 6 characters", text: $password)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.black)
                    }
                    
                    // checkbox
                    Toggle("Sign Up for email updates.", isOn: $emailUpdate)
                        .foregroundColor(.black)
                        .font(.system(size: 15))
                        .toggleStyle(CheckboxStyle())
                        .padding()
                    
                    // sign up button
                    Button(action: {
                        STATE = 1
                    }){
                        Text("SIGN UP")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .font(.system(size: 17))
                    }
                        .buttonStyle(SignUpStyle())
                    
                    Text("By continuing, you agree to accept\n our Privacy Policy & Terms of Service")
                        .foregroundColor(.black)
                        .font(.system(size: 13))
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                Spacer()
                Spacer()
            }
                
            .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
            .navigationTitle("SIGN UP")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    },label: {Image(systemName: "xmark")
                        .foregroundColor(.black)
                    })
                }
            })
        }
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
