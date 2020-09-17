//
//  Router.swift
//  Assignemnt
//
//  Created by Adees Farakh on 17.09.20.
//  Copyright © 2020 AdiAtizaz. All rights reserved.
//
import Foundation
import UIKit


fileprivate let httpScheme = "https://"
fileprivate let hostName = "www.googleapis.com/books/v1/" 

fileprivate let postMethod = "POST"
fileprivate let getMethod = "GET"

class Router {
    
    static func prepareBaseUrl() -> String {
        let currentScheme = httpScheme
        let baseUrl = hostName
        return currentScheme + baseUrl
    }
    
    static func prepareAPIUrl(api: API) -> String {
        switch api {
        case .books:
            return prepareBaseUrl() + APIUrls.books.rawValue
        }
        
    }

    
    static func requestMethod(api: API) -> String {
        switch api {
        case .books:
            return getMethod
        }
    }
    
}
