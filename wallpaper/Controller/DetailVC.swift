//
//  DetailVC.swift
//  wallpaper
//
//  Created by satkis on 9/19/18.
//  Copyright © 2018 satkis. All rights reserved.
//

import UIKit
import Hero

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hero.isEnabled = true
        
//        wallpaperTitleLbl.text = wallpaperInDetailVC.wallpaperName
        wallpaperTitleLbl.text = self.imageTitle
//        wallpaperImgLbl.image = UIImage(named: wallpaperInDetailVC.wallpaperId)
        wallpaperImgLbl.image = UIImage(named: self.imageNamee)
        wallpaperImgLbl.hero.id = self.imageNamee
        
        applyMotionEffect(toView: wallpaperImgLbl, magnitude: 20)
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
        if self.settingsLbl.transform == .identity {
            //opened
        } else {
            //closed
        }
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