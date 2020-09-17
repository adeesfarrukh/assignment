//
//  Enums.swift
//  Assignemnt
//
//  Created by Adees Farakh on 17.09.20.
//  Copyright © 2020 AdiAtizaz. All rights reserved.
//
import Foundation


public enum RequestType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}


enum ServiceTag: Int {
    case books = 1
}

enum API: String {
    case books
}

enum APIUrls: String {
    case books = "volumes?q=isbn:0747532699"
    
}

enum DefaultValue{
    static let string = ""
    static let number = 0
    static let double = 0.0
}

enum Links : Int{
    case previewLink = 10
    case canonicalLink = 20
    case infoLink = 30
}

