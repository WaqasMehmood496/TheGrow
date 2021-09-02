//
//  PopupHelper.swift
//  TradeAir
//
//  Created by Adeel on 08/10/2019.
//  Copyright © 2019 Buzzware. All rights reserved.
//

import UIKit
import STPopup
import SwiftEntryKit

class PopupHelper
{
    /// Show a popup using the STPopup framework [STPopup on Cocoapods](https://cocoapods.org/pods/STPopup)
    /// - parameters:
    ///   - storyBoard: the name of the storyboard the popup viewcontroller will be loaded from
    ///   - popupName: the name of the viewcontroller in the storyboard to load
    ///   - viewController: the viewcontroller the popup will be popped up from
    ///   - blurBackground: boolean to indicate if the background should be blurred
    /// - returns: -
    static let sharedInstance = PopupHelper() //<- Singleton Instance
    
    private init() { /* Additional instances cannot be created */ }
    static func alertWithField(title: String,message: String,qty: String,unit: String,part: String){
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Quantity"
            textField.text = qty
            textField.placeHolderColor = UIColor().colorsFromAsset(name: .themeColor)
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Unit"
            textField.text = unit
            textField.placeHolderColor = UIColor().colorsFromAsset(name: .themeColor)
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Part"
            textField.text = part
            textField.placeHolderColor = UIColor().colorsFromAsset(name: .themeColor)
        }
        let saveAction = UIAlertAction.init(title: "Save", style: .default) { (alertAction) in
            
        }
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .default) { (alertAction) in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        
    }
    static func alertWithOk(title: String,message: String,controler:UIViewController){
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        let saveAction = UIAlertAction.init(title: "Ok", style: .default) { (alertAction) in
            controler.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(saveAction)
        controler.present(alertController, animated: true, completion: nil)
        
        
        
    }
//    static func alertVerifyViewController(_ userServiceData:Bool? = nil,controler:UIViewController){
//
//        //let navcontroler = controler.storyboard?.instantiateViewController(identifier: "NavBookingViewController") as! UINavigationController
//        let control = controler.storyboard?.instantiateViewController(identifier: "VerifyRefeulViewController") as! VerifyRefeulViewController
//        control.delegate = controler
//        let popupController = STPopupController(rootViewController: control)
//
//        var size = CGSize(width: controler.view.frame.width/1.1, height: controler.view.frame.height/1.1)
//        if UIDevice.current.userInterfaceIdiom == .phone{
//            size.height = controler.view.frame.height/1.1
//
//        }
//        else{
//            size.height = controler.view.frame.height/0.5
//        }
//        control.contentSizeInPopup = size
//        //popupController.topViewController?.contentSizeInPopup = CGSize(width: controler.view.frame.width/1.1, height: controler.view.frame.height/1.1)
//        popupController.navigationBarHidden = true
//        popupController.topViewController?.view.backgroundColor = .clear
//        let blurEffect = UIBlurEffect(style: .dark)
//        popupController.backgroundView = UIVisualEffectView(effect: blurEffect)
//        popupController.containerView.backgroundColor = .clear
//        control.popup = popupController
//        popupController.present(in: controler)
//
//    }
    
    static func alertTimerView(title:String,msg:String,image:String,controler:UIViewController){
        
        var attributes = EKAttributes.centerFloat
                
        attributes.name = "Top Note"
        attributes.windowLevel = .alerts
        attributes.position = .center
        attributes.precedence = .override(priority: .max, dropEnqueuedEntries: false)
        attributes.precedence.priority = .high
        attributes.displayDuration = .infinity
        attributes.entryBackground = .color(color: .white)
                
        attributes.entryInteraction = .dismiss
        attributes.screenInteraction = .dismiss
        attributes.roundCorners = .all(radius: 10)
        attributes.entryBackground = .clear
        attributes.screenBackground = .color(color: EKColor(UIColor(white: 0.0, alpha: 0.5)))
        

        
        let view = Bundle.main.loadNibNamed("ExerciseClockView", owner: controler, options: nil)?.first as! ExerciseClockView
        view.layer.cornerRadius = 25
        //view.frame.size = CGSize(width: controler.view.frame.size.width * 1.1, height: controler.view.frame.size.height * 1.3)
        SwiftEntryKit.display(entry: view, using: attributes)
        
    }
}

