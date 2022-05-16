//
//  Bubble.swift
//  Bubble Pop
//
//

import Foundation
import UIKit

class Bubble: UIButton{
    // Init value of buble
    var value: Int = 0;
    // Making bubble variable percentage of screen size
    var bubbleRadius = UInt32(UIScreen.main.bounds.width / 12);
    // Getting screen space bounds
    let width = UInt32(UIScreen.main.bounds.width);
    let height = UInt32(UIScreen.main.bounds.height);
    
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        // random number
        let randNumber = Int.random(in: 1...100);
        if(randNumber <= 40 ){
            self.backgroundColor = .red;
            self.value = 1;
        } else if (randNumber > 40 && randNumber <= 70){
            self.backgroundColor = UIColor(red: 255.0/255.0 ,green: 20.0/255.0, blue: 147.0/255.0, alpha: 1.0);
            self.value = 2;
        } else if (randNumber > 70 && randNumber <= 85){
            self.backgroundColor = .green;
            self.value = 5;
        } else if (randNumber > 85 && randNumber <= 95){
            self.backgroundColor = .blue;
            self.value = 8;
        }else if (randNumber > 95 && randNumber <= 100){
            self.backgroundColor = .black;
            self.value = 10;
        }
        
        self.frame = CGRect(x: (10 + Int(arc4random_uniform(width - 2 * bubbleRadius - 20))), y: (160 + Int(arc4random_uniform(height - 2 * bubbleRadius - 180))), width: Int(2 * bubbleRadius), height: Int(2 * bubbleRadius));
        self.layer.cornerRadius = 0.5 * self.bounds.size.width;
            
        
    }
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented");
    }
    
    func animation(){
        let springAnimation = CASpringAnimation(keyPath: "transform.scale");
        springAnimation.duration = 0.6;
        springAnimation.fromValue = 1;
        springAnimation.toValue = 0.8;
        springAnimation.repeatCount = 1;
        springAnimation.initialVelocity = 0.5;
        springAnimation.damping = 1;
        layer.add(springAnimation, forKey: nil);
    }
    
    func flash(){
        let flash = CABasicAnimation(keyPath: "opacity");
        flash.duration = 0.2;
        flash.fromValue = 1;
        flash.toValue = 0.1;
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut);
        flash.autoreverses = true;
        flash.repeatCount = 3;
        
        layer.add(flash, forKey: nil);
    }
}
