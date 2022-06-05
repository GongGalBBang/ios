//
//  Response.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/05/27.
//

import SwiftUI

struct Response : Decodable {
    var time : String
    var averageClub : Float
    var averageMajor : Float
}

struct ResponseArray : Decodable {
    let response : [Response]
}
