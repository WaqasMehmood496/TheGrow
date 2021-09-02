//
//  ChatMode.swift
//  Random VIdeo Call
//
//  Created by Buzzware Tech on 03/04/2021.
//  Copyright © 2021 Mecus. All rights reserved.
//

import Foundation

class ChatListModel:Codable {
    
    var convarsation_id:String!
    var sender_id:String!
    var reciver_id:String!
    var last_massage:String!
    var date:String!
    var userdetail:UserDetailModel!
    
    init(convarsation_id: String? = nil,sender_id: String? = nil,reciver_id: String? = nil,last_massage: String? = nil,date: String? = nil,userdetail: UserDetailModel? = nil) {
        
        self.convarsation_id             = convarsation_id
        self.sender_id        = sender_id
        self.reciver_id        = reciver_id
        self.last_massage    = last_massage
        self.date     = date
        self.userdetail     = userdetail
    }
    
    init?(dic:NSDictionary) {
        
        
        let convarsation_id = (dic as AnyObject).value(forKey: Constant.convarsation_id) as? String
        let sender_id = (dic as AnyObject).value(forKey: Constant.sender_id) as? String
        let reciver_id = (dic as AnyObject).value(forKey: Constant.reciver_id) as? String
        let last_massage = (dic as AnyObject).value(forKey: Constant.last_massage) as? String
        let date = (dic as AnyObject).value(forKey: Constant.date) as? String
        if let userdetail = (dic as AnyObject).value(forKey: Constant.userdetail) as? NSDictionary{
            let detail = UserDetailModel(dic: userdetail)
            
            self.userdetail         = detail
        }
        
        
        
        self.convarsation_id    = convarsation_id
        self.sender_id          = sender_id
        self.reciver_id         = reciver_id
        self.last_massage       = last_massage
        self.date               = date
        
    }
}


class UserDetailModel: Codable {
    
    var user_name:String!
    var user_id:String!
    var good_photos:String!
    var gander:String!
    
    init(user_name: String? = nil,user_id: String? = nil,good_photos: String? = nil,gander: String? = nil) {
        
        self.user_name      = user_name
        self.user_id        = user_id
        self.good_photos    = good_photos
        self.gander         = gander
        
    }
    init?(dic:NSDictionary) {
        
        let user_name   = (dic as AnyObject).value(forKey: Constant.user_name) as? String
        let user_id     = (dic as AnyObject).value(forKey: Constant.user_id) as? String
        let good_photos = (dic as AnyObject).value(forKey: Constant.good_photos) as? String
        let gander      = (dic as AnyObject).value(forKey: Constant.gander) as? String
        
        
        self.user_name      = user_name
        self.user_id        = user_id
        self.good_photos    = good_photos
        self.gander         = gander
    }
}
