//
//  ContentView.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/06/16.
//

import SwiftUI

struct ContentView: View {
    @State private var tutorial = UserDefaults.standard.bool(forKey: "tutorial")
    var body: some View {
        if(tutorial == false) {
            TutorialSplashView()
        }
        else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
