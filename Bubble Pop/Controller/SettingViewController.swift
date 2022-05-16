//
//  SettingViewController.swift
//  Bubble Pop
//
//

import Foundation

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var gameTimeLabel: UILabel!
    @IBOutlet weak var maxBubbleLabel: UILabel!
    @IBOutlet weak var gameTimeSlider: UISlider!
    @IBOutlet weak var maxBubbleSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGame"{
            let VC = segue.destination as! GameViewController;
            VC.name = nameTextField.text;
            VC.remainingTime = Int(gameTimeSlider.value);
            VC.maxBubbles = Int(maxBubbleSlider.value);
        }
    }
    
    // game time slider value
    @IBAction func gameTimeSLider(_ sender: UISlider) {
        let value = Int(sender.value)
        gameTimeLabel.text = "\(value)"
    }
    // max bubble slider value
    @IBAction func maxBubbleSlider(_ sender: UISlider) {
        let value = Int(sender.value)
        maxBubbleLabel.text = "\(value)"
    }
    
}
