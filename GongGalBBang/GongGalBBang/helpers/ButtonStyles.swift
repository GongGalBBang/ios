//
//  Models.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/04/14.
//

import SwiftUI

struct SignUpStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .frame(minWidth: 100, idealWidth: 0, maxWidth: 500, minHeight: 50, idealHeight: 0, maxHeight: 50, alignment: .center)
      .foregroundColor(Color.black)
      .background(Color.black)
      .cornerRadius(10)
  }
}

struct LoginStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(.vertical, 12)
      .padding(.horizontal, 45)
      .foregroundColor(Color.black)
      .background(Color.white)
      .cornerRadius(10)
      .overlay(RoundedRectangle(cornerRadius: 8)
                .stroke(.black, lineWidth: 2)
      )
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

struct FavoriteButton: View {
    @Binding var isSet: Bool
    
    var body: some View{
        Button {
            isSet.toggle()
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? .yellow: .gray)
        }
    }
}
