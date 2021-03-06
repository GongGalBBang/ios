//
//  RegisterRequest.swift.swift
//  GongGalBBang
//
//  Created by κΉνν on 2022/06/13.
//

import SwiftUI

struct RegisterRequest: Hashable, Codable {
    var name : String
    var user : LoginRequest
    var department: String
    var circle : String
    var phoneNumber : String
}
