//
//  AccountResult.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/06/15.
//

import SwiftUI
import Foundation

struct AccountResponse: Codable, Hashable {
    var body : AccountResult
}

struct AccountResult : Codable, Hashable {
    var statusCode : Int?
    var result : String?
}
