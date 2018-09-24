import UIKit
import Hero
import PhotosUI
import Photos
import MobileCoreServices

class DetailVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHLivePhotoViewDelegate{
    
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
    
    @IBOutlet weak fileprivate var livePhotoView: PHLivePhotoView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hero.isEnabled = true
        livePhotoView.contentMode = UIViewContentMode.scaleAspectFit
        livePhotoView.delegate = self
        //        wallpaperTitleLbl.text = wallpaperInDetailVC.wallpaperName
        wallpaperTitleLbl.text = self.imageTitle
        //        wallpaperImgLbl.image = UIImage(named: wallpaperInDetailVC.wallpaperId)
        wallpaperImgLbl.image = UIImage(named: self.imageNamee)
        wallpaperImgLbl.hero.id = self.imageNamee
        
        applyMotionEffect(toView: wallpaperImgLbl, magnitude: 20)
        
        self.settingsExpandLbl.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        closeMenu()
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        dismiss(animated: true, completion: nil)
        
        print("\(info)")
        
        if let livePhoto = info[UIImagePickerControllerLivePhoto] as? PHLivePhoto {
            livePhotoView.livePhoto = livePhoto
            livePhotoView.startPlayback(with: .full)
        } else {
            let alert = UIAlertController(
                title: "Failed",
                message: "This is not a Live Photo.",
                preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(
                title: "OK",
                style: UIAlertActionStyle.cancel,
                handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func livePhotoView(_ livePhotoView: PHLivePhotoView, didEndPlaybackWith playbackStyle: PHLivePhotoViewPlaybackStyle) {
        livePhotoView.startPlayback(with: .full)
    }
    
    // =========================================================================
    // MARK: - Actions
    
    @IBAction func pickerBtnTapped(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.mediaTypes = [kUTTypeImage as String, kUTTypeLivePhoto as String]
        
        present(picker, animated: true, completion: nil)
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
