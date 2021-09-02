//
//  MessagesModel.swift
//  FreeLaunchService
//
//  Created by Adeel on 26/07/2020.
//  Copyright © 2020 Buzzware. All rights reserved.
//

import UIKit
import MessageKit
import CoreLocation
class MessagesModel: MessageType {

    public var sender: SenderType
    public var messageId: String
    public var sentDate: Date
    public var kind: MessageKind
    public var is_read: Bool!
    public var id: Int64!
    public var receiver_id: Int64!
    
    init(sender:Sender,chat_id:String,date:Date,kind:MessageKind,is_read:Bool,id:Int64,receiver_id:Int64) {
        self.messageId = chat_id
        self.sender = sender
        self.kind = kind
        self.sentDate = date
        self.is_read = is_read
        self.id = id
        self.receiver_id = receiver_id
    }
    
    init?(dic: NSDictionary) {
        
        if let id = (dic as AnyObject).value(forKey: Constant.chat_id) as? Int64{
            self.id = id
            self.messageId = "\(id)"
        }
        else{
            self.messageId = ""
        }
        if let receiver_id = (dic as AnyObject).value(forKey: Constant.reciver_id) as? Int64{
            self.receiver_id = receiver_id
        }
        if let message = (dic as AnyObject).value(forKey: Constant.msg) as? String{
            self.kind = .text(message)
        }
        else{
            self.kind = .text("")
        }
        
        if let created_at = (dic as AnyObject).value(forKey: Constant.date) as? String{
            self.sentDate = created_at.getDateTimeFromString()
        }
        else{
            self.sentDate = Date()
        }
        if let is_read = (dic as AnyObject).value(forKey: Constant.check_msg) as? Bool{
            self.is_read = is_read
        }
//        if let sender = (dic as AnyObject).value(forKey: Constant.user_id) as? NSDictionary{
//
//            if let id = (sender as AnyObject).value(forKey: Constant.id) as? Int64,let image_url = (sender as AnyObject).value(forKey: Constant.image_url) as? String,let first_name = (sender as AnyObject).value(forKey: Constant.first_name) as? String,let last_name = (sender as AnyObject).value(forKey: Constant.last_name) as? String{
//
//                self.sender = Sender(photoURL: image_url, senderId: "\(id)", displayName: first_name + " " + last_name)
//            }
//            else{
//                self.sender = Sender(photoURL: "", senderId: "", displayName: "")
//            }
//
//        }
        //else
        if let sender = (dic as AnyObject).value(forKey: Constant.user_id) as? String{
            self.sender = Sender(photoURL: "", senderId: sender, displayName: "")
        }
        else{
            self.sender = Sender(photoURL: "", senderId: "", displayName: "")
        }
        
    }
}
extension MessageKind {
    var messageKindString: String {
        switch self {
        case .text(_):
            return "text"
        case .attributedText(_):
            return "attributed_text"
        case .photo(_):
            return "photo"
        case .video(_):
            return "video"
        case .location(_):
            return "location"
        case .emoji(_):
            return "emoji"
        case .audio(_):
            return "audio"
        case .contact(_):
            return "contact"
        case .custom(_):
            return "customc"
        default:
            return ""
        }
    }
}

struct Sender: SenderType {
    public var photoURL: String
    public var senderId: String
    public var displayName: String
}
struct Receiver: SenderType {
    public var photoURL: String
    public var senderId: String
    public var displayName: String
}

struct Media: MediaItem {
    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize
}

struct Location: LocationItem {
    var location: CLLocation
    var size: CGSize
}
