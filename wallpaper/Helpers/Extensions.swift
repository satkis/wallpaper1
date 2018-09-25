//
//  Extensions.swift
//  wallpaper
//
//  Created by satkis on 9/25/18.
//  Copyright © 2018 satkis. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(urlString: String) {
        //this one puts image in correct collectionCell
        self.image = nil
        
        //check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
            
        }
        //otherwise start a new download
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("error:::", error as Any)
                return
                
            }
            DispatchQueue.main.async {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    self.image = downloadedImage
                }
  
                
            }
            
            }.resume()
    }
}
