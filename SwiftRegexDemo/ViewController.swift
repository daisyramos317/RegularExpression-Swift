//
//  ViewController.swift
//  SwiftRegexDemo
//
//  Created by Daisy Ramos on 6/8/16.
//  Copyright © 2016 Flamelilylabs. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var textFields: [UITextField]!
    var regexes: [NSRegularExpression?]!
    
    
    @IBOutlet weak var visaTextField: UITextField!
    @IBOutlet weak var masterTextField: UITextField!
    @IBOutlet weak var amexTextField: UITextField!
    
    
    let regVisa = "^4[0-9]{12}(?:[0-9]{3})?$"
    let regMaster = "^5[1-5][0-9]{14}$"
    let regExpress = "^3[47][0-9]{13}$"
    
    override func viewDidLoad() {
        
        textFields = [ visaTextField, masterTextField, amexTextField]
        
        let patterns = [ regVisa,      // regex to check valid Visa
            regMaster,            // regex to check valid MasterCard
            regExpress,     // regex to check valid American Express
            ]
        
        regexes = patterns.map {
            try? NSRegularExpression(pattern: $0, options: .CaseInsensitive)
        }
        
        visaTextField.keyboardType = UIKeyboardType.NumberPad
        masterTextField.keyboardType = UIKeyboardType.NumberPad
        amexTextField.keyboardType = UIKeyboardType.NumberPad
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func isValidCreditCardUsingNSRegularExpression(textField: UITextField)  {
        let index = textFields.indexOf(textField)
        guard let regex = regexes[index!] else {
            print("error")
            return 
            }
        
        let text = textField.text!
        let range = NSMakeRange(0, text.characters.count)
        
        let matchRange = regex.rangeOfFirstMatchInString(text, options: [], range: range)
        
       
        
        let valid = matchRange.location != NSNotFound
        
        if valid == false {
            textField.toggleField()
        }
        else {
            if index == 0 {
                displayAlertMessage("We validated this Visa card using NSRegularExpression")
            }
            else if index == 1{
                displayAlertMessage("We validated this MasterCard card using NSRegularExpression")
            }
            
            else if index == 2 {
                displayAlertMessage("We validated this American Express card using NSRegularExpression")
            }
            
        }
    }
    
    func isValidCreditCardUsingNSPredicate(textField: UITextField) {
        
        let regVisaTest = NSPredicate(format: "SELF MATCHES %@", regVisa)
        let regMasterTest = NSPredicate(format: "SELF MATCHES %@", regMaster)
        let regExpressTest = NSPredicate(format: "SELF MATCHES %@", regExpress)
     
        
        
        if regVisaTest.evaluateWithObject(textField.text){
            
             displayAlertMessage("We validated this Visa card using NSPredicate")
            
        }
        else if regMasterTest.evaluateWithObject(textField.text){
             displayAlertMessage("We validated this MasterCard using NSPredicate")
            
        }
            
        else if regExpressTest.evaluateWithObject(textField.text){
             displayAlertMessage("We validated this American Express card using NSPredicate")
          
        }
        
        else {
            textField.toggleField()
        }

        
    }
    
    func displayAlertMessage(userMessage: String)
    {
        
        let myAlert = UIAlertController(title:"Hurray! 🎉", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title:"Ok", style: UIAlertActionStyle.Default, handler:nil)
        
        myAlert.addAction(okAction);
        
        self.presentViewController(myAlert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func validateWithNSRegularExpressionTapped(sender: AnyObject) {
        
        for textField in textFields {
            isValidCreditCardUsingNSRegularExpression(textField)
            textField.resignFirstResponder()
        }
    }
    
   
    @IBAction func validateWithNSPredicateTapped(sender: AnyObject) {
        
        for textField in textFields {
            isValidCreditCardUsingNSPredicate(textField)
            textField.resignFirstResponder()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension UITextField {
    func toggleField(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(self.center.x - 10, self.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(self.center.x + 10, self.center.y))
        self.layer.addAnimation(animation, forKey: "position")
        
    }
}

