//
//  ViewController.swift
//  FlickrLook
//
//  Created by Mohaseen TmmT on 17/07/21.
//

import UIKit

final class FlickrPhotosViewController: UICollectionViewController {
  // MARK: - Properties
  private let reuseIdentifier = "FlickrCell"
  private let sectionInsets = UIEdgeInsets(top: 0.0, left: 5.0, bottom: 5.0, right: 2.0)
  private var searches: [FlickrSearchResults] = []
  private let flickr = Flickr()
  private let itemsPerRow: CGFloat = 2
}

// MARK: - Private
private extension FlickrPhotosViewController {
  func photo(for indexPath: IndexPath) -> FlickrPhoto {
    return searches[indexPath.section].searchResults[indexPath.row]
  }
}

// MARK: - Text Field Delegate
extension FlickrPhotosViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    guard
      let text = textField.text,
      !text.isEmpty
    else { return true }

    // 1
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    textField.addSubview(activityIndicator)
    activityIndicator.frame = textField.bounds
    activityIndicator.startAnimating()

    flickr.searchFlickr(for: text) { searchResults in
      DispatchQueue.main.async {
        activityIndicator.removeFromSuperview()

        switch searchResults {
        case .failure(let error) :
          // 2
          print("Error Searching: \(error)")
        case .success(let results):
          // 3
          print("""
            Found \(results.searchResults.count) \
            matching \(results.searchTerm)
            """)
          self.searches.insert(results, at: 0)
          // 4
          self.collectionView?.reloadData()
        }
      }
    }

    textField.text = nil
    textField.resignFirstResponder()
    return true
  }
}

// MARK: - UICollectionViewDataSource
extension FlickrPhotosViewController {
  // 1
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return searches.count
  }

  // 2
  override func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return searches[section].searchResults.count
  }
    
    

  // 3
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    // 1
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: reuseIdentifier,
      for: indexPath
    ) as! FlickrPhotoCell
    // swiftlint:disable:previous force_cast

    // 2
    let flickrPhoto = photo(for: indexPath)
    
    // 3
    cell.imgView.image = flickrPhoto.thumbnail
    return cell
  }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("HIIIII")
        if let cell = collectionView.cellForItem(at: indexPath) as? FlickrPhotoCell {
            cell.backgroundColor = .systemBlue
            
            let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style {
                case .default:
                    print("default")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                }
            }))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("Hello")
        if let cell = collectionView.cellForItem(at: indexPath) as? FlickrPhotoCell {
            cell.backgroundColor = .none
        }
    }
}

// MARK: - Collection View Flow Layout Delegate
extension FlickrPhotosViewController: UICollectionViewDelegateFlowLayout {
    // 1
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        // 2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 2)
        let availableWidth = view.frame.width + paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        //
        //    return CGSize(width: widthPerItem, height: widthPerItem)
        let size = CGSize(width: 355/2, height: widthPerItem)
        return size
    }
    
    // 3
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return sectionInsets.left
    }
}

