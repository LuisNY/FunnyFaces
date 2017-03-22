//
//  ViewController.swift
//  Module4
//
//  Created by Luigi Pepe on 12/28/16.
//  Copyright © 2016 Luigi Pepe. All rights reserved.
//

import UIKit
import FaceTracker

class ViewController: UIViewController, FaceTrackerViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var filterOptionsView: UIStackView!
    @IBOutlet var hatOptionsView: UIView!
    @IBOutlet var eyesOptionsView: UIView!
    @IBOutlet var noseOptionsView: UIView!
    @IBOutlet var lipsOptionsView: UIView!
    @IBOutlet var bigPicView: UIView!
    @IBOutlet weak var bigPicImageView: UIImageView!
    
    
    
    @IBOutlet weak var cowboyHatOutlet: UIButton!
    @IBOutlet weak var clownWigOutlet: UIButton!
    @IBOutlet weak var santaHatOutlet: UIButton!
    @IBOutlet weak var noneHatOutlet: UIButton!
    @IBOutlet weak var blueEyesOutlet: UIButton!
    @IBOutlet weak var greenEyesOutlet: UIButton!
    @IBOutlet weak var sunglassesOutlet: UIButton!
    @IBOutlet weak var noneEyesOutlet: UIButton!
    @IBOutlet weak var clownNoseOutlet: UIButton!
    @IBOutlet weak var pigNoseOutlet: UIButton!
    @IBOutlet weak var dogNoseOutlet: UIButton!
    @IBOutlet weak var noneNoseOutlet: UIButton!
    @IBOutlet weak var redLipsOutlet: UIButton!
    @IBOutlet weak var laughingLipsOutlet: UIButton!
    @IBOutlet weak var tongueOutOutlet: UIButton!
    @IBOutlet weak var noneLipsOutlet: UIButton!
    
    var screenShot: UIImage?
    
    var sunglassesView = UIImageView()
    
    var lipsView = UIImageView()
    var tongueOutView = UIImageView()
    
    var leftEyeView = UIImageView()
    var rightEyeView = UIImageView()
    
    var noseView = UIImageView()
    var dogNoseView = UIImageView()
    
    
    var cowboyHatView = UIImageView()
    var clownHairView = UIImageView()
    var santaHatView = UIImageView()
    var faceTrackerViewController: FaceTrackerViewController?
    var overlayViews = [String: [UIView]]()
    
    
    var shotTakenView = UIImageView()
    
    
    var imageName: String?
    @IBOutlet weak var faceTrackerContainerView: UIView!
    
    var santaHatWidth: CGFloat?
    var santaHatHeight: CGFloat?
    var eyeCornerDist: CGFloat?
    var eyeToEyeCenter: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Options", style: .plain, target: self, action: #selector(self.optionButtonPressed))
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hideAllOptions))
        self.view.addGestureRecognizer(tap)
        
        self.cowboyHatView.image = UIImage(named: "cowboyHat")
        self.clownHairView.image = UIImage(named: "clownHair")
        
        self.lipsView.image = UIImage(named: "laughingLips")
        self.leftEyeView.image = UIImage(named: "blueEye")
        self.rightEyeView.image = UIImage(named: "blueEye")
        self.sunglassesView.image = UIImage(named: "sunglasses1")
        self.noseView.image = UIImage(named: "redNose")
        self.shotTakenView.image = UIImage(named: "cameraBig")
        self.tongueOutView.image = UIImage(named: "tongueOut")
        self.dogNoseView.image = UIImage(named: "dogNose")
        self.santaHatView.image = UIImage(named: "santaHat")
        
        self.hatOptionsView.translatesAutoresizingMaskIntoConstraints = false
        self.eyesOptionsView.translatesAutoresizingMaskIntoConstraints = false
        self.noseOptionsView.translatesAutoresizingMaskIntoConstraints = false
        self.lipsOptionsView.translatesAutoresizingMaskIntoConstraints = false
        self.shotTakenView.translatesAutoresizingMaskIntoConstraints = false
        self.bigPicView.translatesAutoresizingMaskIntoConstraints = false
        
        self.noneHatOutlet.setTitleColor(UIColor.red, for: .normal)
        self.noneEyesOutlet.setTitleColor(UIColor.red, for: .normal)
        self.noneNoseOutlet.setTitleColor(UIColor.red, for: .normal)
        self.noneLipsOutlet.setTitleColor(UIColor.red, for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        faceTrackerViewController!.startTracking { () -> Void in
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "faceTracker") {
            faceTrackerViewController = segue.destination as? FaceTrackerViewController
            faceTrackerViewController!.delegate = self
        }
    }
    
    
       
    
    func optionButtonPressed() {
        
        let alert = UIAlertController()
        
        alert.addAction(UIAlertAction(title: "Swap Camera", style: .default, handler: { (action) -> Void in
            self.faceTrackerViewController!.swapCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
    func faceTrackerDidUpdate(_ points: FacePoints?) {
        
        if let points = points {
            
            
            for (index, point) in points.leftEye.enumerated() {
                
                self.updateViewForFeature(feature: "leftEye", index: index, point: point, bgColor: UIColor.blue)
            }
            
            for (index, point) in points.rightEye.enumerated() {
                
                self.updateViewForFeature(feature: "rightEye", index: index, point: point, bgColor: UIColor.red)
            }
            
            for (index, point) in points.leftBrow.enumerated() {
                
                self.updateViewForFeature(feature: "leftBrow", index: index, point: point, bgColor: UIColor.green)
            }
            
            for (index, point) in points.rightBrow.enumerated() {
                
                self.updateViewForFeature(feature: "rightBrow", index: index, point: point, bgColor: UIColor.cyan)
            }
            
            for (index, point) in points.nose.enumerated() {
                
                self.updateViewForFeature(feature: "nose", index: index, point: point, bgColor: UIColor.yellow)
            }
            
            for (index, point) in points.innerMouth.enumerated() {
                
                self.updateViewForFeature(feature: "innerMouth", index: index, point: point, bgColor: UIColor.magenta)
            }
            
            for (index, point) in points.outerMouth.enumerated() {
                
                self.updateViewForFeature(feature: "outerMouth", index: index, point: point, bgColor: UIColor.orange)
            }
            
            
            
            
            
            self.eyeCornerDist = sqrt(pow(points.leftEye[0].x - points.rightEye[5].x, 2) + pow(points.leftEye[0].y - points.rightEye[5].y, 2))
            self.eyeToEyeCenter = CGPoint(x: (points.leftEye[0].x + points.rightEye[5].x) / 2, y: (points.leftEye[0].y + points.rightEye[5].y) / 2)
            
            let hatWidth = 2.0 * eyeCornerDist!
            let hatHeight = (self.cowboyHatView.image!.size.height / self.cowboyHatView.image!.size.width) * 1.1 * hatWidth
            
            self.cowboyHatView.transform = CGAffineTransform.identity
            
            self.cowboyHatView.frame = CGRect(x: eyeToEyeCenter!.x - hatWidth / 2, y: eyeToEyeCenter!.y - 1.3 * hatHeight, width: hatWidth, height: hatHeight)
            self.cowboyHatView.isHidden = false
            
            setAnchorPoint(CGPoint(x: 0.5, y: 1.0), forView: self.cowboyHatView)
            
            var angle = atan2(points.rightEye[5].y - points.leftEye[0].y, points.rightEye[5].x - points.leftEye[0].x)
            self.cowboyHatView.transform = CGAffineTransform(rotationAngle: angle)
            
            
            
            
            self.santaHatWidth = 2 * eyeCornerDist!
            self.santaHatHeight = (self.santaHatView.image!.size.height / self.santaHatView.image!.size.width) * 0.8 * santaHatWidth!
            
            self.santaHatView.transform = CGAffineTransform.identity
            
            self.santaHatView.frame = CGRect(x: eyeToEyeCenter!.x - 1.1 * santaHatWidth! / 2, y: eyeToEyeCenter!.y - 1.2 * santaHatHeight!, width: santaHatWidth!, height: santaHatHeight!)
            self.santaHatView.isHidden = false
            
            setAnchorPoint(CGPoint(x: 0.5, y: 1.0), forView: self.santaHatView)
            
            self.santaHatView.transform = CGAffineTransform(rotationAngle: angle)
            
            
            
          
            
            let clownHairWidth = 3 * eyeCornerDist!
            let clownHairHeight = (self.clownHairView.image!.size.height / self.clownHairView.image!.size.width) * clownHairWidth
            
            clownHairView.transform = CGAffineTransform.identity
            
            clownHairView.frame = CGRect(x: eyeToEyeCenter!.x - clownHairWidth / 2, y: eyeToEyeCenter!.y - 1.0 * clownHairHeight, width: clownHairWidth, height: clownHairHeight)
            clownHairView.isHidden = false
            
            setAnchorPoint(CGPoint(x: 0.5, y: 1.0), forView: clownHairView)
            
            clownHairView.transform = CGAffineTransform(rotationAngle: angle)
            
            
            
            
            
            
            
            
            
            
            
            let sunglassesWidth = 1.4 * eyeCornerDist!
            let sunglassesHeight = (self.cowboyHatView.image!.size.height / self.cowboyHatView.image!.size.width) * (0.6 * sunglassesWidth)
            
            sunglassesView.transform = CGAffineTransform.identity
            
            sunglassesView.frame = CGRect(x: eyeToEyeCenter!.x - sunglassesWidth / 2, y: eyeToEyeCenter!.y - 0.5 * sunglassesHeight, width: sunglassesWidth, height: sunglassesHeight)
            sunglassesView.isHidden = false
            
            setAnchorPoint(CGPoint(x: 0.5, y: 1.0), forView: self.cowboyHatView)
            
            angle = atan2(points.rightEye[5].y - points.leftEye[0].y, points.rightEye[5].x - points.leftEye[0].x)
            sunglassesView.transform = CGAffineTransform(rotationAngle: angle)
            
            
            
            
            let mouthWidth = sqrt(pow(points.outerMouth[0].x - points.outerMouth[6].x, 2) + pow(points.outerMouth[0].y - points.outerMouth[6].y, 2))
            let mouthCenter = CGPoint(x: (points.outerMouth[0].x + points.outerMouth[6].x) / 2, y: (points.outerMouth[0].y + points.outerMouth[6].y) / 2)
            
            let newLipsWidth = 1.7 * mouthWidth
            let newLipsHeight = (self.lipsView.image!.size.height / self.lipsView.image!.size.width) * 1.7 * newLipsWidth
            
            lipsView.transform = CGAffineTransform.identity
            lipsView.frame = CGRect(x: mouthCenter.x - newLipsWidth / 2, y: mouthCenter.y - 0.5 * newLipsHeight, width: newLipsWidth, height: newLipsHeight)
            lipsView.isHidden = false
            
            setAnchorPoint(CGPoint(x: 0.5, y: 1.0), forView: lipsView)
            
            angle = atan2(points.outerMouth[6].y - points.outerMouth[0].y, points.outerMouth[6].x - points.outerMouth[0].x)
            lipsView.transform = CGAffineTransform(rotationAngle: angle)
            
            
            
            let innerMouthWidth = sqrt(pow(points.outerMouth[0].x - points.outerMouth[6].x, 2) + pow(points.outerMouth[0].y - points.outerMouth[6].y, 2))
            let innerMouthCenter = CGPoint(x: (points.outerMouth[0].x + points.outerMouth[6].x) / 2, y: (points.outerMouth[0].y + points.outerMouth[6].y) / 2)
            
            let innerMouthLipsWidth =  1.3 * innerMouthWidth
            let innerMouthLipsHeight = (self.tongueOutView.image!.size.height / self.tongueOutView.image!.size.width) * innerMouthLipsWidth
            
            tongueOutView.transform = CGAffineTransform.identity
            tongueOutView.frame = CGRect(x: innerMouthCenter.x - innerMouthLipsWidth/2, y: innerMouthCenter.y - innerMouthLipsHeight/5, width: innerMouthLipsWidth, height: innerMouthLipsHeight)
            tongueOutView.isHidden = false
            
            setAnchorPoint(CGPoint(x: 0.5, y: 1.0), forView: tongueOutView)
            
            angle = atan2(points.outerMouth[6].y - points.outerMouth[0].y, points.outerMouth[6].x - points.outerMouth[0].x)
            tongueOutView.transform = CGAffineTransform(rotationAngle: angle)
            
            
            
            
            
            
            
            
            
            
            
            let leftEyeCornerDist = sqrt(pow(points.leftEye[0].x - points.leftEye[5].x, 2) + pow(points.leftEye[0].y - points.leftEye[5].y, 2))
            let leftEyeCenter = CGPoint(x: (points.leftEye[0].x + points.leftEye[5].x) / 2, y: (points.leftEye[0].y + points.leftEye[5].y) / 2)
            
            
            
            let leftEyeWidth = 1.2 * leftEyeCornerDist
            let leftEyeHeight = (self.leftEyeView.image!.size.height / self.leftEyeView.image!.size.width) * leftEyeWidth
            
            
            leftEyeView.transform = CGAffineTransform.identity
            leftEyeView.frame = CGRect(x: leftEyeCenter.x - leftEyeWidth / 2, y: leftEyeCenter.y - 0.6 * leftEyeHeight, width: leftEyeWidth, height: leftEyeHeight)
            leftEyeView.isHidden = false

            
            setAnchorPoint(CGPoint(x: 0.5, y: 1.0), forView: leftEyeView)
            
            angle = atan2(points.leftEye[5].y - points.leftEye[0].y, points.leftEye[5].x - points.leftEye[0].x)
            leftEyeView.transform = CGAffineTransform(rotationAngle: angle)
            
            
            
            
            let rightEyeCornerDist = sqrt(pow(points.rightEye[0].x - points.rightEye[5].x, 2) + pow(points.rightEye[0].y - points.rightEye[5].y, 2))
            let rightEyeCenter = CGPoint(x: (points.rightEye[0].x + points.rightEye[5].x) / 2, y: (points.rightEye[0].y + points.rightEye[5].y) / 2)
            
            let rightEyeWidth = 1.2 * rightEyeCornerDist
            let rightEyeHeight = (self.rightEyeView.image!.size.height / self.rightEyeView.image!.size.width) * rightEyeWidth
            
            
            rightEyeView.transform = CGAffineTransform.identity
            rightEyeView.frame = CGRect(x: rightEyeCenter.x - rightEyeWidth / 2, y: rightEyeCenter.y - 0.6 * rightEyeHeight, width: rightEyeWidth, height: rightEyeHeight)
            rightEyeView.isHidden = false
            
            
            setAnchorPoint(CGPoint(x: 0.5, y: 1.0), forView: rightEyeView)
            
            angle = atan2(points.rightEye[5].y - points.rightEye[0].y, points.rightEye[5].x - points.rightEye[0].x)
            rightEyeView.transform = CGAffineTransform(rotationAngle: angle)
            
            
            let myNoseWidth = sqrt(pow(points.nose[0].x - points.nose[6].x, 2) + pow(points.nose[0].y - points.nose[6].y, 2))
            let noseCenter = CGPoint(x: (points.nose[0].x + points.nose[6].x) / 2, y: (points.nose[0].y + points.nose[6].y) / 2)
            
            let noseWidth = 1.1 * myNoseWidth
            let noseHeight = (self.noseView.image!.size.height / self.noseView.image!.size.width) * noseWidth
            
            
            noseView.transform = CGAffineTransform.identity
            noseView.frame = CGRect(x: noseCenter.x - noseWidth / 2, y: noseCenter.y - noseHeight / 2, width: noseWidth, height: noseHeight)
            noseView.isHidden = false
            
            
            setAnchorPoint(CGPoint(x: 0.5, y: 1.0), forView: noseView)
            
            angle = atan2(points.nose[6].y - points.nose[0].y, points.nose[6].x - points.nose[0].x)
            noseView.transform = CGAffineTransform(rotationAngle: angle)
 
            
            
            let mouWidth = 1.2 * myNoseWidth
            let mouHeight = (self.dogNoseView.image!.size.height / self.dogNoseView.image!.size.width) * 1.1 * mouWidth
            
            dogNoseView.transform = CGAffineTransform.identity
            dogNoseView.frame = CGRect(x: noseCenter.x - mouWidth / 2, y: noseCenter.y - mouHeight / 2, width: mouWidth, height: mouHeight)
            dogNoseView.isHidden = false
            
            
            setAnchorPoint(CGPoint(x: 0.5, y: 1.0), forView: dogNoseView)
            
            angle = atan2(points.nose[6].y - points.nose[0].y, points.nose[6].x - points.nose[0].x)
            dogNoseView.transform = CGAffineTransform(rotationAngle: angle)
            
        }
        
        else {
            
            self.hideAllOverlayViews()
        }
        
            
            
            
            
       
    }
    
    
    func setAnchorPoint(_ anchorPoint: CGPoint, forView view: UIView) {
        var newPoint = CGPoint(x: view.bounds.size.width * anchorPoint.x, y: view.bounds.size.height * anchorPoint.y)
        var oldPoint = CGPoint(x: view.bounds.size.width * view.layer.anchorPoint.x, y: view.bounds.size.height * view.layer.anchorPoint.y)
        
        newPoint = newPoint.applying(view.transform)
        oldPoint = oldPoint.applying(view.transform)
        
        var position = view.layer.position
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        view.layer.position = position
        view.layer.anchorPoint = anchorPoint
    }
    
    
    func hideAllOverlayViews() {
        
        self.sunglassesView.isHidden = true
        self.lipsView.isHidden = true
        self.noseView.isHidden = true
        self.rightEyeView.isHidden = true
        self.leftEyeView.isHidden = true
        self.cowboyHatView.isHidden = true
        self.clownHairView.isHidden = true
        self.santaHatView.isHidden = true
        self.tongueOutView.isHidden = true
        self.dogNoseView.isHidden = true
        
        for (_, views) in self.overlayViews {
            
            for view in views {
                view.isHidden = true
            }
        }
    }
    
    
    func updateViewForFeature(feature: String, index: Int, point: CGPoint, bgColor: UIColor) {
        
        let frame = CGRect(x: point.x - 2, y: point.y - 2, width: 4, height: 4)
        
        if self.overlayViews[feature] == nil {
            self.overlayViews[feature] = [UIView]()
        }
        
        if index < self.overlayViews[feature]!.count {
            
            self.overlayViews[feature]![index].frame = frame
            self.overlayViews[feature]![index].isHidden = true
            self.overlayViews[feature]![index].backgroundColor = bgColor
        } else {
            
            let newView = UIView(frame: frame)
            newView.backgroundColor = bgColor
            newView.isHidden = true
            self.view.addSubview(newView)
            self.overlayViews[feature]! += [newView]
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    /*********************************    Hat Options   *************************************/
    @IBAction func hatOptionsAction(_ sender: UIButton) {
        self.showHatOptions()
        self.hideNoseOptions()
        self.hideEyesOptions()
        self.hideLipsOptions()
    }
    
    func showHatOptions() {
        view.addSubview(self.hatOptionsView)
        let bottomConstraint = self.hatOptionsView.bottomAnchor.constraint(equalTo: self.filterOptionsView.topAnchor)
        let leftConstraint = self.hatOptionsView.leftAnchor.constraint(equalTo: view.leftAnchor)
        let rightConstraint = self.hatOptionsView.rightAnchor.constraint(equalTo: view.rightAnchor)
        let heightConstraint = self.hatOptionsView.heightAnchor.constraint(equalToConstant: 160)
        
        NSLayoutConstraint.activate([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        view.layoutIfNeeded()
        
        self.hatOptionsView.alpha = 0
        UIView.animate(withDuration: 0.2, animations: {self.hatOptionsView.alpha = 0.8})
    }
    
    func hideHatOptions() {
        
        UIView.animate(withDuration: 0.2, animations: {self.hatOptionsView.alpha = 0}, completion: {
            completed in
            if completed == true {
                self.hatOptionsView.removeFromSuperview()
            }
        })
    }
    
    @IBAction func santaHatAction(_ sender: UIButton) {
        DispatchQueue.main.async {
            
            
            self.santaHatView.removeFromSuperview()
            self.clownHairView.removeFromSuperview()
            self.cowboyHatView.removeFromSuperview()
            
            self.santaHatView.alpha = 0
            self.clownHairView.alpha = 0
            self.cowboyHatView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.view.insertSubview(self.santaHatView, aboveSubview: self.faceTrackerContainerView)
                self.santaHatView.alpha = 1
                self.santaHatView.transform = CGAffineTransform(translationX: -500, y: -500)
                self.view.layoutIfNeeded()
            }, completion: nil)

            
            
            self.hideHatOptions()
            self.santaHatOutlet.setTitleColor(UIColor.red, for: .normal)
            self.noneHatOutlet.setTitleColor(UIColor.black, for: .normal)
            self.clownWigOutlet.setTitleColor(UIColor.black, for: .normal)
            self.cowboyHatOutlet.setTitleColor(UIColor.black, for: .normal)

        }
    }
    
    @IBAction func cowboyHatAction(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            
            self.santaHatView.removeFromSuperview()
            self.clownHairView.removeFromSuperview()
            self.cowboyHatView.removeFromSuperview()
            self.santaHatView.alpha = 0
            self.clownHairView.alpha = 0
            self.cowboyHatView.alpha = 0
            
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.view.insertSubview(self.cowboyHatView, aboveSubview: self.faceTrackerContainerView)
                self.cowboyHatView.alpha = 1
                self.cowboyHatView.transform = CGAffineTransform(translationX: -500, y: -500)
                self.view.layoutIfNeeded()
            }, completion: nil)

            
            
            self.hideHatOptions()
            self.santaHatOutlet.setTitleColor(UIColor.black, for: .normal)
            self.noneHatOutlet.setTitleColor(UIColor.black, for: .normal)
            self.clownWigOutlet.setTitleColor(UIColor.black, for: .normal)
            self.cowboyHatOutlet.setTitleColor(UIColor.red, for: .normal)
        }
    }
    
    @IBAction func clownWigAction(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            
            self.santaHatView.removeFromSuperview()
            self.clownHairView.removeFromSuperview()
            self.cowboyHatView.removeFromSuperview()
            self.santaHatView.alpha = 0
            self.clownHairView.alpha = 0
            self.cowboyHatView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.view.insertSubview(self.clownHairView, aboveSubview: self.faceTrackerContainerView)
                self.clownHairView.alpha = 1
                self.clownHairView.transform = CGAffineTransform(translationX: -500, y: -500)
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            
            
            self.hideHatOptions()
            self.santaHatOutlet.setTitleColor(UIColor.black, for: .normal)
            self.noneHatOutlet.setTitleColor(UIColor.black, for: .normal)
            self.clownWigOutlet.setTitleColor(UIColor.red, for: .normal)
            self.cowboyHatOutlet.setTitleColor(UIColor.black, for: .normal)
        }
    }
    
    @IBAction func noneHatAction(_ sender: UIButton) {
        self.santaHatView.alpha = 0
        self.clownHairView.alpha = 0
        self.cowboyHatView.alpha = 0
        self.cowboyHatView.removeFromSuperview()
        self.clownHairView.removeFromSuperview()
        self.santaHatView.removeFromSuperview()
        self.hideHatOptions()
        
        self.santaHatOutlet.setTitleColor(UIColor.black, for: .normal)
        self.noneHatOutlet.setTitleColor(UIColor.red, for: .normal)
        self.clownWigOutlet.setTitleColor(UIColor.black, for: .normal)
        self.cowboyHatOutlet.setTitleColor(UIColor.black, for: .normal)
    }
    /**********************************************************************************/
    
    
    /*************************   Eyes Options    ************************************/
    
    @IBAction func eyesOptionsAction(_ sender: UIButton) {
        self.showEyesOptions()
        self.hideHatOptions()
        self.hideNoseOptions()
        self.hideLipsOptions()
    }
    
    
    func showEyesOptions() {
        
        view.addSubview(self.eyesOptionsView)
        let bottomConstraint = self.eyesOptionsView.bottomAnchor.constraint(equalTo: self.filterOptionsView.topAnchor)
        let leftConstraint = self.eyesOptionsView.leftAnchor.constraint(equalTo: view.leftAnchor)
        let rightConstraint = self.eyesOptionsView.rightAnchor.constraint(equalTo: view.rightAnchor)
        let heightConstraint = self.eyesOptionsView.heightAnchor.constraint(equalToConstant: 160)
        
        NSLayoutConstraint.activate([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        view.layoutIfNeeded()
        
        self.eyesOptionsView.alpha = 0
        UIView.animate(withDuration: 0.2, animations: {self.eyesOptionsView.alpha = 0.8})
        
        
    }
    
    func hideEyesOptions() {
        
        UIView.animate(withDuration: 0.2, animations: {self.eyesOptionsView.alpha = 0}, completion: {
            completed in
            if completed == true {
                self.eyesOptionsView.removeFromSuperview()
            }
        })
    }
    
    @IBAction func blueEyesAction(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            
            self.leftEyeView.image = UIImage(named: "blueEye")
            self.rightEyeView.image = UIImage(named: "blueEye")
            
            self.sunglassesView.removeFromSuperview()
            self.rightEyeView.removeFromSuperview()
            self.leftEyeView.removeFromSuperview()
            
            self.sunglassesView.alpha = 0
            self.leftEyeView.alpha = 0
            self.rightEyeView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.view.insertSubview(self.leftEyeView, aboveSubview: self.faceTrackerContainerView)
                self.view.insertSubview(self.rightEyeView, aboveSubview: self.faceTrackerContainerView)
                self.leftEyeView.alpha = 1
                self.rightEyeView.alpha = 1
                self.leftEyeView.transform = CGAffineTransform(translationX: 500, y: 500)
                self.rightEyeView.transform = CGAffineTransform(translationX: 500, y: 500)
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            self.hideEyesOptions()
            self.blueEyesOutlet.setTitleColor(UIColor.red, for: .normal)
            self.greenEyesOutlet.setTitleColor(UIColor.black, for: .normal)
            self.sunglassesOutlet.setTitleColor(UIColor.black, for: .normal)
            self.noneEyesOutlet.setTitleColor(UIColor.black, for: .normal)

        }
        
    }
    
    @IBAction func greenEyesAction(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            
            self.leftEyeView.image = UIImage(named: "greenEye")
            self.rightEyeView.image = UIImage(named: "greenEye")
            
            self.sunglassesView.removeFromSuperview()
            self.rightEyeView.removeFromSuperview()
            self.leftEyeView.removeFromSuperview()
            
            self.sunglassesView.alpha = 0
            self.leftEyeView.alpha = 0
            self.rightEyeView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.view.insertSubview(self.leftEyeView, aboveSubview: self.faceTrackerContainerView)
                self.view.insertSubview(self.rightEyeView, aboveSubview: self.faceTrackerContainerView)
                self.leftEyeView.alpha = 1
                self.rightEyeView.alpha = 1
                self.leftEyeView.transform = CGAffineTransform(translationX: 500, y: 500)
                self.rightEyeView.transform = CGAffineTransform(translationX: 500, y: 500)
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            self.hideEyesOptions()
            self.blueEyesOutlet.setTitleColor(UIColor.black, for: .normal)
            self.greenEyesOutlet.setTitleColor(UIColor.red, for: .normal)
            self.sunglassesOutlet.setTitleColor(UIColor.black, for: .normal)
            self.noneEyesOutlet.setTitleColor(UIColor.black, for: .normal)
        }
        
        
    }
    
    @IBAction func sunglassesAction(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            
            self.sunglassesView.removeFromSuperview()
            self.rightEyeView.removeFromSuperview()
            self.leftEyeView.removeFromSuperview()
            
            self.sunglassesView.alpha = 0
            self.leftEyeView.alpha = 0
            self.rightEyeView.alpha = 0
            
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.view.insertSubview(self.sunglassesView, aboveSubview: self.faceTrackerContainerView)
                self.sunglassesView.alpha = 1
                self.sunglassesView.transform = CGAffineTransform(translationX: 500, y: 500)
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            self.hideEyesOptions()
            self.blueEyesOutlet.setTitleColor(UIColor.black, for: .normal)
            self.greenEyesOutlet.setTitleColor(UIColor.black, for: .normal)
            self.sunglassesOutlet.setTitleColor(UIColor.red, for: .normal)
            self.noneEyesOutlet.setTitleColor(UIColor.black, for: .normal)
        }
    }
    
    @IBAction func nonEyesAction(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            self.sunglassesView.alpha = 0
            self.leftEyeView.alpha = 0
            self.rightEyeView.alpha = 0
            self.sunglassesView.removeFromSuperview()
            self.rightEyeView.removeFromSuperview()
            self.leftEyeView.removeFromSuperview()
            self.hideEyesOptions()
            self.blueEyesOutlet.setTitleColor(UIColor.black, for: .normal)
            self.greenEyesOutlet.setTitleColor(UIColor.black, for: .normal)
            self.sunglassesOutlet.setTitleColor(UIColor.black, for: .normal)
            self.noneEyesOutlet.setTitleColor(UIColor.red, for: .normal)
        }
        
        
        
    }
    /**********************************************************************************/
    

    
    
    
    
    /*************************   Nose Options    ************************************/
    
    @IBAction func noseOptionsAction(_ sender: UIButton) {
        self.showNoseOptions()
        self.hideHatOptions()
        self.hideEyesOptions()
        self.hideLipsOptions()
    }
    
    
    func showNoseOptions() {
        
        view.addSubview(self.noseOptionsView)
        let bottomConstraint = self.noseOptionsView.bottomAnchor.constraint(equalTo: self.filterOptionsView.topAnchor)
        let leftConstraint = self.noseOptionsView.leftAnchor.constraint(equalTo: view.leftAnchor)
        let rightConstraint = self.noseOptionsView.rightAnchor.constraint(equalTo: view.rightAnchor)
        let heightConstraint = self.noseOptionsView.heightAnchor.constraint(equalToConstant: 160)
        
        NSLayoutConstraint.activate([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        view.layoutIfNeeded()
        
        self.noseOptionsView.alpha = 0
        UIView.animate(withDuration: 0.2, animations: {self.noseOptionsView.alpha = 0.8})
        
        
    }
    
    func hideNoseOptions() {
        
        UIView.animate(withDuration: 0.2, animations: {self.noseOptionsView.alpha = 0}, completion: {
            completed in
            if completed == true {
                self.noseOptionsView.removeFromSuperview()
            }
        })
    }
    
    @IBAction func clownNoseAction(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            self.noseView.image = UIImage(named: "redNose")
            self.dogNoseView.removeFromSuperview()
            self.noseView.removeFromSuperview()
            self.noseView.alpha = 0
            self.dogNoseView.alpha = 0
            
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.view.insertSubview(self.noseView, aboveSubview: self.faceTrackerContainerView)
                self.noseView.alpha = 1
                self.noseView.transform = CGAffineTransform(translationX: -500, y: 500)
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            
            self.hideNoseOptions()
            self.clownNoseOutlet.setTitleColor(UIColor.red, for: .normal)
            self.pigNoseOutlet.setTitleColor(UIColor.black, for: .normal)
            self.dogNoseOutlet.setTitleColor(UIColor.black, for: .normal)
            self.noneNoseOutlet.setTitleColor(UIColor.black, for: .normal)
        }
    }
    
    @IBAction func pigNoseAction(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            
            self.noseView.image = UIImage(named: "pigNose")
            self.dogNoseView.removeFromSuperview()
            self.noseView.removeFromSuperview()
            self.noseView.alpha = 0
            self.dogNoseView.alpha = 0

            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.view.insertSubview(self.noseView, aboveSubview: self.faceTrackerContainerView)
                self.noseView.alpha = 1
                self.noseView.transform = CGAffineTransform(translationX: -500, y: 500)
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            
            
            self.hideNoseOptions()
            self.clownNoseOutlet.setTitleColor(UIColor.black, for: .normal)
            self.pigNoseOutlet.setTitleColor(UIColor.red, for: .normal)
            self.dogNoseOutlet.setTitleColor(UIColor.black, for: .normal)
            self.noneNoseOutlet.setTitleColor(UIColor.black, for: .normal)
        }
    }
    
    
    @IBAction func dogNoseAction(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            self.dogNoseView.removeFromSuperview()
            self.noseView.removeFromSuperview()
            self.noseView.alpha = 0
            self.dogNoseView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.view.insertSubview(self.dogNoseView, aboveSubview: self.faceTrackerContainerView)
                self.dogNoseView.alpha = 1
                self.dogNoseView.transform = CGAffineTransform(translationX: -500, y: 500)
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            
            self.hideNoseOptions()
            self.clownNoseOutlet.setTitleColor(UIColor.black, for: .normal)
            self.pigNoseOutlet.setTitleColor(UIColor.black, for: .normal)
            self.dogNoseOutlet.setTitleColor(UIColor.red, for: .normal)
            self.noneNoseOutlet.setTitleColor(UIColor.black, for: .normal)
        }
    }
    
    @IBAction func noneNoseAction(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            self.noseView.alpha = 0
            self.dogNoseView.alpha = 0
            self.noseView.removeFromSuperview()
            self.dogNoseView.removeFromSuperview()
            self.hideNoseOptions()
            self.clownNoseOutlet.setTitleColor(UIColor.black, for: .normal)
            self.pigNoseOutlet.setTitleColor(UIColor.black, for: .normal)
            self.dogNoseOutlet.setTitleColor(UIColor.black, for: .normal)
            self.noneNoseOutlet.setTitleColor(UIColor.red, for: .normal)
        }
    }
    
    
    
    /**********************************************************************************/
    
    
    
    /*************************   Lips Options    ************************************/
    
    @IBAction func lipsOptionsAction(_ sender: UIButton) {
        
        self.showLipsOptions()
        self.hideHatOptions()
        self.hideEyesOptions()
        self.hideNoseOptions()
    }
    
    
    func showLipsOptions() {
        
        view.addSubview(self.lipsOptionsView)
        let bottomConstraint = self.lipsOptionsView.bottomAnchor.constraint(equalTo: self.filterOptionsView.topAnchor)
        let leftConstraint = self.lipsOptionsView.leftAnchor.constraint(equalTo: view.leftAnchor)
        let rightConstraint = self.lipsOptionsView.rightAnchor.constraint(equalTo: view.rightAnchor)
        let heightConstraint = self.lipsOptionsView.heightAnchor.constraint(equalToConstant: 160)
        
        NSLayoutConstraint.activate([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        view.layoutIfNeeded()
        
        self.lipsOptionsView.alpha = 0
        UIView.animate(withDuration: 0.2, animations: {self.lipsOptionsView.alpha = 0.8})
        
        
    }
    
    func hideLipsOptions() {
        
        UIView.animate(withDuration: 0.2, animations: {self.lipsOptionsView.alpha = 0}, completion: {
            completed in
            if completed == true {
                self.lipsOptionsView.removeFromSuperview()
            }
        })
    }
    
    
    
    @IBAction func redLipsAction(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            self.lipsView.image = UIImage(named: "redLips")
            self.tongueOutView.removeFromSuperview()
            self.lipsView.removeFromSuperview()
            self.tongueOutView.alpha = 0
            self.lipsView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.view.insertSubview(self.lipsView, aboveSubview: self.faceTrackerContainerView)
                self.lipsView.alpha = 1
                self.lipsView.transform = CGAffineTransform(translationX: 500, y: -500)
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            
            
            self.hideLipsOptions()
            self.redLipsOutlet.setTitleColor(UIColor.red, for: .normal)
            self.laughingLipsOutlet.setTitleColor(UIColor.black, for: .normal)
            self.tongueOutOutlet.setTitleColor(UIColor.black, for: .normal)
            self.noneLipsOutlet.setTitleColor(UIColor.black, for: .normal)
        }
        
    }
    
    @IBAction func tongueOutAction(_ sender: UIButton) {
        DispatchQueue.main.async {
            
            self.tongueOutView.removeFromSuperview()
            self.lipsView.removeFromSuperview()
            self.tongueOutView.alpha = 0
            self.lipsView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.view.insertSubview(self.tongueOutView, aboveSubview: self.faceTrackerContainerView)
                self.tongueOutView.alpha = 1
                self.tongueOutView.transform = CGAffineTransform(translationX: 500, y: -500)
                self.view.layoutIfNeeded()
            }, completion: nil)
            

            self.hideLipsOptions()
            self.redLipsOutlet.setTitleColor(UIColor.black, for: .normal)
            self.laughingLipsOutlet.setTitleColor(UIColor.black, for: .normal)
            self.tongueOutOutlet.setTitleColor(UIColor.red, for: .normal)
            self.noneLipsOutlet.setTitleColor(UIColor.black, for: .normal)
        }
    }
    
    @IBAction func laughingLipsAction(_ sender: UIButton) {
        
        
        DispatchQueue.main.async {
            
            self.lipsView.image = UIImage(named: "laughingLips")
            self.tongueOutView.removeFromSuperview()
            self.lipsView.removeFromSuperview()
            self.tongueOutView.alpha = 0
            self.lipsView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.view.insertSubview(self.lipsView, aboveSubview: self.faceTrackerContainerView)
                self.lipsView.alpha = 1
                self.lipsView.transform = CGAffineTransform(translationX: 500, y: -500)
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            
            self.hideLipsOptions()
            self.redLipsOutlet.setTitleColor(UIColor.black, for: .normal)
            self.laughingLipsOutlet.setTitleColor(UIColor.red, for: .normal)
            self.tongueOutOutlet.setTitleColor(UIColor.black, for: .normal)
            self.noneLipsOutlet.setTitleColor(UIColor.black, for: .normal)
        }
        

    }
    
    @IBAction func noneLipsAction(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            self.tongueOutView.alpha = 0
            self.lipsView.alpha = 0
            self.lipsView.removeFromSuperview()
            self.tongueOutView.removeFromSuperview()
            self.hideLipsOptions()
            self.redLipsOutlet.setTitleColor(UIColor.black, for: .normal)
            self.laughingLipsOutlet.setTitleColor(UIColor.black, for: .normal)
            self.tongueOutOutlet.setTitleColor(UIColor.black, for: .normal)
            self.noneLipsOutlet.setTitleColor(UIColor.red, for: .normal)
        }
        
    }
    
    
    
    
    /**********************************************************************************/
    
    
    
    func hideAllOptions() {
        
        self.hideHatOptions()
        self.hideEyesOptions()
        self.hideLipsOptions()
        self.hideNoseOptions()
    }
    
    
    
    
    
    func addShotTakenView(handler: () -> Void) {
        
        self.view.addSubview(self.shotTakenView)
        
        
        let topConstraint = self.shotTakenView.topAnchor.constraint(equalTo: view.topAnchor, constant: 300)
        let leftConstraint = self.shotTakenView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100)
        let rightConstraint = self.shotTakenView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100)
        let heightConstraint = self.shotTakenView.heightAnchor.constraint(equalToConstant: 150)
        let widthConstraint = self.shotTakenView.widthAnchor.constraint(equalToConstant: 300)
        
        NSLayoutConstraint.activate([topConstraint, leftConstraint, rightConstraint, heightConstraint, widthConstraint])
        view.layoutIfNeeded()
        
        self.shotTakenView.alpha = 0
        UIView.animate(withDuration: 0.2, animations: {self.shotTakenView.alpha = 0.8})
        handler()
    }
    
    func screenShotMethod(handler: () -> Void) {
        
        let size = CGSize(width: 375.0, height: 627.0)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        let rect = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height)
        self.view.drawHierarchy(in: rect, afterScreenUpdates: true)
        self.screenShot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //UIImageWriteToSavedPhotosAlbum(screenshot!, nil, nil, nil)
        
        
        
        
        self.addShotTakenView() {
            handler()
        }
    }
    
    
    @IBAction func takePicture(_ sender: UIButton) {
        
        self.screenShotMethod() {
            
            UIView.animate(withDuration: 0.5, animations: {self.shotTakenView.alpha = 0}, completion: {
                completed in
                if completed == true {
                    self.shotTakenView.removeFromSuperview()
                    
                    self.addBigImageView()
                }
            })
        }
    }
    
    func addBigImageView() {
        
        if let screenshot = self.screenShot {
            
            self.bigPicImageView.image = screenshot
        }
        
        self.view.addSubview(self.bigPicView)
        
        
        let topConstraint = self.bigPicView.topAnchor.constraint(equalTo: view.topAnchor)
        let bottomConstraint = self.bigPicView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let leftConstraint = self.bigPicView.leftAnchor.constraint(equalTo: view.leftAnchor)
        let rightConstraint = self.bigPicView.rightAnchor.constraint(equalTo: view.rightAnchor)
        
        
        NSLayoutConstraint.activate([topConstraint, leftConstraint, rightConstraint, bottomConstraint])
        view.layoutIfNeeded()
        
        self.bigPicView.alpha = 0
        UIView.animate(withDuration: 0.2, animations: {self.bigPicView.alpha = 1})
    }
    
    
    
    @IBAction func cancelBigPicView(_ sender: UIButton) {
        
        self.hideBigPicView()
    }
    
    
    func hideBigPicView() {
        
        UIView.animate(withDuration: 0.2, animations: {self.bigPicView.alpha = 0}, completion: {
            completed in
            if completed == true {
                self.bigPicView.removeFromSuperview()
            }
        })
    }
    
    
    @IBAction func saveBigPicView(_ sender: UIButton) {
        
        let activityController = UIActivityViewController(activityItems: [self.screenShot!], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil )
    }
    
    
    
}

