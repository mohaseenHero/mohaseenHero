//
//  FlickrPhotosVM.swift
//  FlickrLook
//
//  Created by Mohaseen TmmT on 24/07/21.
//

import Foundation

class FlickrPhotosVM: NSObject {
    
    private var flickrPhotosM: FlickrPhotosM = FlickrPhotosM()
    
    var gallaryList = [FlickrPhoto]() {
        didSet {
            flickrPhotosM.gallaryList = gallaryList
        }
    }
    
    var selectedindex: Int = -1 {
        didSet {
            flickrPhotosM.selectedindex = selectedindex
        }
    }
    
    
    
}
