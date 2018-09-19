//
//  ViewController.swift
//  wallpaper
//
//  Created by satkis on 9/16/18.
//  Copyright © 2018 satkis. All rights reserved.
//

import UIKit
import Hero

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collection: UICollectionView!

    var wallpaperr = [Wallpaper]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        
    }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WallpaperCell", for: indexPath) as? WallpaperCell {
            
//            let wall = Wallpaper(wallpaperName: "test", wallpaperId: indexPath.item, wallpaperDetails: "test test", wallpaperStatus: "Live")
            let walppr = DataService.ds.getCategories()[indexPath.row]
            cell.configureCell(wallpaper: walppr)
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataService.ds.getCategories().count
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let wallppr: Wallpaper!
        print("selected cell item:::", indexPath.item)
        print("selected cell row:::", indexPath.row)

        DispatchQueue.main.async {
            let detailVCC = self.storyboard?.instantiateViewController(withIdentifier: "DetailVCC") as! DetailVC
            
                detailVCC.imageNamee = DataService.ds.getCategories()[indexPath.row].wallpaperId
                detailVCC.imageTitle = DataService.ds.getCategories()[indexPath.row].wallpaperName
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


}

