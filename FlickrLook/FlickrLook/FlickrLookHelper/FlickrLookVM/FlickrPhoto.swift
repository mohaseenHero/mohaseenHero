//
//  FlickrPhoto.swift
//  FlickrLook
//
//  Created by Mohaseen TmmT on 17/07/21.
//

import UIKit

struct FlickrPhoto  : Codable {
    
    let id : String?
    let owner : String?
    let secret : String?
    let server : String?
    let farm : Int?
    let title : String?
    let ispublic : Int?
    let isfriend : Int?
    let isfamily : Int?
    let url_o : String?
    let height_o : Int?
    let width_o : Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case owner = "owner"
        case secret = "secret"
        case server = "server"
        case farm = "farm"
        case title = "title"
        case ispublic = "ispublic"
        case isfriend = "isfriend"
        case isfamily = "isfamily"
        case url_o = "url_o"
        case height_o = "height_o"
        case width_o = "width_o"
    }
}

