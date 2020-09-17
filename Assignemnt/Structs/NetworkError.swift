//
//  NetworkError.swift
//  Assignemnt
//
//  Created by Adees Farakh on 17.09.20.
//  Copyright © 2020 AdiAtizaz. All rights reserved.
//

import Foundation

struct NetworkError {
    var errorCode: Int?
    var errorDetails: String?
    var message: String?
        
    init(code: Int, details: String, message: String) {
        self.errorCode = code
        self.errorDetails = details
        self.message = message
    }
}

extension NetworkError: Codable {
    enum CodingKeys: String, CodingKey {
        case errorCode, errorDetails, message
    }
}
