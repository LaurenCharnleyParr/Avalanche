//
//  OrientationVC.swift
//  Avalanche
//
//  Created by Lauren Charnley-Parr on 21/05/2020.
//  Copyright © 2020 Lauren Charnley-Parr. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation

class OrientationVC: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!
    @IBOutlet weak var orientationLabel: UILabel!
    @IBOutlet var orientationView: UIView!
    
    private var motionManager: CMMotionManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates(to: .main, withHandler: handleAccelerometerData)
        print("accellerometer started updating")
    }
    
    func handleAccelerometerData(data: CMAccelerometerData?, error: Error?) {
        
        guard data != nil else {
            orientationLabel.text = "error"
            return
        }
        
        if let accelerometerData = data {
            
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 1
            formatter.maximumFractionDigits = 2
            
            let y = accelerometerData.acceleration.y
            if y < -0.9 && y > -1.1 {
                orientationLabel.text = "Facing up!"
                orientationView.backgroundColor = #colorLiteral(red: 0.7912039974, green: 0.04453057677, blue: 0.01489349974, alpha: 1)
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            } else if y > 0.9 && y < 1.1 {
                orientationLabel.text = "Upside down"
                orientationView.backgroundColor = #colorLiteral(red: 0.1212944761, green: 0.1292245686, blue: 0.141699791, alpha: 1)
            } else {
                orientationLabel.text = "Keep looking"
                orientationView.backgroundColor = #colorLiteral(red: 0.1212944761, green: 0.1292245686, blue: 0.141699791, alpha: 1)
            }
            
            let xString = formatter.string(from: NSNumber(value: accelerometerData.acceleration.x))!
            let yString = formatter.string(from: NSNumber(value: accelerometerData.acceleration.y))!
            let zString = formatter.string(from: NSNumber(value: accelerometerData.acceleration.z))!
            
            xLabel.text = "X: \(xString)"
            yLabel.text = "Y: \(yString)"
            zLabel.text = "Z: \(zString)"
            print("x: \(xString), y: \(yString), z: \(zString)")
         }
    } //handleAccelerometerData()
    
    @IBAction func backButtonPressed(_ sender: Any) {
        motionManager.stopAccelerometerUpdates()
    }
}
