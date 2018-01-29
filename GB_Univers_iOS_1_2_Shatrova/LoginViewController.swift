//
//  ViewController.swift
//  GB_Univers_iOS_1_2_Shatrova
//
//  Created by apple on 23.01.2018.
//  Copyright © 2018 Korona. All rights reserved.
//

import UIKit
import VK_ios_sdk
import SwiftyJSON
import Alamofire

class LoginViewController: UIViewController, VKSdkUIDelegate {
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print("Success baby")
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print("one more time")
    }
    
    
    let VK_API_ID = "6352014"

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var usrnameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
   /* @IBAction func signInButton(_ sender: Any) {
        let username = usrnameField.text!
        let password = passwordField.text!
        
        if username == "aaa" && password == "111" {
            print("Success!")}
        else {
            print ("Failed")
        }
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sdkInstance = VKSdk.initialize(withAppId: self.VK_API_ID)
        sdkInstance?.register(self as! VKSdkDelegate)
        sdkInstance?.uiDelegate = self as! VKSdkUIDelegate
        
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(self.keyboardHideWithTap))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let checkResult = checkSignIn()
        if !checkSignIn() {
            showError()
        }
        
        return checkResult
    }
    
    func checkSignIn() -> Bool {
        let usernameSegue = usrnameField.text!
            let passwordSegue = passwordField.text!
        
            if usernameSegue == "aaa" && passwordSegue == "111" {
                return true
            } else {
                return false
            }
    }
    
    func showError() {
        let failedAlert = UIAlertController(title: "Error", message: "Try Again", preferredStyle: UIAlertControllerStyle.alert)
        let failedAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
        failedAlert.addAction(failedAction)
        present(failedAlert, animated: true, completion: nil)
    }

    @objc func keyboardWasShown (notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let keyboardSize = (info.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsetsOne = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0)
        
        self.scrollView?.contentInset = contentInsetsOne
        scrollView?.scrollIndicatorInsets = contentInsetsOne
        
    }
    
    @objc func keyboardWillBeHidden (notification: Notification) {
        let contentInsetsTwo = UIEdgeInsets.zero
        self.scrollView?.contentInset = contentInsetsTwo
        scrollView?.scrollIndicatorInsets = contentInsetsTwo
        
    }
    
    @objc func keyboardHideWithTap () {
        self.scrollView?.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }


}

