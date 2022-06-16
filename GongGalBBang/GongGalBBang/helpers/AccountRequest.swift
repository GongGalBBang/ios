//
//  Account.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/06/15.
//

import SwiftUI

struct AccountRequest: Hashable, Codable {
    var function_case : Int
    var phoneNumber: String?
    var user_name: String
    var user_id: String?
    var change_pw : String?
}
