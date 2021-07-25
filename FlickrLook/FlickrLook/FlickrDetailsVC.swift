//
//  FlickrDetailsVCViewController.swift
//  FlickrLook
//
//  Created by Mohaseen TmmT on 23/07/21.
//

import UIKit

class FlickrDetailsVC: UIViewController {

    var photoinfolist: FlickrPhoto!
    
    @IBOutlet weak var photoid: UILabel!
    @IBOutlet weak var photoname: UILabel!
    @IBOutlet weak var photoinfo: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoid.text = "ImageId : \(photoinfolist.id ?? "")"
        photoname.text = "ownerId : \(photoinfolist.owner ?? "")"
        photoinfo.text = "Info : \(photoinfolist.title ?? "")"
    }



}
