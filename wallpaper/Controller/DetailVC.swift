//
//  DetailVC.swift
//  wallpaper
//
//  Created by satkis on 9/19/18.
//  Copyright © 2018 satkis. All rights reserved.
//

import UIKit
import Hero
import PhotosUI
import Photos
import MobileCoreServices

class DetailVC: UIViewController {
    
//    var wallpaperInDetailVC: Wallpaper!
    var imageNamee: String!
    var imageTitle: String!
    
    @IBOutlet weak var wallpaperTitleLbl: UILabel!
    @IBOutlet weak var wallpaperImgLbl: UIImageView!
    
    @IBOutlet weak var settingsLbl: UIButton!
    @IBOutlet weak var storyLbl: UIButton!
    @IBOutlet weak var shareLbl: UIButton!
    @IBOutlet weak var saveLbl: UIButton!
    @IBOutlet weak var clockLbl: UIButton!
    @IBOutlet weak var appsLbl: UIButton!
    @IBOutlet weak var likeLbl: UIButton!
    @IBOutlet weak var smthElseLbl: UIButton!
    @IBOutlet weak var settingsExpandLbl: UIViewX!
    
//    @IBOutlet weak var livePhotoView: PHLivePhotoView! {
//        didSet {
//            loadVideoWithVideoURL(Bundle.main.url(forResource: "video", withExtension: "m4v")!)
//        }
//    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hero.isEnabled = true
        
//        wallpaperTitleLbl.text = wallpaperInDetailVC.wallpaperName
        wallpaperTitleLbl.text = self.imageTitle
//        wallpaperImgLbl.image = UIImage(named: wallpaperInDetailVC.wallpaperId)
        wallpaperImgLbl.image = UIImage(named: self.imageNamee)
        wallpaperImgLbl.hero.id = self.imageNamee
        
        applyMotionEffect(toView: wallpaperImgLbl, magnitude: 20)
        
        self.settingsExpandLbl.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        closeMenu()
    }
    
    func applyMotionEffect (toView view:UIView, magnitude: Float) {
        let xMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        xMotion.minimumRelativeValue = -magnitude
        xMotion.maximumRelativeValue = magnitude
        
        let yMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        yMotion.minimumRelativeValue = -magnitude
        yMotion.maximumRelativeValue = magnitude
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [xMotion, yMotion]
        view.addMotionEffect(group)
        
    }
    

 
    @IBAction func panPanPan(_ sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .began:
            hero.dismissViewController()
        case .changed:
            let transaltion = sender.translation(in: nil)
            let progress = transaltion.y / 2 / view.bounds.height
            Hero.shared.update(progress)
            
        let currentPos = CGPoint(x: transaltion.x + wallpaperImgLbl.center.x, y: transaltion.y + wallpaperImgLbl.center.y)
            Hero.shared.apply(modifiers: [.position(currentPos)], to: wallpaperImgLbl)
        default:
            let transaltion = sender.translation(in: nil)
            let progress = transaltion.y / 2 / view.bounds.height
            if progress + sender.velocity(in: nil).y / view.bounds.height > 0.2 ||
                progress + sender.velocity(in: nil).x / view.bounds.height > 0.2 ||
                progress + sender.velocity(in: nil).y / view.bounds.height < 0.2 ||
                progress + sender.velocity(in: nil).x / view.bounds.height < 0.2 {
                Hero.shared.finish()
            } else {
                Hero.shared.cancel()
            }
            
        }
        
    }

 
    @IBAction func settingsBttnTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            if self.settingsExpandLbl.transform == .identity {
                //opened
                self.closeMenu()
            } else {
                //closed
                self.settingsExpandLbl.transform = .identity
            }
        })
        
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.3, initialSpringVelocity: 10, options: [], animations: {
            if self.settingsExpandLbl.transform == .identity {
            
            self.shareLbl.transform = .identity
                self.smthElseLbl.transform = .identity
                self.storyLbl.transform = .identity
            }
        })
    }
    
    func closeMenu() {
        settingsExpandLbl.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        shareLbl.transform = CGAffineTransform(translationX: 0, y: 14)
        smthElseLbl.transform = CGAffineTransform(translationX: 0, y: 40)
        storyLbl.transform = CGAffineTransform(translationX: 0, y: 24)
    }
    
    
    @IBAction func storyBttnTapped(_ sender: Any) {
    }
    
    @IBAction func shareBttnTapped(_ sender: Any) {
    }
    
    @IBAction func smthElseBttnTapped(_ sender: Any) {
    }
    
    @IBAction func appsBttnTapped(_ sender: Any) {
    }
    
    @IBAction func clockBttnTapped(_ sender: Any) {
    }
    
    @IBAction func likeBttnTapped(_ sender: Any) {
    }
    
    @IBAction func saveBttnTapped(_ sender: Any) {
    }
    

    
    
}
