//
//  RegisterResponse.swift
//  GongGalBBang
//
//  Created by κΉνν on 2022/06/13.
//

import SwiftUI

struct RegisterResponse: Codable, Hashable {
    var body : RegisterResult
}
struct RegisterResult: Codable, Hashable {
    var statusCode : Int?
    var result : String?
}
