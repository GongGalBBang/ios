//
//  LoginResponse.swift
//  GongGalBBang
//
//  Created by κΉνν on 2022/06/10.
//

import SwiftUI
import Foundation

struct LoginResponse: Codable, Hashable {
    var body: LoginResult
}

struct LoginResult: Codable, Hashable {
    var statusCode : Int?
    var result : Result?
}

struct Result : Codable, Hashable {
    var name : String
    var club: String
    var major : String
}
