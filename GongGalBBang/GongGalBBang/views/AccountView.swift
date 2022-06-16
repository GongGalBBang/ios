//
//  AccountView.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/06/15.
//

import SwiftUI

import SwiftUI
import ExytePopupView
import AnyFormatKitSwiftUI

struct AccountView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var postRegister = PostRegister()
    
    @State var tabIndex = 0
    
    func getBack() {
        presentationMode.wrappedValue.dismiss()
    }
    
    
    var body: some View {
        NavigationView {
            VStack{
                CustomTopTabBar(tabIndex: $tabIndex)
                    .padding(.top, 10)
                if tabIndex == 0 {
                    FindIdView(parent: self)
                }
                else if tabIndex == 1 {
                    ChangePwView()
                }
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width - 24, alignment: .center)
            .padding(.horizontal)
            .navigationTitle("계정 찾기")
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

struct CustomTopTabBar: View {
    @Binding var tabIndex: Int
    var body: some View {
        HStack(spacing: 20) {
            Spacer()
            TabBarButton(text: "아이디 찾기", isSelected: .constant(tabIndex == 0))
                .onTapGesture { onButtonTapped(index: 0) }
            Spacer()
            TabBarButton(text: "비밀번호 변경", isSelected: .constant(tabIndex == 1))
                .onTapGesture { onButtonTapped(index: 1) }
            Spacer()
        }
        .border(width: 1, edges: [.bottom], color: .black, type : 0)
    }
    
    private func onButtonTapped(index: Int) {
        withAnimation { tabIndex = index }
    }
}

struct TabBarButton: View {
    let text: String
    @Binding var isSelected: Bool
    var body: some View {
        Text(text)
            .fontWeight(isSelected ? .heavy : .regular)
            .font(.custom("Avenir", size: 16))
            .padding(.bottom,10)
            .padding(.top,10)
            .border(width: isSelected ? 2 : 1, edges: [.bottom], color: .black, type: 1)
    }
}

struct EdgeBorder: Shape {

    var width: CGFloat
    var edges: [Edge]
    var type : Int

    func path(in rect: CGRect) -> Path {
        var path = Path()
        for edge in edges {
            var x: CGFloat {
                switch edge {
                case .top, .bottom, .leading:
                    if(type == 0) {
                        return rect.minX
                    }
                    else {
                        return rect.minX - 40
                    }
                case .trailing: return rect.maxX
                }
            }

            var y: CGFloat {
                switch edge {
                case .top, .leading, .trailing: return rect.minY
                case .bottom: return rect.maxY - width/2
                }
            }

            var w: CGFloat {
                switch edge {
                case .top, .bottom:
                    if(type == 0) {
                        return rect.width
                    }
                    else {
                        return rect.width + 80
                    }
                case .leading, .trailing: return self.width
                }
            }

            var h: CGFloat {
                switch edge {
                case .top, .bottom: return self.width
                case .leading, .trailing: return rect.height
                }
            }
            path.addPath(Path(CGRect(x: x, y: y, width: w, height: h)))
        }
        return path
    }
}

extension View {
    func border(width: CGFloat, edges: [Edge], color: SwiftUI.Color, type : Int) -> some View {
        overlay(EdgeBorder(width: width, edges: edges, type: type).foregroundColor(color))
    }
}


struct AcountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}

