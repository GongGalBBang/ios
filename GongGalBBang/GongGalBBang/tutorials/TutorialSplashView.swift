//
//  TutorialSplashView.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/06/17.
//

import SwiftUI

struct TutorialSplashView: View {
    @State private var isView: Bool = false
    @State private var color = Color.white
    @State private var secondColor = Color.white
    @State private var skipColor = Color.white
    @State var STATE: Int? = 0
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: LoginView().navigationBarHidden(true), tag: 2, selection: $STATE) {
                    EmptyView()
                }
                NavigationLink(destination: TutorialMainView().navigationBarHidden(true), tag: 1, selection: $STATE) {
                    EmptyView()
                }
                HStack {
                    Spacer()
                    Button(action: { STATE = 1}
                           ,label: {Image(systemName: "arrow.right")
                            .resizable()
                            .foregroundColor(.white)
                            .colorMultiply(self.secondColor)
                            .frame(width: 20, height: 20)
                            .animation(.easeInOut(duration: 1), value: isView)
                    })
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 20))
                }
                Spacer()
                
                Text("환영합니다")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .colorMultiply(self.color)
                    .onAppear() {
                        withAnimation(.easeInOut(duration: 1)) {
                            self.color = Color.black
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.isView.toggle()
                                self.secondColor = Color.black
                                self.skipColor = Color.accentColor
                            }
                        }
                    }
                    .font(.custom("NotoSansKR-Black.otf", size: 40))
                    .padding(.bottom, 10)
                
                VStack(alignment: .center) {
                    Text("공갈빵은 \"과방 & 동방\"의")
                        .fontWeight(.light)
                        .foregroundColor(Color.white)
                        .colorMultiply(self.secondColor)
                        .animation(.easeInOut(duration: 1), value: isView)
                        .font(.custom("NotoSansKR-Regular.otf", size: 17))
                    Text("혼잡도를 확인할 수 있는 앱입니다.")
                        .fontWeight(.light)
                        .foregroundColor(Color.white)
                        .colorMultiply(self.secondColor)
                        .animation(.easeInOut(duration: 1), value: isView)
                        .padding(.bottom, 10)
                        .font(.custom("NotoSansKR-Regular.otf", size: 17))
                    
                    Text("한번 살펴볼까요?")
                        .fontWeight(.light)
                        .foregroundColor(Color.white)
                        .colorMultiply(self.secondColor)
                        .animation(.easeInOut(duration: 1), value: isView)
                        .font(.custom("NotoSansKR-Regular.otf", size: 17))
                }
                
                Spacer()
                Button(action: {
                    UserDefaults.standard.set(true, forKey: "tutorial")
                    STATE = 2
                }) {
                    Text("넘어가기")
                        .fontWeight(.light)
                        .foregroundColor(Color.white)
                        .colorMultiply(self.skipColor)
                        .animation(.easeInOut(duration: 1), value: isView)
                }
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}

struct TutorialSplashView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialSplashView()
    }
}
