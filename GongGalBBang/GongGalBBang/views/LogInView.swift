//
//  ContentView.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/04/07.
//

import SwiftUI

struct LogInView: View {
    @State var emailAddress = ""
    @State var password = ""
    @State var STATE: Int? = 0
    var body: some View {
        NavigationView{
            HStack {
                Spacer()
                Spacer()
                VStack{
                    NavigationLink(destination: RoomListView().environmentObject(ModelData()) .navigationBarHidden(true), tag: 1, selection: $STATE) {
                        EmptyView()
                    }
                    NavigationLink(destination: SignUpView()
                        .navigationBarHidden(true),  tag: 2, selection: $STATE) {
                        EmptyView()
                    }
                    
                    Image("GongGalBBang")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200)
                        .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Email address")
                        TextField("Enter your Email address", text: $emailAddress)
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Password")
                        SecureField("Enter your Password", text: $password)
                            .textFieldStyle(.roundedBorder)
                    }
                    Button(action: {STATE = 1}) {
                        Text("Log In")
                            .foregroundColor(.black)
                            .fontWeight(.semibold)
                            .font(.title3)
                    }
                        .buttonStyle(LoginStyle())
                        .padding()
                    
                    Button(action: {STATE = 2}) {
                        Text("Don't have account? Sign Up")
                            .fontWeight(.light)
                    }
                    Spacer()
                }
                Spacer()
                Spacer()
            }
            .navigationTitle("LOG IN")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
