//
//  ViewController.swift
//  Calculator
//
//  Created by Ashish Mishra on 2/3/16.
//  Copyright © 2016 Ashish Mishra. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var slidingView : UIView!
    @IBOutlet weak var leadingSpaceLayoutForSlider : NSLayoutConstraint!
    
    let brain = CalculatorBrain()
    
    var isFirstDigit = true
    var operand1: Double = 0
    var operation = "="
    var isViewSwiped = false
    
    let leftswipeGesture = UISwipeGestureRecognizer()
    let rightswipeGesture = UISwipeGestureRecognizer()


    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
        leftswipeGesture.addTarget(self, action: "leftSwipe");
        leftswipeGesture.direction = .Left
        slidingView.addGestureRecognizer(leftswipeGesture);
        slidingView.userInteractionEnabled = true;
        
        rightswipeGesture.addTarget(self, action: "rightSwipe");
        rightswipeGesture.direction = .Right
        slidingView.addGestureRecognizer(rightswipeGesture);

    }
    
    func rotated()
    {

        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation))
        {
            
                self.leadingSpaceLayoutForSlider.constant = 670;

        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation))
        {
            
                self.leadingSpaceLayoutForSlider.constant = 370;

        }
        
    }
    
    func leftSwipe(){
        self.slidingView.layoutIfNeeded()
        UIView .animateWithDuration(0.3) { () -> Void in
            if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation))
            {
                
                self.slidingView.center.x = self.slidingView.center.x - 75;
                
            }
            
            if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation))
            {
                
                self.slidingView.center.x = self.slidingView.center.x - 110;
                
            }
            
            self.slidingView.layoutIfNeeded();

        }
    }
    
    func rightSwipe() {
        self.slidingView.layoutIfNeeded()
        UIView .animateWithDuration(0.3) { () -> Void in
            
            if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation))
            {
                
                self.slidingView.center.x = self.slidingView.center.x + 75;
                
            }
            
            if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation))
            {
                
                self.slidingView.center.x = self.slidingView.center.x + 110;
                
            }
            self.slidingView.layoutIfNeeded();
        }
    }
    
    
    var displayValue: Double {
        get {
            if(displayLabel.text == "inf") {
                displayLabel.text = "0";
            }
            return NSNumberFormatter().numberFromString(displayLabel.text!)!.doubleValue
        }
        set {
            displayLabel.text  = "\(newValue)"
            isFirstDigit = true
            operation = "="
        }
    }
    
    @IBAction func appendDigit(sender: UIButton) {
        
        let digit = sender.currentTitle!
        displayLabel.text = isFirstDigit ? digit : displayLabel.text! + digit
        isFirstDigit = false
    }
    
    @IBAction func clearDisplay(sender: AnyObject) {
        displayValue = 0
    }
    
    @IBAction func saveOperand(sender: UIButton) {
        operation = sender.currentTitle!
        operand1 = displayValue
        brain.saveOperand(operation,operand: operand1);
        isFirstDigit = true
    }
    
    @IBAction func calculate(sender: AnyObject) {
        let secondOperand = displayValue
        displayValue = brain.performOperation(secondOperand)
    }
    
    func gestureRecognizer(_: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
            return true
    }
    
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.LandscapeLeft,UIInterfaceOrientationMask.LandscapeRight,UIInterfaceOrientationMask.Portrait]
    }
    
}

