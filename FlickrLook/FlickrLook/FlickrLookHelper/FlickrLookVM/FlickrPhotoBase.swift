//
//  FlickrPhotoBase.swift
//  FlickrLook
//
//  Created by Mohaseen TmmT on 22/07/21.
//

import Foundation
struct FlickrPhotoBase : Codable {
    
    let photos : FlickrPhotosResults?
    let stat : String?
    
    enum CodingKeys: String, CodingKey {
        case photos = "photos"
        case stat = "stat"
    }
}
