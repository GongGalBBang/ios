//
//  RoomResponse.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/06/05.
//

import SwiftUI
import Foundation

struct RoomResponse: Codable, Hashable {
    var result: [RoomResult]
}

struct RoomResult: Codable, Hashable {
    var className: Int
    var data : [Date]
}

struct Date: Codable, Hashable {
    var date : String
    var member : Float
}
