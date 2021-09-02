//
//  ForgotPasswordViewController.swift
//  TheGrow
//
//  Created by Waqas on 12/01/2021.
//  Copyright © 2021 Buzzware. All rights reserved.
//

import UIKit
import JGProgressHUD

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var SendEmailBtn: UIButton!
    
    let hud = JGProgressHUD()
    var dataDic = [String:Any]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SendEmailBtn.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: self.SendEmailBtn.frame, andColors: [UIColor().colorsFromAsset(name: .login),UIColor().colorsFromAsset(name: .themeColor)])
    }
    
    @IBAction func sendEmailBtnAction(_ sender: Any) {
        // forgetApi()
        forgotApiApiCall()
    }
}


//MARK:- API CALLING METHOD'S
extension ForgotPasswordViewController {
    
    func forgotApiApiCall() {
        showHUDView(hudIV: .indeterminate, text: .process) { (hud) in
            hud.show(in: self.view, animated: true)
            
            let email = self.tfEmail.text!
            if !self.tfEmail.isValid() {
                hud.textLabel.text = "Email field is incorrect"
                hud.indicatorView = JGProgressHUDErrorIndicatorView()
                hud.dismiss(afterDelay: 2, animated: true)
            } else {
                if Connectivity.isConnectedToNetwork(){
                    self.dataDic = [String:Any]()
                    self.dataDic[Constant.user_email] = email
                    self.callWebService(.forgetPassword, hud: hud)
                }else{
                    hud.textLabel.text = "You are not connected to the internet. Please check your connection"
                    hud.indicatorView = JGProgressHUDErrorIndicatorView()
                    hud.dismiss(afterDelay: 2, animated: true)
                }
            }
        }
    }
}



// MARK:- WEBSERVICE DELEGATE METHOD'S EXTENSION
extension ForgotPasswordViewController:WebServiceResponseDelegate {
    
    func callWebService(_ url:webserviceUrl,hud: JGProgressHUD){
        
        let helper = WebServicesHelper(serviceToCall: url, withMethod: .post, havingParameters: self.dataDic, relatedViewController: self,hud: hud)
        helper.delegateForWebServiceResponse = self
        helper.callWebService()
    }
    
    func webServiceDataParsingOnResponseReceived(url: webserviceUrl?, viewControllerObj: UIViewController?, dataDict: Any, hud: JGProgressHUD) {
        switch url {
        case .forgetPassword:
            hud.textLabel.text = "Verification link is sended, Please check your email"
            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
            hud.dismiss(afterDelay: 2, animated: true)
        default:
            hud.dismiss()
        }
    }
}
