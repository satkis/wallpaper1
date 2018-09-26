//
//  ViewController.swift
//  wallpaper
//
//  Created by satkis on 9/16/18.
//  Copyright © 2018 satkis. All rights reserved.
//

import UIKit
import Hero
import Photos
import PhotosUI
import Firebase


enum Vibration {
    case error
    case success
    case warning
    case light
    case medium
    case heavy
    case selection
    case oldSchool
    
    func vibrate() {
        
        switch self {
        case .error:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            
        case .success:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
        case .warning:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
            
        case .light:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            
        case .medium:
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            
        case .heavy:
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            
        case .selection:
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
            
        case .oldSchool:
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
        
    }
    
}


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var bgImage: UIImageView!
    
    
    var wallpapers = [Wallpaper]()

    static var imageCache = NSCache<AnyObject, AnyObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self

//        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, animations: {
//            self.collection.center.x = self.view.frame.width / 2
//        }, completion: nil)
        
        self.collection.decelerationRate = UIScrollViewDecelerationRateFast
        
        DataService.ds.URL_WALLPAPERS.observe(.value) { snapshot in
            print(snapshot.value as Any)
            self.wallpapers = []
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshots {
                    print("SNAP:::", snap)
                    
                    if let wallpaperDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let wallppr = Wallpaper(wallpaperKey: key, dictionary: wallpaperDict)
                        self.wallpapers.append(wallppr)
                    }
                }
            }
            
            self.collection.reloadData()
//            self.wallpapers = []
//
//            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
//                for snap in snapshots {
//                    print("SNAP:", snap)
//                    if let wallpaperDict = snap.value as? Dictionary<String, AnyObject> {
//                        //key is user/post ID
//                        let key = snap.key
//                        let wallpaperPost = Wallpaper(postKey: key, dictionary: wallpaperDict)
//                        self.wallpapers.append(wallpaperPost)
//                    }
//                }
//            }
//            self.collection.reloadData()
        }
        animateBgImage()
    }
    

    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WallpaperCell", for: indexPath) as? WallpaperCell {
//
////            let wall = Wallpaper(wallpaperName: "test", wallpaperId: indexPath.item, wallpaperDetails: "test test", wallpaperStatus: "Live")
//            let asset = photoList?.object(at: indexPath.row)
//            if (asset?.mediaSubtypes.contains(.photoLive))! {
//                let walppr = DataService.ds.getCategories()[indexPath.row]
//                //
//                UIImageView(cell.imageView) = PHLivePhotoView.livePhotoBadgeImage(options: .overContent)
//                //
//
//            }
//            let imageManager = PHImageManager()
//            imageManager.requestImage(for: asset!, targetSize: CGSize.init(width: 80, height: 80), contentMode: .aspectFill, options: nil) { image, _ in
//                cell.imageView = UIImageView(image)
//            }
//
//    }
//        return UICollectionViewCell()
//    }
    

            
            
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let wallpp = wallpapers[indexPath.row]
        print("cellforitematindexpath::::", wallpp.wallpaperDetails)
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WallpaperCell", for: indexPath) as? WallpaperCell {
//            cell.request?.cancel()
            //var image: UIImage?
            //let url = wallpp.wallpaperUrl
            //image = ViewController.imageCache.object(forKey: url as AnyObject) as? UIImage
            let wallpaperImage = wallpp.wallpaperUrl

            cell.imageView.loadImageUsingCacheWithUrlString(urlString: wallpaperImage)
            cell.configureCell(wallpaper: wallpp)
            
            //cell.configureCell(wallpaper: wallpp, img: image)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
        
//        return collectionView.dequeueReusableCell(withReuseIdentifier: "WallpaperCell", for: indexPath) as! WallpaperCell
//    }

    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WallpaperCell", for: indexPath) as? WallpaperCell {
//
//            //            let wall = Wallpaper(wallpaperName: "test", wallpaperId: indexPath.item, wallpaperDetails: "test test", wallpaperStatus: "Live")
//            let asset = photoList?.object(at: indexPath.row)
//
//
//
//
//
//            let walppr = DataService.ds.getCategories()[indexPath.row]
//            cell.configureCell(wallpaper: walppr)
//
//            return cell
//        } else {
//            return UICollectionViewCell()
//        }
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return DataService.ds.getCategories().count
        return wallpapers.count
    }
    

//
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let wallpppp = wallpapers[indexPath.row]
        print("selected cell item:::", indexPath.item)
        print("selected cell row:::", indexPath.row)

        DispatchQueue.main.async {
            
            let detailVCC = self.storyboard?.instantiateViewController(withIdentifier: "DetailVCC") as! DetailVC
           
//                detailVCC.imageNamee = DataService.ds.getCategories()[indexPath.row].wallpaperId
//                detailVCC.imageTitle = DataService.ds.getCategories()[indexPath.row].wallpaperName
//            if detailVCC.imageNamee != "" {
//                let wallppr = Wallpaper?.self
//             detailVCC.imageNamee = String(wallppr.)
//            }
            
            detailVCC.imageNamee = String(wallpppp.wallpaperId)
            detailVCC.imageTitle = wallpppp.wallpaperName
            detailVCC.videoLink = wallpppp.wallpaperVideoUrl
            
            
            detailVCC.hero.isEnabled = true

//            detailVCC.wallpaperImgLbl.image = UIImage(named: self.wallpaperr[indexPath.row].wallpaperId)
//            detailVCC.wallpaperTitleLbl.text = DataService.ds.getCategories()[indexPath.row].wallpaperName
            self.present(detailVCC, animated: true, completion: nil)

        }

    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let wallppr: Wallpaper!
//        print("selected cell item:::", indexPath.item)
//        print("selected cell row:::", indexPath.row)
//
//        wallppr = DataService.ds.getCategories()[indexPath.row]
//
//
//        print(wallppr.wallpaperName)
//        performSegue(withIdentifier: "WallpaperDetailVC", sender: wallppr)
//    }
    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(1)
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "WallpaperDetailVC" {
//            if let detailsVC = segue.destination as? DetailVC {
//                if let wallppr = sender as? Wallpaper {
//                    detailsVC.wallpaperInDetailVC = wallppr
//                }
//            }
//        }
//    }


    func animateBgImage() {
        UIView.animate(withDuration: 15, delay: 0, options: [.autoreverse, .curveLinear, .repeat], animations: {
            let x = self.bgImage.frame.width - self.view.frame.width
            self.bgImage.transform = CGAffineTransform(translationX: x, y: 0
            )}
    
        )}

}
