import UIKit
import Hero
import PhotosUI
import Photos
import MobileCoreServices



class DetailVC: UIViewController, PHLivePhotoViewDelegate{
    
    //    var wallpaperInDetailVC: Wallpaper!
    var imageNamee: String!
    var imageTitle: String!
    var videoLink: String!
    
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
    @IBOutlet weak var clockStackLbl: UIStackView!
    
    //@IBOutlet weak fileprivate var livePhotoView: PHLivePhotoView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        buttonsAppear()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hero.isEnabled = true
        setupLayout()
        self.clockStackLbl.alpha = 0

        
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
            if progress + sender.velocity(in: nil).y / view.bounds.height > 5 ||
                progress + sender.velocity(in: nil).x / view.bounds.height > 5 ||
                progress + sender.velocity(in: nil).y / view.bounds.height < 5 ||
                progress + sender.velocity(in: nil).x / view.bounds.height < 5 {
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
                Vibration.selection.vibrate()
                self.closeMenu()
            } else {
                Vibration.light.vibrate()
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
    
//    func animateClock() {
//        UIView.animate(withDuration: 1.0, animations: {
//            self.clockStackLbl.alpha = 1
//        }, completion: {(Completion : Bool) -> Void in
//            UIView.animate(withDuration: 1.0, delay: 3.0, options: UIViewAnimationOptions.curveLinear, animations: {
//                self.clockStackLbl.alpha = 0
//            }, completion: nil)
//        })
//    }
    


    
    
    @IBAction func storyBttnTapped(_ sender: Any) {
        Vibration.light.vibrate()
    }
    
    @IBAction func shareBttnTapped(_ sender: Any) {
        Vibration.light.vibrate()
    }
    
    @IBAction func smthElseBttnTapped(_ sender: Any) {
        Vibration.light.vibrate()
    }
    
    @IBAction func appsBttnTapped(_ sender: Any) {
        Vibration.light.vibrate()
    }
    
    func animateClock() {
        
        
    }
    
    @IBAction func clockBttnTapped(_ sender: Any) {
        if self.clockStackLbl.alpha == CGFloat(0) {
            UIView.animate(withDuration: 0.3) {
                self.clockStackLbl.alpha = 1
                self.clockLbl.tintColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
                Vibration.light.vibrate()
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.clockStackLbl.alpha = 0
                self.clockLbl.tintColor = #colorLiteral(red: 0.8000000119, green: 0.8000000119, blue: 0.8000000119, alpha: 1)
            }
        }
    }

    

    
    @IBAction func likeBttnTapped(_ sender: Any) {
        Vibration.selection.vibrate()
    }
    
    @IBAction func saveBttnTapped(_ sender: Any) {
        Vibration.success.vibrate()
    }
    
    
    
    private func buttonsAppear() {
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 10, animations: {
            self.settingsLbl.center.x = 40
            self.saveLbl.center.y = self.view.frame.height - 60
            self.appsLbl.center.x = self.view.frame.width - 40
        })
        
        UIView.animate(withDuration: 1.0, delay: 0.10, usingSpringWithDamping: 1.0, initialSpringVelocity: 10, animations: {
            self.clockLbl.center.x = self.view.frame.width - 40
        })
        
        UIView.animate(withDuration: 1.0, delay: 0.20, usingSpringWithDamping: 1.0, initialSpringVelocity: 10, animations: {
            self.likeLbl.center.x = self.view.frame.width - 40
        })
        
        
    }
    
    private func setupLayout() {
        settingsLbl.translatesAutoresizingMaskIntoConstraints = false
        saveLbl.translatesAutoresizingMaskIntoConstraints = false
        appsLbl.translatesAutoresizingMaskIntoConstraints = false
        clockLbl.translatesAutoresizingMaskIntoConstraints = false
        likeLbl.translatesAutoresizingMaskIntoConstraints = false
        
        settingsLbl.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: -55).isActive = true
        settingsLbl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30).isActive = true
        
        saveLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        saveLbl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 60).isActive = true
        
        appsLbl.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 55).isActive = true
        appsLbl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30).isActive = true
        
        clockLbl.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 55).isActive = true
        clockLbl.bottomAnchor.constraint(equalTo: appsLbl.topAnchor, constant: -30).isActive = true
        
        likeLbl.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 55).isActive = true
        likeLbl.bottomAnchor.constraint(equalTo: clockLbl.topAnchor, constant: -30).isActive = true
    }
        

    
    
    
}
