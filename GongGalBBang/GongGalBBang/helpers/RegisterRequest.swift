//
//  RegisterRequest.swift.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/06/13.
//

import SwiftUI

struct RegisterRequest: Hashable, Codable {
    var name : String
    var user : LoginRequest
    var department: String
    var circle : String
    var phoneNumber : String
}
