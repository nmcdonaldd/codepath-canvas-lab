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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        switch sender.state {
        case .began:
            print("Panning began!")
            self.trayOriginalCenter = facesTrayView.center
            break
        case .changed:
            print("Panning changed!")
            self.facesTrayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            break
        default:
            print("\(sender.state.rawValue)")
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
