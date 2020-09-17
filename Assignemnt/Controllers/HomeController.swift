//
//  HomeController.swift
//  Assignemnt
//
//  Created by Adees Farakh on 17.09.20.
//  Copyright © 2020 AdiAtizaz. All rights reserved.
//

import UIKit

class HomeController {
    func handleVolumesRequest(delegate: NetworkOperationHandler) {
        let jsonData = Data()
        let url = Router.prepareAPIUrl(api: .books)
        let networkOperation = NetworkOperation.init(data: jsonData, url: url, delegate: delegate, requestType: Router.requestMethod(api: .books), headers: true, tag: ServiceTag.books.rawValue)
        PendingOperations.pendingOperations.mainOperationsQueue.addOperation(networkOperation)
    }
}
