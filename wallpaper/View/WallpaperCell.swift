//
//  WallpaperCell.swift
//  wallpaper
//
//  Created by satkis on 9/16/18.
//  Copyright © 2018 satkis. All rights reserved.
//

import UIKit
import Hero
import Firebase

class WallpaperCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageTitleLabel: UILabel!
    @IBOutlet weak var imageDetailsLabel: UILabel!
    @IBOutlet weak var imageStatusLabel: UILabel!
    @IBOutlet weak var imageID: UILabel!
    
    @IBOutlet weak var imageCoverView: UIView!
    @IBOutlet weak var bgContainer: UIView!
    
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
    
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        let featuredHeight = FeedLayoutConstants.Cell.featureHeight
        let standardHeight = FeedLayoutConstants.Cell.standardHeight
        let delta = 1 - (featuredHeight - self.frame.size.height) / (featuredHeight - standardHeight)
        
        let minAlpha: CGFloat = 0.0
        let maxAlpha: CGFloat = 0.65
        
        imageCoverView.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
        
        let scale = max(delta, 0.5)
        imageTitleLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
        
        imageStatusLabel.alpha = delta
        imageDetailsLabel.alpha = delta
    }
    
    
    func animationWhileImgLoading() {
        
        bgContainer.backgroundColor = UIColor(white: 1, alpha: 0.1)
        let darkItem = UILabel()
        darkItem.backgroundColor = UIColor(white: 1, alpha: 0.5)
        darkItem.frame = CGRect(x: 0, y: 0, width: 500, height: 800)
        bgContainer.addSubview(darkItem)
        bgContainer.sendSubview(toBack: darkItem)
        
        let shinyItem = UILabel()
        shinyItem.backgroundColor = UIColor.white
        shinyItem.frame = CGRect(x: -150, y: 0, width: 500, height: 200)
        bgContainer.addSubview(shinyItem)
        bgContainer.sendSubview(toBack: shinyItem)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.frame = shinyItem.frame
        
        let angle = 135 * CGFloat.pi / 180
        gradientLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
        
        shinyItem.layer.mask = gradientLayer
        
        //animation
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.speed = 0.15
        
        animation.fromValue = -bgContainer.frame.width
        animation.toValue = bgContainer.frame.width+250
        animation.repeatCount = Float.infinity
        
        gradientLayer.add(animation, forKey: "doesntmatter")
        
    }



}


