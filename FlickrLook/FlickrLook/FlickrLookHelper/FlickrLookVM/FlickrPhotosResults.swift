//
//  FlickrPhotosResults.swift
//  FlickrLook
//
//  Created by Mohaseen TmmT on 17/07/21.
//

import Foundation

struct FlickrPhotosResults : Codable {
    
    let page : Int?
    let pages : Int?
    let perpage : Int?
    let total : Int?
    let photo : [FlickrPhoto]?

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case pages = "pages"
        case perpage = "perpage"
        case total = "total"
        case photo = "photo"
    }
}
