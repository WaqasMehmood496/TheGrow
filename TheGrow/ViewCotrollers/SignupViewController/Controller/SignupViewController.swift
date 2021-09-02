//
//  SignupViewController.swift
//  TastyBox
//
//  Created by Adeel on 14/05/2020.
//  Copyright © 2020 Buzzware. All rights reserved.
//

import UIKit
import JGProgressHUD
import LGSideMenuController
import FirebaseMessaging
import JGProgressHUD

class SignupViewController: UIViewController {
    
    @IBOutlet weak var tfUserName:UITextField!
    @IBOutlet weak var tfEmail:UITextField!
    @IBOutlet weak var tfPassword:UITextField!
    @IBOutlet weak var tfPhoneNumber:UITextField!
    @IBOutlet weak var btnSignup:UIButton!
    
    var loginUser : LoginModel!
    var dataDic:[String:String]!
    let hud = JGProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.btnSignup.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: self.btnSignup.frame, andColors: [UIColor().colorsFromAsset(name: .login),UIColor().colorsFromAsset(name: .themeColor)])
    }
    
    @IBAction func signupBtnPressed(_ sender:Any) {
        signUpApi()
    }
}

//MARK:- HELPING METHOD'S
extension SignupViewController {
    func changeVC(identifier:String){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: identifier)
        UIApplication.shared.windows.first?.rootViewController = viewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}



//MARK:- API CALLING METHOD'S
extension SignupViewController {
    func signUpApi() {
        showHUDView(hudIV: .indeterminate, text: .LoadingTastybox) { (hud) in
            hud.show(in: self.view, animated: true)
            
            if !self.tfUserName.isValid() || !self.tfEmail.isValid() || !self.tfEmail.text!.isValidEmail() || !self.tfPassword.isValid() {
                hud.textLabel.text = "Please fill all field of column"
                hud.indicatorView = JGProgressHUDErrorIndicatorView()
                hud.dismiss(afterDelay: 2, animated: true)
            } else {
                if Connectivity.isConnectedToNetwork() {
                    self.dataDic = [String:String]()
                    self.dataDic = [
                        Constant.user_name: self.tfUserName.text!,
                        Constant.user_email: self.tfEmail.text!,
                        Constant.user_password: self.tfPassword.text!,
                        Constant.phone_number: self.tfPhoneNumber.text!
                    ]
                    self.getSignupWebservice(.normal,hud: hud)
                } else {
                    hud.textLabel.text = "No Internet Connection"
                    hud.indicatorView = JGProgressHUDErrorIndicatorView()
                    hud.dismiss(afterDelay: 2, animated: true)
                }
            }
        }
    }
}


//MARK:- WEBSERVICE DELEGATE METHOD'S
extension SignupViewController:WebServiceResponseDelegate {
    
    func getSignupWebservice(_ url:webserviceUrl, hud: JGProgressHUD){
        
        let helper = WebServicesHelper(serviceToCall: url, withMethod: .post, havingParameters: self.dataDic, relatedViewController: self,hud: hud)
        helper.delegateForWebServiceResponse = self
        helper.callWebService()
    }
    
    func webServiceDataParsingOnResponseReceived(url: webserviceUrl?, viewControllerObj: UIViewController?, dataDict: Any, hud: JGProgressHUD) {
        switch url {
        case .normal:
            if let data = dataDict as? Dictionary<String, Any>{
                if let users = data["user_detail"] as? Dictionary<String, Any>{
                    print(LoginModel(dic: users as NSDictionary))
                    let user = LoginModel(dic: users as NSDictionary)
                    print(user!)
                    CommonHelper.saveCachedUserData(user!)
                    self.changeVC(identifier: Constant.LGSideMenu)
                    hud.dismiss()
                }
            }
        default:
            hud.dismiss()
        }
    }
}
