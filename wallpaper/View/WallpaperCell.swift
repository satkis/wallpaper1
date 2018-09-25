//
//  WallpaperCell.swift
//  wallpaper
//
//  Created by satkis on 9/16/18.
//  Copyright © 2018 satkis. All rights reserved.
//

import UIKit
import Hero
//import Alamofire
//import AlamofireImage
import Firebase

class WallpaperCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageTitleLabel: UILabel!
    @IBOutlet weak var imageDetailsLabel: UILabel!
    @IBOutlet weak var imageStatusLabel: UILabel!
    @IBOutlet weak var imageID: UILabel!
    
    var wallpaper: Wallpaper!
    //var request: Request?
    var imageUrlString: String?
    
    
    var imageReference: StorageReference {
    return Storage.storage().reference().child("images")
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    

    
//    func configureCell(wallpaper: Wallpaper, img: UIImage?) {
    func configureCell(wallpaper: Wallpaper) {
        self.wallpaper = wallpaper
        
//        imageView.image = UIImage(named: "\(self.wallpaper.wallpaperName)")
        imageTitleLabel.text = self.wallpaper.wallpaperName
        imageDetailsLabel.text = self.wallpaper.wallpaperDetails
        imageStatusLabel.text = self.wallpaper.wallpaperStatus
        imageView.hero.id = String(self.wallpaper.wallpaperId)
        imageID.text = String(self.wallpaper.wallpaperId)
  
    
    }



}


