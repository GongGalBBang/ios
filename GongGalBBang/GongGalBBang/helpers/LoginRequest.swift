//
//  User.swift.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/06/10.
//

import SwiftUI

struct LoginRequest: Hashable, Codable {
    var user_id : String
    var user_pw : String
}

struct UserRegister: Hashable, Codable {
    var name : String
    var user : LoginRequest
    var department: [Int]
    var circle : [Int]
}
