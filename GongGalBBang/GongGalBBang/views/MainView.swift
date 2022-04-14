//
//  MainView.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/04/14.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        Button(action: {
            print("room tapped!")
        }) {
            Text("휴게 공간 확인하기")
                .foregroundColor(.black)
                .fontWeight(.semibold)
                .font(.system(size: 17))
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
