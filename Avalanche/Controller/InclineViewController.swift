//
//  InclineViewController.swift
//  Avalanche
//
//  Created by kristian & lauren parr on 30/05/2020.
//  Copyright © 2020 Lauren Charnley-Parr. All rights reserved.
//

import UIKit
import CoreMotion

class InclineViewController: UIViewController {

    @IBOutlet weak var degreesLabel: UILabel!
    @IBOutlet weak var riskMessageLabel: UILabel!
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var helpTextLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    private var motionManager: CMMotionManager!
    private var helpTextVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        helpTextLabel.isHidden = true
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates(to: .main, withHandler: handleAccelerometerData)
        
        }
    
 func handleAccelerometerData(data: CMAccelerometerData?, error: Error?) {
    
    guard data != nil else {
        degreesLabel.text = "error"
        riskMessageLabel.text = "Incline data unavailable"
        return
    }
    
    if let accelerometerData = data {
       
        let y = accelerometerData.acceleration.y
        
        switch y {
        case -0.30 ..< 0.00 :
            degreesLabel.text = "0° - 20°"
            riskMessageLabel.text = "Low risk"
        case -0.36 ..< -0.30 :
            degreesLabel.text = "20° - 25°"
            riskMessageLabel.text = "Avalanche slides rare"
        case -0.50 ..< -0.36 :
            degreesLabel.text = "25° - 30°"
            riskMessageLabel.text = "Slabs possible in unstable conditions"
        case -0.57 ..< -0.50 :
            degreesLabel.text = "30° - 35°"
            riskMessageLabel.text = "Moderate risk of slabs in unstable conditions"
        case -0.65 ..< -0.57 :
            degreesLabel.text = "35° - 40°"
            riskMessageLabel.text = "Highest avalanche risk"
        case -0.70 ..< -0.65 :
            degreesLabel.text = "40° - 45°"
            riskMessageLabel.text = "Moderate risk"
        case -0.76 ..< -0.70 :
            degreesLabel.text = "45° - 50°"
            riskMessageLabel.text = "Small slabs possible"
        case -1.1 ..< -0.76 :
            degreesLabel.text = "50° - 90°"
            riskMessageLabel.text = "Low risk"
        default :
            degreesLabel.text = "Degrees unavailable"
            riskMessageLabel.text = "Low risk"
            }
    }
} //()

    @IBAction func helpPressed(_ sender: Any) {
        
        motionManager.stopAccelerometerUpdates()
        degreesLabel.isHidden = true
        riskMessageLabel.isHidden = true
        helpButton.isHidden = true
        helpTextLabel.isHidden = false
        helpTextVisible = true
        
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        
        if helpTextVisible {
            motionManager.startAccelerometerUpdates(to: .main, withHandler: handleAccelerometerData)
            degreesLabel.isHidden = false
            riskMessageLabel.isHidden = false
            helpButton.isHidden = false
            helpTextLabel.isHidden = true
            helpTextVisible = false
        } else if !helpTextVisible {
            performSegue(withIdentifier: "toMenuVC", sender: self)
        }
        
    }
    
    
}
