//
//  SignInViewController.swift
//  TastyBox
//
//  Created by Adeel on 11/04/2020.
//  Copyright © 2020 Buzzware. All rights reserved.
//

import UIKit
import JGProgressHUD
import LGSideMenuController
import FirebaseMessaging
import AuthenticationServices
import ChameleonFramework

class SignInViewController: UIViewController {
    // MARK: IBOUTLETS
    @IBOutlet weak var tfEmail:UITextField!
    @IBOutlet weak var tfPassword:UITextField!
    @IBOutlet weak var btnSignin:UIButton!
    
    // MARK: VARIABLES
    let hud = JGProgressHUD()
    var dataDic = [String:Any]()
    var loginUser : LoginModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.btnSignin.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: self.btnSignin.frame, andColors: [UIColor().colorsFromAsset(name: .login),UIColor().colorsFromAsset(name: .themeColor)])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //self.pagerView.selectItem(at: 0, animated: true)
    }
    
    // MARK: IBACTIONS
    @IBAction func loginBtnPressed(_ sender:Any){
        loginApiCall()
    }
    
    @IBAction func signupBtnPressed(_ sender:Any){
        print("Btn Press")
        self.performSegue(withIdentifier: "toSignup", sender: nil)
    }
    
    @IBAction func forgotPasswordBtnAction(_ sender: Any) {
        self.performSegue(withIdentifier: "toForgetPassword", sender: nil)
    }
    
}



// MARK:- HELPING METHOD'S EXTESNIOS
extension SignInViewController{
    func changeVC(identifier:String){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: identifier)
        UIApplication.shared.windows.first?.rootViewController = viewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}



//MARK:- API CALLING METHOD'S
extension SignInViewController {
    
    func loginApiCall() {
        showHUDView(hudIV: .indeterminate, text: .process) { (hud) in
            hud.show(in: self.view, animated: true)
            
            let email = self.tfEmail.text!
            let password = self.tfPassword.text!
            if !self.tfEmail.isValid() || !self.tfPassword.isValid(){
                
                hud.textLabel.text = "Email and password field is incorrect"
                hud.indicatorView = JGProgressHUDErrorIndicatorView()
                hud.dismiss(afterDelay: 2, animated: true)
                
            }
            else{
                if Connectivity.isConnectedToNetwork(){
                    self.dataDic = [String:Any]()
                    self.dataDic[Constant.user_email] = email
                    self.dataDic[Constant.user_password] = password
                    self.callWebService(.login, hud: hud)
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
extension SignInViewController:WebServiceResponseDelegate {
    
    func callWebService(_ url:webserviceUrl,hud: JGProgressHUD){
        
        let helper = WebServicesHelper(serviceToCall: url, withMethod: .post, havingParameters: self.dataDic, relatedViewController: self,hud: hud)
        helper.delegateForWebServiceResponse = self
        helper.callWebService()
    }
    func webServiceDataParsingOnResponseReceived(url: webserviceUrl?, viewControllerObj: UIViewController?, dataDict: Any, hud: JGProgressHUD) {
        switch url {
        case .login:
            if let data = dataDict as? Dictionary<String, Any>{
                if let users = data["user_detail"] as? Dictionary<String, Any>{
                    let user = LoginModel(dic: users as NSDictionary)
                    print(user!)
                    CommonHelper.saveCachedUserData(user!)
                    hud.dismiss()
                    self.changeVC(identifier: Constant.LGSideMenu)
                } else {
                    hud.textLabel.text = "Email and password field is incorrect"
                    hud.indicatorView = JGProgressHUDErrorIndicatorView()
                    hud.dismiss(afterDelay: 2, animated: true)
                }
            }
        default:
            hud.dismiss()
        }
    }
}
