//
//  NetworkOperation.swift
//  Assignemnt
//
//  Created by Adees Farakh on 17.09.20.
//  Copyright © 2020 AdiAtizaz. All rights reserved.
//

import UIKit
import Foundation

class NetworkOperation: Operation {
    
    
    var data: Data
    
    var url: String
    
    var networkDelegate: NetworkOperationHandler?
    
    var requestType: String
    
    var customHeaders: Bool
    
    var tag: Int!
    
    init(data: Data,url: String, delegate: NetworkOperationHandler, requestType: String, headers: Bool, tag: Int) {
        
        self.data = data
        self.url = url
        self.networkDelegate = delegate
        self.requestType = requestType
        self.customHeaders = headers
        self.tag = tag
    }
    
    enum OperationState: Int {
        case ready
        case executing
        case finished
    }
    
    private let stateQueue = DispatchQueue(
        label: "MainQues",
        attributes: .concurrent)
    
    private var rawState = OperationState.ready
    
    private var state: OperationState {
        get {
            return stateQueue.sync(execute: { rawState })
        }
        set {
            willChangeValue(forKey: "state")
            stateQueue.sync(
                flags: .barrier,
                execute: { rawState = newValue })
            didChangeValue(forKey: "state")
        }
    }
    
    @objc private dynamic class func keyPathsForValuesAffectingIsReady() -> Set<String> {
        return ["state"]
    }
    
    @objc private dynamic class func keyPathsForValuesAffectingIsExecuting() -> Set<String> {
        return ["state"]
    }
    
    @objc private dynamic class func keyPathsForValuesAffectingIsFinished() -> Set<String> {
        return ["state"]
    }
    
    override var isReady: Bool {
        return state == .ready && super.isReady
    }
    
    override var isExecuting: Bool {
        return state == .executing
    }
    
    override var isFinished: Bool {
        return state == .finished
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    
    
    public override final func start() {
        super.start()
        
        if isCancelled {
            finish()
            return
        }
        
        state = .executing
        execute()
    }
    
    
    // MARK: - Public
    /// Subclasses must implement this to perform their work and they must not
    /// call `super`. The default implementation of this function throws an
    /// exception.
    open func execute() {
        
        var string = self.url
        print(string)
        string = string.replacingOccurrences(of: " ", with: "-")
        if let url = URL.init(string: string) {
            let request = NSMutableURLRequest(url: url as URL)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = self.requestType
            
            if (self.requestType == RequestType.post.rawValue || self.requestType == RequestType.put.rawValue || self.requestType == RequestType.delete.rawValue){
                request.httpBody = data
            }
            
            let session = Foundation.URLSession.shared
            let task = session.dataTask(with: request as URLRequest) { (responseData, response, error) -> Void in
                let data = Data()
                //TO DO: Refactor
                if let responseResult = response as? HTTPURLResponse {
                    let code = responseResult.statusCode
                    print(code)
                    if let resData = responseData {
                        if code == 200 && error == nil {
                            self.networkDelegate?.onSuccess(data: resData, response: response!, tag: self.tag)
                        } else {
                           self.networkDelegate?.onFailure(data: resData, tag: self.tag)
                        }
                    } else {
                        self.networkDelegate?.onFailure(data: data, tag: self.tag)
                    }
                } else {
                    self.networkDelegate?.onFailure(data: data, tag: self.tag)
                }
                
            }
            
            task.resume()
        } else {
            let data = Data()
            self.networkDelegate?.onFailure(data: data, tag: self.tag)
        }
        
    }
    
    /// Call this function after any work is done or after a call to `cancel()`
    /// to move the operation into a completed state.
    public final func finish() {
        state = .finished
    }
    
}
