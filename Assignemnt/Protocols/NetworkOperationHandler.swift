//
//  NetworkOperationHandler.swift
//  Assignemnt
//
//  Created by Adees Farakh on 17.09.20.
//  Copyright © 2020 AdiAtizaz. All rights reserved.
//

import Foundation

protocol NetworkOperationHandler{
    
    func onSuccess(data: Data, response: URLResponse, tag: Int)
    func onFailure(data: Data, tag: Int)
}
