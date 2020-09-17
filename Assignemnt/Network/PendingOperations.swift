//
//  PendingOperations.swift
//  Assignemnt
//
//  Created by Adees Farakh on 17.09.20.
//  Copyright © 2020 AdiAtizaz. All rights reserved.
//

import UIKit
import Foundation

class PendingOperations: NSObject {
    
    var mainOperationsQueue: OperationQueue
    
    var updateMainOperationsQueue:OperationQueue {
        get {
            return self.mainOperationsQueue
        }
    }
    
    private override init() {
        mainOperationsQueue = OperationQueue()
    }
    
    //MARK: Shared Instance
    
    static let pendingOperations: PendingOperations = PendingOperations()
    
}
