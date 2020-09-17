//
//  Book.swift
//  Assignemnt
//
//  Created by Adees Farakh on 17.09.20.
//  Copyright © 2020 AdiAtizaz. All rights reserved.
//

import UIKit

class Book: NSObject {
    
    var id = DefaultValue.string
    var title = DefaultValue.string
    var desc = DefaultValue.string
    var authors = DefaultValue.string
    var publisher = DefaultValue.string
    var publishedDate = DefaultValue.string
    var rating = DefaultValue.double
    var imgUrl = DefaultValue.string
    var lang = DefaultValue.string
    var canonicalVolumeLink = DefaultValue.string
    var previewLink = DefaultValue.string
    var infoLink = DefaultValue.string
    
    
    
    init(_ productJSonObject: Dictionary<String, Any>?) {
        super.init()
        if(productJSonObject != nil){
            parseJsonData(productJSonObject: productJSonObject!)
        }
    }
    
    func parseJsonData(productJSonObject: Dictionary<String, Any>) {
        id = productJSonObject["id"] as? String ?? DefaultValue.string
        if let volumeInfo = productJSonObject["volumeInfo"] as? Dictionary<String, Any>{
            title = volumeInfo["title"] as? String ?? DefaultValue.string
            desc = volumeInfo["description"] as? String ?? DefaultValue.string
            publisher = volumeInfo["publisher"] as? String ?? DefaultValue.string
            publishedDate = volumeInfo["publishedDate"] as? String ?? DefaultValue.string
            
            lang = volumeInfo["language"] as? String ?? DefaultValue.string
            infoLink = volumeInfo["infoLink"] as? String ?? DefaultValue.string
            previewLink = volumeInfo["previewLink"] as? String ?? DefaultValue.string
            canonicalVolumeLink = volumeInfo["canonicalVolumeLink"] as? String ?? DefaultValue.string
            rating = volumeInfo["averageRating"] as? Double ?? DefaultValue.double
            
            if let authorsList = volumeInfo["authors"] as? Array<String>{
                self.authors = getAuthors(authorsList: authorsList)
            }
            if let imageLinks = volumeInfo["imageLinks"] as? Dictionary<String, Any>{
                imgUrl = imageLinks["thumbnail"] as? String ?? DefaultValue.string
            }
        }
        
    }
    
    func getAuthors(authorsList : Array<String>) -> String{
        var concatenateAuthor = DefaultValue.string
        for case let (index,author) in authorsList.enumerated(){
            concatenateAuthor += author + ((index < authorsList.count) ? "," : "" )
        }
        
        return concatenateAuthor
    }
}

