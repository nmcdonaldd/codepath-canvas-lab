//
//  CanvasViewController.swift
//  codepath-canvas
//
//  Created by Nick McDonald on 4/15/17.
//  Copyright © 2017 Nick McDonald. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var facesTrayView: UIView!
    var trayOriginalCenter: CGPoint!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    var newlyCreatedFace: UIImageView!
    
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        trayDownOffset = 190
        trayUp = facesTrayView.center
        trayDown = CGPoint(x: facesTrayView.center.x ,y: facesTrayView.center.y + trayDownOffset)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func canvasFaceDidPan(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            self.newlyCreatedFace = sender.view as! UIImageView
            self.newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }, completion: nil)
            break
        case .changed:
            let translation = sender.translation(in: view)
            self.newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            break
        case .ended:
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
            break
        default:
            print("This shouldn't be called!")
        }
    }

    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        switch sender.state {
        case .began:
            self.trayOriginalCenter = facesTrayView.center
            break
        case .changed:
            print("\(self.facesTrayView.frame.minY)")
            self.facesTrayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + ((self.facesTrayView.frame.minY < 450) ? translation.y/10 : translation.y))
            break
        case .ended:
            let velocity = sender.velocity(in: view)
            if velocity.y > 0 {
                // This means the tray is moving down.
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: [], animations: {
                    self.facesTrayView.center = self.trayDown
                }, completion: nil)
            } else {
                // The tray is moving up.
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: [], animations: {
                    self.facesTrayView.center = self.trayUp
                }, completion: nil)
            }
            break
        default:
            print("\(sender.state.rawValue)")
        }
    }
    
    func userDoubleTappedFace(sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        imageView.removeFromSuperview()
    }
    
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            let imageViewTapped = sender.view! as! UIImageView
            self.newlyCreatedFace = UIImageView(image: imageViewTapped.image)
            self.newlyCreatedFace.isUserInteractionEnabled = true
            let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(userDoubleTappedFace(sender:)))
            doubleTapGestureRecognizer.numberOfTapsRequired = 2
            self.newlyCreatedFace.addGestureRecognizer(doubleTapGestureRecognizer)
            self.newlyCreatedFace.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(canvasFaceDidPan(sender:))))
            view.addSubview(self.newlyCreatedFace)
            self.newlyCreatedFace.center = imageViewTapped.center
            self.newlyCreatedFace.center.y += facesTrayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }, completion: nil)
            break
        case .changed:
            let translation = sender.translation(in: view)
            self.newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            break
        case.ended:
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
        default:
            print("Default case, this shouldn't be called.")
        }
    }
}
