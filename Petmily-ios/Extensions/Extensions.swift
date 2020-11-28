//
//  Extensions.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/25.
//

import UIKit
import PopupDialog


extension UIViewController {
    
    func bottomAlertWithCancelButtonAndOkayButton(title:String, message:String, cancleText:String?, okayText:String?, okayFunction:(() -> Void)?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
        
        alert.addAction(UIAlertAction(title: okayText, style: UIAlertAction.Style.default, handler: { (action) in
            if let function = okayFunction {
                function()
            }
        }))
        
        alert.addAction(UIAlertAction(title: cancleText, style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    var isDarkMode: Bool {
            if #available(iOS 13.0, *) {
                return self.traitCollection.userInterfaceStyle == .dark
            }
            else {
                return false
            }
        }
    
    func renderPopupWithOkayButtonNoImage(title:String, message:String) {
        

        // Create the dialog
        let popup = PopupDialog(title: title, message: message)
        
        if isDarkMode {
            // Customize dialog appearance
            let pv = PopupDialogDefaultView.appearance()
            pv.titleFont    = UIFont(name: "HelveticaNeue-Light", size: 16)!
            pv.titleColor   = .white
            pv.messageFont  = UIFont(name: "HelveticaNeue", size: 14)!
            pv.messageColor = UIColor(white: 0.8, alpha: 1)

            // Customize the container view appearance
            let pcv = PopupDialogContainerView.appearance()
            pcv.backgroundColor = UIColor(red:0.23, green:0.23, blue:0.27, alpha:1.00)
            pcv.cornerRadius    = 2
            pcv.shadowEnabled   = true
            pcv.shadowColor     = .black

            // Customize overlay appearance
            let ov = PopupDialogOverlayView.appearance()
            ov.blurEnabled     = true
            ov.blurRadius      = 30
            ov.liveBlurEnabled = true
            ov.opacity         = 0.7
            ov.color           = .black

            // Customize default button appearance
            let db = DefaultButton.appearance()
            db.titleFont      = UIFont(name: "HelveticaNeue-Medium", size: 14)!
            db.titleColor     = .white
            db.buttonColor    = UIColor(red:0.25, green:0.25, blue:0.29, alpha:1.00)
            db.separatorColor = UIColor(red:0.20, green:0.20, blue:0.25, alpha:1.00)

            // Customize cancel button appearance
            let cb = CancelButton.appearance()
            cb.titleFont      = UIFont(name: "HelveticaNeue-Medium", size: 14)!
            cb.titleColor     = UIColor(white: 0.6, alpha: 1)
            cb.buttonColor    = UIColor(red:0.25, green:0.25, blue:0.29, alpha:1.00)
            cb.separatorColor = UIColor(red:0.20, green:0.20, blue:0.25, alpha:1.00)
        }

        // Create buttons
        let buttonOne = CancelButton(title: "확인") {
            print("You canceled the car dialog.")
        }


//        let buttonThree = DefaultButton(title: "BUY CAR", height: 60) {
//            print("Ah, maybe next time :)")
//        }

        // Add buttons to dialog
        // Alternatively, you can use popup.addButton(buttonOne)
        // to add a single button
        popup.addButtons([buttonOne])

        // Present dialog
        self.present(popup, animated: true, completion: nil)
    }
    
    func clearNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    
    func dismissKeyboardWhenTappingAround() {
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
//        tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
        
    }
    
    func moveViewWhenKeyboardIsShown() {
        // call the 'keyboardWillShow' function when the view controller receive notification that keyboard is going to be shown
            NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
            NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           // if keyboard size is not available for some reason, dont do anything
           return
        }
      
      // move the root view up by the distance of keyboard height
      self.view.frame.origin.y = 0 - keyboardSize.height / 2
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
      self.view.frame.origin.y = 0
    }
}


extension UIColor {
    static let opacityDarkColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
}


extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}
