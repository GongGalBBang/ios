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
      .cornerRadius(8)
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
