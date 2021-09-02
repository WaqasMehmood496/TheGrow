//
//  LoginModel.swift
//  TastyBox
//
//  Created by Adeel on 11/05/2020.
//  Copyright © 2020 Buzzware. All rights reserved.
//

import UIKit

class LoginModel: Codable {
    
    var user_id:String!
    var user_name:String!
    var user_email:String!
    var user_password:String!
    var token_id:String!
    var status:String!
    var image_url:String!
    var user_type:String!
    var login_type:String!
    var phone_number:String!
    var oath_id:String!
    var paid:String!
    
    init(id: String,user_id:String,user_name:String,user_email:String,user_password:String,token_id:String,status:String,image_url:String,user_type:String,login_type:String,phone_number:String,oath_id:String,paid:String) {
        
        self.user_id = user_id
        self.user_name = user_name
        self.user_email = user_email
        self.user_password = user_password
        self.token_id = token_id
        self.status = status
        self.image_url = image_url
        self.user_type = user_type
        self.login_type = login_type
        self.phone_number = phone_number
        self.oath_id = oath_id
        self.paid = paid
    }
    
    init?(dic:NSDictionary) {
        
        let user_id = (dic as AnyObject).value(forKey: Constant.user_id) as? String
        let user_name = (dic as AnyObject).value(forKey: Constant.user_name) as? String
        let user_email = (dic as AnyObject).value(forKey: Constant.user_email) as? String
        let user_password = (dic as AnyObject).value(forKey: Constant.user_password) as? String
        let token_id = (dic as AnyObject).value(forKey: Constant.token_id) as? String
        let status = (dic as AnyObject).value(forKey: Constant.status) as? String
        let image_url = (dic as AnyObject).value(forKey: Constant.image_url) as? String
        let user_type = (dic as AnyObject).value(forKey: Constant.user_type) as? String
        let login_type = (dic as AnyObject).value(forKey: Constant.login_type) as? String
        let phone_number = (dic as AnyObject).value(forKey: Constant.phone_number) as? String
        let oath_id = (dic as AnyObject).value(forKey: Constant.oath_id) as? String
        let paid = (dic as AnyObject).value(forKey: Constant.paid) as? String
        
        self.user_id = user_id
        self.user_name = user_name
        self.user_email = user_email
        self.user_password = user_password
        self.token_id = token_id
        self.status = status
        self.image_url = image_url
        self.user_type = user_type
        self.login_type = login_type
        self.phone_number = phone_number
        self.oath_id = oath_id
        self.paid = paid
    }
}


//    var user_id = ""
//    var user_name = ""
//    var user_email = ""
//    var user_password = ""
//    var token_id = ""
//    var status = ""
//    var image_url = ""
//    var user_type = ""
//    var login_type = ""
//    var phone_number = ""
//    var oath_id = ""
//    var paid = ""
//
//    override init(){
//        user_id = ""
//        user_name = ""
//        user_email = ""
//        user_password = ""
//        token_id = ""
//        status = ""
//        image_url = ""
//        user_type = ""
//        login_type = ""
//        phone_number = ""
//        oath_id = ""
//        paid = ""
//
//    }
//    init(name: String, user_name: String, user_email: String, user_password: String, token_id: String, status: String, image_url: String, user_type: String, login_type:String, phone_number:String, oath_id:String, paid:String) {
//        self.user_id = name
//        self.user_name = user_name
//        self.user_email = user_email
//        self.user_password = user_password
//        self.token_id = token_id
//        self.status = status
//        self.image_url = image_url
//        self.user_type = user_type
//        self.login_type = login_type
//        self.phone_number = phone_number
//        self.oath_id = oath_id
//        self.paid = paid
//
//    }
//    init(Data:LoginModel){
//        user_id = Data.user_id
//        user_name = Data.user_name
//        user_email = Data.user_email
//        user_password = Data.user_password
//        token_id = Data.token_id
//        status = Data.status
//        image_url = Data.image_url
//        user_type = Data.user_type
//        login_type = Data.login_type
//        phone_number = Data.phone_number
//        oath_id = Data.oath_id
//        paid = Data.paid
//    }
//
//    required convenience init(coder aDecoder: NSCoder)
//    {
//        let obj = LoginModel()
//        obj.user_id = aDecoder.decodeObject(forKey: "user_id") as? String ?? ""
//        obj.user_name = aDecoder.decodeObject(forKey: "user_name") as? String ?? ""
//        obj.user_email = aDecoder.decodeObject(forKey: "user_email") as? String ?? ""
//        obj.token_id = aDecoder.decodeObject(forKey: "token_id") as? String ?? ""
//        obj.status = aDecoder.decodeObject(forKey: "status") as? String ?? ""
//        obj.image_url = aDecoder.decodeObject(forKey: "image_url") as? String ?? ""
//        obj.user_type = aDecoder.decodeObject(forKey: "user_type") as? String ?? ""
//        obj.login_type = aDecoder.decodeObject(forKey: "login_type") as? String ?? ""
//        obj.phone_number = aDecoder.decodeObject(forKey: "phone_number") as? String ?? ""
//        obj.oath_id = aDecoder.decodeObject(forKey: "oath_id") as? String ?? ""
//        obj.paid = aDecoder.decodeObject(forKey: "paid") as? String ?? ""
//
//        //obj.StreamImage = aDecoder.decodeObject(forKey: "StreamImage") as? UIImage ?? #imageLiteral(resourceName: "splash")
//
//        self.init(Data:obj)
//    }
//    func encode(with aCoder: NSCoder)
//    {
//        aCoder.encode(self.user_id, forKey: "user_id")
//        aCoder.encode(self.user_name, forKey: "user_name")
//        aCoder.encode(self.user_email, forKey: "user_email")
//        aCoder.encode(self.user_password, forKey: "user_password")
//        aCoder.encode(self.token_id, forKey: "token_id")
//        aCoder.encode(self.status, forKey: "status")
//        aCoder.encode(self.image_url, forKey: "image_url")
//        aCoder.encode(self.user_type, forKey: "user_type")
//        aCoder.encode(self.login_type, forKey: "login_type")
//        aCoder.encode(self.phone_number, forKey: "phone_number")
//        aCoder.encode(self.oath_id, forKey: "oath_id")
//        aCoder.encode(self.paid, forKey: "paid")
//
//    }
//
//    static func LoadData(key:String) -> LoginModel{
//        if let DataFromCache = UserDefaults.standard.object(forKey: "\(key)_List") as? Data
//        {
//            let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: DataFromCache) as! LoginModel
//            return decodedTeams
//        }
//        else
//        {
//            return LoginModel()
//        }
//    }
//
//    static func SaveData(Data:LoginModel,key:String)
//    {
//        // load data for not network time
//        let userDefaults = UserDefaults.standard
//        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: Data)
//        userDefaults.set(encodedData, forKey: "\(key)_List")
//        userDefaults.synchronize()
//    }

