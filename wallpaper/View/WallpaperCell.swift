//
//  WallpaperCell.swift
//  wallpaper
//
//  Created by satkis on 9/16/18.
//  Copyright © 2018 satkis. All rights reserved.
//

import UIKit
import Hero
import Alamofire
import AlamofireImage
import Firebase

class WallpaperCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageTitleLabel: UILabel!
    @IBOutlet weak var imageDetailsLabel: UILabel!
    @IBOutlet weak var imageStatusLabel: UILabel!
    @IBOutlet weak var imageID: UILabel!
    
    var wallpaper: Wallpaper!
    var request: Request?
    var imageUrlString: String?
    
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    

    
    func configureCell(wallpaper: Wallpaper, img: UIImage?) {
        self.wallpaper = wallpaper
        
        //imageView.image = UIImage(named: "\(self.wallpaper.wallpaperId)")
        imageTitleLabel.text = self.wallpaper.wallpaperName
        imageDetailsLabel.text = self.wallpaper.wallpaperDetails
        imageStatusLabel.text = self.wallpaper.wallpaperStatus
        imageView.hero.id = String(self.wallpaper.wallpaperId)
        imageID.text = String(self.wallpaper.wallpaperId)
       
        if wallpaper.wallpaperUrl != "" {
            imageUrlString = wallpaper.wallpaperUrl
            self.imageView.image = nil
            
            //if image is not nil, it means it's cached image which is passed. otherwise Alamofire request is needed to download img
            if img != nil {
                self.imageView.image = img
                
            } else {
                
                request = Alamofire.request(wallpaper.wallpaperUrl!, method: .get).validate(contentType: ["image/*"]).responseData(completionHandler: { (response) in
                    

                    
                    if let data = response.result.value {
                        
                        let image = UIImage(data: data)!
                        
                        if self.imageUrlString == wallpaper.wallpaperUrl {
                            self.imageView.image = image
                        }
                        
                        //add to cache if image was downloaded
                        ViewController.imageCache.setObject(image, forKey: self.wallpaper.wallpaperUrl as AnyObject)
                    } else {
                        print("ALAMOFIRE ERROR::: \(String(describing: response.result.error))")
                    }
                })
            }
        } else {
            self.imageView.isHidden = true
        
        }
        
    }
}
