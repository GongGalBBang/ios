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
    
    var body: some View {
        HStack {
            Spacer()
            VStack{
                // close & title & log in
                HStack {
                    Button(action: {
                        print("Close tapped!")
                    }) {
                            Image(systemName: "xmark")
                        .foregroundColor(.black)
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                    }
                    
                    Spacer()
                    
                    Text("Sign Up")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
                    
                    Spacer()
                    
                    Button(action: {
                        print("log in tapped")
                    }) {
                        Text("LOG IN")
                            .fontWeight(.bold)
                            .font(.system(size: 15))
                    }
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
                
                // full name
                VStack(alignment: .leading) {
                    Text("Full Name")
                    TextField("Enter your Full Name", text: $fullName)
                        .textFieldStyle(.roundedBorder)
                }
                
                // email
                VStack(alignment: .leading) {
                    Text("Email")
                    TextField("Enter your Email", text: $emailAddress)
                        .textFieldStyle(.roundedBorder)
                }
                
                // password
                VStack(alignment: .leading) {
                    Text("Password")
                    SecureField("Must be at least 6 characters", text: $password)
                        .textFieldStyle(.roundedBorder)
                }
                
                // checkbox
                Toggle("Sign Up for email updates.", isOn: $emailUpdate)
                    .font(.system(size: 15))
                    .toggleStyle(CheckboxStyle())
                    .padding()
                
                // sign up button
                Button(action: {
                    print("sign up tapped!")
                }) {
                    Text("SIGN UP")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .font(.system(size: 17))
                }
                    .buttonStyle(SignUpStyle())
                
                Text("By continuing, you agree to accept\n our Privacy Policy & Terms of Service")
                    .font(.system(size: 13))
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                
                Spacer()
                Spacer()
            }
            Spacer()
        }
    }
}

struct CheckboxStyle: ToggleStyle {

    func makeBody(configuration: Self.Configuration) -> some View {

        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .blue : .gray)
                configuration.label
        }
        .onTapGesture { configuration.isOn.toggle() }

    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
