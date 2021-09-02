//
//  UpdateProfileVC.swift
//  TheGrow
//
//  Created by Waqas on 15/01/2021.
//  Copyright © 2021 Buzzware. All rights reserved.
//

import UIKit

class UpdateProfileVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //updateProfileCalling()
    }
}


//// MARK:- FUNCTIONS
//extension UpdateProfileVC{
//    func updateProfileCalling() {
//
////        let email = tfEmail.text!
////        let password = tfPassword.text!
//        //var userDataArray = [LoginModel]()
//       // if email != "" && password != ""{
//            let headers = ["Accept":"application/json","Content-Type":"application/x-www-form-urlencoded"]
//            let parameter = ["user_name":"Rehan","user_password":"123456","phone_number":"03035107586"]
//            //self.hud.show(in: self.view)
//            if Connectivity.isConnectedToNetwork(){
//                // ActivityIndicatorView.startAnimating()
//                AlamoHelper.PostRequest(Url: Constant.base_Url+"update_profile/8", Parm: parameter, Header: headers) { (JSON) in
//
//                    print(JSON)
//
////                    let userData = LoginModel()
////                    userData.user_id = JSON["return_data"]["user_detail"]["user_id"].stringValue
////                    print(JSON["return_data"]["user_detail"]["image_url"].stringValue)
////                    userData.user_name = JSON["return_data"]["user_detail"]["user_name"].stringValue
////                    userData.user_email = JSON["return_data"]["user_detail"]["user_email"].stringValue
////                    userData.user_password = JSON["return_data"]["user_detail"]["user_password"].stringValue
////                    userData.token_id = JSON["return_data"]["user_detail"]["token_id"].stringValue
////                    userData.status = JSON["return_data"]["user_detail"]["status"].stringValue
////                    userData.image_url = JSON["return_data"]["user_detail"]["image_url"].stringValue
////                    userData.user_type = JSON["return_data"]["user_detail"]["user_type"].stringValue
////                    userData.login_type = JSON["return_data"]["user_detail"]["login_type"].stringValue
////                    userData.phone_number = JSON["return_data"]["user_detail"]["phone_number"].stringValue
////                    userData.oath_id = JSON["return_data"]["user_detail"]["oath_id"].stringValue
////                    userData.paid = JSON["return_data"]["user_detail"]["paid"].stringValue
////                    LoginModel.SaveData(Data: userData, key: Constant.user_Cache_Key)
////                    Constant.userDefault.set(true, forKey: Constant.is_User_Login_Key)
////                    self.hud.removeFromSuperview()
////                    self.changeRootVC()
//                    //self.performSegue(withIdentifier: "toDash", sender: nil)
//                }
//            }else{
//                // Show toast message
//                print("Network not found")
//                //ShowAlert(view: self, message: "You are not connected to the internet. Please check your connection", Title: "Network Connection Error")
//            }
////        }else{
////            print("Name And Password Textfield is empty")
////            //ShowAlert(view: self, message: "Email and password field is empty", Title: "Field Empty")
////        }
//    }
//}
