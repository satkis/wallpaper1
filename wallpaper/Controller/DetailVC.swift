import UIKit
import Hero
import PhotosUI
import Photos
import MobileCoreServices


class DetailVC: UIViewController, PHLivePhotoViewDelegate{

    var imageNamee: String!
    var imageTitle: String!
    var videoLink: String!
    var effect: UIVisualEffect!

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
    @IBOutlet weak var savedBlurLbl: UIVisualEffectViewX!
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
        effect = savedBlurLbl.effect
        savedBlurLbl.effect = nil
        wallpaperTitleLbl.text = self.imageTitle
        wallpaperImgLbl.image = UIImage(named: self.imageNamee)
        wallpaperImgLbl.hero.id = self.imageNamee
        applyMotionEffect(toView: wallpaperImgLbl, magnitude: 20)
        self.settingsExpandLbl.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        closeMenu()
        savedBlurLbl.alpha = 0
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
    
    func closeMenu() {
        settingsExpandLbl.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        shareLbl.transform = CGAffineTransform(translationX: 0, y: 14)
        smthElseLbl.transform = CGAffineTransform(translationX: 0, y: 40)
        storyLbl.transform = CGAffineTransform(translationX: 0, y: 24)
    }
    
    
    fileprivate func saveImagetoDevice() {
        DispatchQueue.main.async {
            //Encode
            let imageData = UIImagePNGRepresentation(self.wallpaperImgLbl.image!)! as NSData
            //save img
            UserDefaults.standard.set(imageData, forKey: "savedImg")
            //Decode
            let data = UserDefaults.standard.object(forKey: "savedImg") as! NSData
            let compressedImage = UIImage(data: data as Data)
            UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
            Vibration.success.vibrate()
            self.savedLbl()
        }
    }
    
    func savedLbl() {
        UIView.animate(withDuration: 1.0, animations: {
            self.savedBlurLbl.effect = self.effect
            self.savedBlurLbl.alpha = 1
        }, completion: {
            (Completed : Bool) -> Void in
            UIView.animate(withDuration: 1.0, delay: 1.0, options: UIViewAnimationOptions.curveLinear, animations: {
                self.savedBlurLbl.effect = nil
                self.savedBlurLbl.alpha = 0
            })
        })
    }
    
    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
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
        PHPhotoLibrary.requestAuthorization { (status) in
            
            switch status {
            case .notDetermined:
                if status == PHAuthorizationStatus.authorized {
                    self.saveImagetoDevice()
                }
            case .restricted:
                self.showErrorAlert(title: "Photo Library access restricted", msg:"Photo Library cannot be accessed.")
            case .denied:
                let alert = UIAlertController(title: "Photo Library access was previously denied", message: "Change your Settings.", preferredStyle: .alert)
                let goToSettings = UIAlertAction(title: "Go to Settings", style: .default) { (action) in
                    DispatchQueue.main.async {
                        let url = URL(string: UIApplicationOpenSettingsURLString)!
                        UIApplication.shared.open(url, options: [:])
                    }
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                alert.addAction(goToSettings)
                alert.addAction(cancelAction)
                self.present(alert, animated: true)
            case .authorized:
                self.saveImagetoDevice()
            }
        }
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
