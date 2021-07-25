//
//  FlickrBaseURL.swift
//  FlickrLook
//
//  Created by Mohaseen TmmT on 17/07/21.
//

import UIKit

let apiKey = "cb5fa45a2dfb0f9f4b0af13338beaa93"
let searchTxt: String = "Natures"

class FlickrBaseURL: NSObject {
    static var shared = FlickrBaseURL()
    
    func getphotos(com : @escaping ([FlickrPhoto])->()) {
        guard let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&format=json&nojsoncallback=1&text=\(searchTxt)&extras=url_o") else { return }
        
//        guard let url = URL(string:"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&format=json&nojsoncallback=1&text=Natures&per_page=20&extras=url_o") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                print(data)
                do {
                    let result = try JSONDecoder().decode(FlickrPhotoBase.self, from: data)
                    com(result.photos?.photo ?? [])
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}
