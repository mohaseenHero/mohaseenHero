//
//  FlickrPhotosVC.swift
//  FlickrLook
//
//  Created by Mohaseen TmmT on 17/07/21.
//

import UIKit
import SDWebImage

class FlickrPhotosVC: UICollectionViewController {
    // MARK: - Properties
    @IBOutlet var collectionsView: UICollectionView!
    
    let flickrPhotosVM:FlickrPhotosVM = FlickrPhotosVM()
    var popVC: FlickrDetailsVC = FlickrDetailsVC()
    
    private let reuseIdentifier = "FlickrPhotoCell"
    private let sectionInsets = UIEdgeInsets(top: 0.0, left: 5.0, bottom: 5.0, right: 2.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLocals()
    }
    
    func initLocals() {
        FlickrBaseURL.shared.getphotos { (photos) in
            print(photos)
            DispatchQueue.main.async { [self] in
                flickrPhotosVM.gallaryList = photos
                reloadCollectionsView()
            }
        }
    }
    
    func reloadCollectionsView() {
        collectionsView?.reloadData()
    }
    
}

extension FlickrPhotosVC: UIPopoverPresentationControllerDelegate {
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        let indexPath = IndexPath(row: flickrPhotosVM.selectedindex, section: 0)
        let cell = collectionsView.cellForItem(at: indexPath)
        cell?.layer.borderColor = .none
        cell?.layer.borderWidth = 4
        return true
    }
    
}

// MARK: - Collection View Flow Layout Delegate,  UICollectionViewDelegate, UICollectionViewDataSource
extension FlickrPhotosVC: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return flickrPhotosVM.gallaryList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flickrPhotosVM.gallaryList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FlickrPhotoCell
        cell.imgBtn?.tag = indexPath.row
        cell.imgBtn?.addTarget(self, action: #selector(showFlickrDetailsVCell(sender:)), for: .touchUpInside)
        let imgurl = flickrPhotosVM.gallaryList[indexPath.row].url_o ?? ""
        cell.imgView?.sd_setImage(with: URL(string: imgurl), placeholderImage: UIImage(named: ""))
        cell.imgView?.layer.cornerRadius = 4
        cell.layer.cornerRadius = 4
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionsView.cellForItem(at: indexPath)
        cell?.layer.borderColor = .none
        cell?.layer.borderWidth = 4
    }
    
    override func collectionView(_ collectionView: UICollectionView,willDisplay cell: UICollectionViewCell,forItemAt indexPath: IndexPath) {
        
        cell.alpha = 0
        cell.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.25) {
            cell.alpha = 1
            cell.transform = .identity
        }
    }
    
    func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 175, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 180, height: 160)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    @objc func showFlickrDetailsVCell(sender: UIButton) {
        flickrPhotosVM.selectedindex = sender.tag
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = collectionsView.cellForItem(at: indexPath)
        cell?.layer.borderColor = #colorLiteral(red: 0, green: 0.4890066385, blue: 0.8384625912, alpha: 1)
        cell?.layer.borderWidth = 4
        popVC = FlickrDetailsVC(nibName: "FlickrDetailsVC", bundle: nil)
        popVC.modalPresentationStyle = .popover
        
        let popOverVC = popVC.popoverPresentationController
        popVC.photoinfolist = flickrPhotosVM.gallaryList[sender.tag]
        popOverVC?.delegate = self
        popOverVC!.permittedArrowDirections = .up
        popOverVC?.sourceView = (sender as UIView)
        
        let padding: CGFloat =  50
        let collectionViewSize = collectionsView.frame.size.width - padding
        let ypo = collectionViewSize/2
        
        popOverVC?.sourceRect = CGRect(x:(sender as AnyObject).bounds.midX, y: ypo, width: 0, height: 0)
        popVC.preferredContentSize = CGSize(width: self.view.frame.width , height: collectionViewSize/2)
        self.present(popVC, animated: true)
    }
}
