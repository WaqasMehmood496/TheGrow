//
//  ChatViewController.swift
//  AgoraCallingTesting
//
//  Created by Waqas on 03/03/2021.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import AVKit
import AVFoundation

var messageData:ChatListModel!

class ChatViewController: MessagesViewController, MessageCellDelegate, InputBarAccessoryViewDelegate, MessagesLayoutDelegate, MessagesDisplayDelegate {
    
    private var senderPhotoURL: URL?
    private var otherUserPhotoURL: URL?
    
    public static let dateFormatter: DateFormatter = {
        let formattre = DateFormatter()
        formattre.dateStyle = .medium
        formattre.timeStyle = .long
        formattre.locale = .current
        return formattre
    }()
    
    var dataDic:[String:Any]!
    public let otherUserEmail: String = ""
    //var messageData:ChatListModel!
    public var isNewConversation = false
    
    private var messages = [MessagesModel]()
    
    var selfSender: Sender? {
        if let id = CommonHelper.getCachedUserData()?.user_id {
            let name = CommonHelper.getCachedUserData()?.user_name
            let url = CommonHelper.getCachedUserData()?.image_url
            self.senderPhotoURL = URL(string: url ?? "")
            //return Sender(photoURL: url!,senderId: id,displayName: name!)
            // MARK:- -------------- CHANGE -------------------
            return Sender(photoURL: "", senderId: "1", displayName: "Abc")
        }
        else{
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //        let type = UserDefaults.standard.value(forKey: Constant.user_type) as! String
        //        self.userType = UserType(rawValue: type)
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messageCellDelegate = self
        messageInputBar.delegate = self
        self.navigationController?.navigationBar.isHidden = true
        setupInputButton()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        
        self.messagesCollectionView.keyboardDismissMode = .onDrag
        
        // MARK:- -------------- CHANGE -------------------
        //listenForMessages(shouldScrollToBottom: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        NotificationCenter.default.addObserver(self, selector: #selector(self.appendMessage(_:)), name: .messagingNotification, object: nil)
    }
    @objc func appendMessage(_ sender:Notification){
        if let message = sender.userInfo as NSDictionary?{
            if let name = message["name"] as? String{
                if messageData.userdetail.user_name == name{
                    let msg = message["msg"] as! String
                    let reciver = message["sender_id"] as! String
                    let messa = MessagesModel(sender: Sender(photoURL: "", senderId: reciver, displayName: ""), chat_id: "", date: Date(), kind: .text(msg), is_read: true, id: 0, receiver_id: Int64(self.selfSender!.senderId)!)
                    self.messages.append(messa)
                    self.messagesCollectionView.reloadDataAndKeepOffset()
                    self.messagesCollectionView.scrollToLastItem()
                }
            }
        }
    }
    
    @IBAction func BackBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    private func setupInputButton() {
        let button = InputBarButtonItem()
        button.setSize(CGSize(width: 35, height: 35), animated: false)
        button.setImage(UIImage(systemName: "paperclip"), for: .normal)
        button.onTouchUpInside { [weak self] _ in
            self?.presentInputActionSheet()
        }
        messageInputBar.setLeftStackViewWidthConstant(to: 36, animated: false)
        messageInputBar.setStackViewItems([button], forStack: .left, animated: false)
    }
    private func presentInputActionSheet() {
        let actionSheet = UIAlertController(title: "Attach Media",
                                            message: "What would you like to attach?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Photo", style: .default, handler: { [weak self] _ in
            self?.presentPhotoInputActionsheet()
        }))
        actionSheet.addAction(UIAlertAction(title: "Video", style: .default, handler: { [weak self]  _ in
            self?.presentVideoInputActionsheet()
        }))
        actionSheet.addAction(UIAlertAction(title: "Audio", style: .default, handler: {  _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Location", style: .default, handler: { [weak self]  _ in
            self?.presentLocationPicker()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true)
    }
    
    private func presentLocationPicker() {
        //let vc = LocationPickerViewController(coordinates: nil)
        //vc.title = "Pick Location"
        //vc.navigationItem.largeTitleDisplayMode = .never
        /*vc.completion = { [weak self] selectedCoorindates in
         
         guard let strongSelf = self else {
         return
         }
         
         guard let messageId = strongSelf.createMessageId(),
         let conversationId = strongSelf.conversationId,
         let name = strongSelf.title,
         let selfSender = strongSelf.selfSender else {
         return
         }
         
         let longitude: Double = selectedCoorindates.longitude
         let latitude: Double = selectedCoorindates.latitude
         
         print("long=\(longitude) | lat= \(latitude)")
         
         
         let location = Location(location: CLLocation(latitude: latitude, longitude: longitude),
         size: .zero)
         
         let message = Message(sender: selfSender,
         messageId: messageId,
         sentDate: Date(),
         kind: .location(location))
         
         DatabaseManager.shared.sendMessage(to: conversationId, otherUserEmail: strongSelf.otherUserEmail, name: name, newMessage: message, completion: { success in
         if success {
         print("sent location message")
         }
         else {
         print("failed to send location message")
         }
         })
         }*/
        //navigationController?.pushViewController(vc, animated: true)
    }
    
    private func presentPhotoInputActionsheet() {
        let actionSheet = UIAlertController(title: "Attach Photo",
                                            message: "Where would you like to attach a photo from",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self] _ in
            
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            picker.allowsEditing = true
            self?.present(picker, animated: true)
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { [weak self] _ in
            
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            self?.present(picker, animated: true)
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true)
    }
    
    private func presentVideoInputActionsheet() {
        let actionSheet = UIAlertController(title: "Attach Video",
                                            message: "Where would you like to attach a video from?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self] _ in
            
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            picker.mediaTypes = ["public.movie"]
            picker.videoQuality = .typeMedium
            picker.allowsEditing = true
            self?.present(picker, animated: true)
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Library", style: .default, handler: { [weak self] _ in
            
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            picker.mediaTypes = ["public.movie"]
            picker.videoQuality = .typeMedium
            self?.present(picker, animated: true)
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true)
    }
    
    private func listenForMessages(shouldScrollToBottom: Bool) {
        
        // MARK:- -------------- CHANGE -------------------
        //        self.dataDic = [String:Any]()
        //        self.dataDic[Constant.user_id] = selfSender?.senderId
        //        self.dataDic[Constant.selected_id] = messageData.userdetail.user_id
        //        self.callWebService(.chatSystem_read)
    }
    func callWebService(_ webserviceUrl:webserviceUrl){
        //PopupHelper.showAnimating(self)
        WebServicesHelper.callWebService(Parameters:self.dataDic,action: webserviceUrl, httpMethodName: .post) { (indx,action,isNetwork, error, dataDict) in
            //self.stopAnimating()
            if isNetwork{
                if let err = error{
                    print(err)
                    //PopupHelper.showAlertControllerWithError(forErrorMessage: err, forViewController: self)
                }
                else{
                    if let dic = dataDict as? Dictionary<String,Any>{
                        if let arrays = dic[Constant.message] as? NSArray{
                            self.messages.removeAll()
                            for data in arrays{
                                self.messages.append(MessagesModel(dic: data as! NSDictionary)!)
                            }
                            self.messagesCollectionView.reloadDataAndKeepOffset()
                            self.messagesCollectionView.scrollToLastItem()
                            self.messageInputBar.inputTextView.becomeFirstResponder()
                        }
                        else if let msg = dic[Constant.message] as? String{
                            print(msg)
                        }
                    }
                    else{
                        print("something went wrong")
                        //PopupHelper.showAlertControllerWithError(forErrorMessage: "something went wrong", forViewController: self)
                    }
                }
            }
            else{
                print("Please connect your internet connection")
                //PopupHelper.alertWithNetwork(title: "Network Connection", message: "Please connect your internet connection", controler: self)
            }
        }
    }
    func callWebService(webserviceUrl:webserviceUrl){
        //PopupHelper.showAnimating(self)
        WebServicesHelper.callWebService(Parameters:self.dataDic,action: webserviceUrl, httpMethodName: .post) { (indx,action,isNetwork, error, dataDict) in
            //self.stopAnimating()
            if isNetwork{
                if let err = error{
                    print(err)
                    //PopupHelper.showAlertControllerWithError(forErrorMessage: err, forViewController: self)
                }
                else{
                    if let dic = dataDict as? Dictionary<String,Any>{
                        if let arrays = dic[Constant.message] as? NSArray{
                            self.messages.removeAll()
                            for data in arrays{
                                self.messages.append(MessagesModel(dic: data as! NSDictionary)!)
                            }
                            self.messagesCollectionView.reloadDataAndKeepOffset()
                            
                            self.messagesCollectionView.scrollToLastItem()
                            self.messageInputBar.inputTextView.becomeFirstResponder()
                            
                        }
                        else if let msg = dic[Constant.message] as? String{
                            print(msg)
                            //PopupHelper.showAlertControllerWithError(forErrorMessage: msg, forViewController: self)
                        }
                    }
                    else{
                        print("something went wrong")
                        // PopupHelper.showAlertControllerWithError(forErrorMessage: "something went wrong", forViewController: self)
                    }
                }
            }
            else{
                print("Please connect your internet connection")
                //PopupHelper.alertWithNetwork(title: "Network Connection", message: "Please connect your internet connection", controler: self)
                
            }
        }
    }
    
}

extension ChatViewController {
    
    override func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let messageId:String? = "1", let conversationId = messageData.convarsation_id, let name = self.title, let selfSender = selfSender else {
            return
        }
        
        if let image = info[.editedImage] as? UIImage, let imageData =  image.pngData() {
            let fileName = "photo_message_" + messageId!.replacingOccurrences(of: " ", with: "-") + ".png"
            
        }
        else if let videoUrl = info[.mediaURL] as? URL {
            let fileName = "photo_message_" + messageId!.replacingOccurrences(of: " ", with: "-") + ".mov"
        }
    }
}

extension ChatViewController {
    
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        guard !text.replacingOccurrences(of: " ", with: "").isEmpty else{
            return
        }
        
        print("Sending: \(text)")
        
        //let conversationId = Int64(self.messageData.convarsation_id!)
        
        // MARK:- -------------- CHANGE -------------------
        let messages = MessagesModel(sender: self.selfSender!, chat_id: "", date: Date(), kind: .text(text), is_read: false, id: 0, receiver_id: 1)
        //Int64(messageData.reciver_id!)!
        
        self.messages.append(messages)
        
        //MARK:- CHANGE
        //        self.dataDic = [String:Any]()
        //        guard let senderId = self.selfSender?.senderId else { return }
        //        guard let reciverId = messageData.userdetail.user_id else { return }
        //        self.dataDic[Constant.selected_id] = reciverId
        //        self.dataDic[Constant.user_id] = senderId
        //        self.dataDic[Constant.msg] = text
        //        self.callWebService(webserviceUrl: .chatSystem_insert)
        self.messagesCollectionView.reloadDataAndKeepOffset()
        self.messagesCollectionView.scrollToLastItem()
        self.messageInputBar.inputTextView.text = nil
    }
}


//MARK:- MESSAGE DATASOURCE EXTENSION
extension ChatViewController: MessagesDataSource {
    
    func currentSender() -> SenderType {
        if let sender = selfSender {
            return sender
        }
        
        fatalError("Self Sender is nil, email should be cached")
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func configureMediaMessageImageView(_ imageView: UIImageView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        guard let message = message as? MessagesModel else {
            return
        }
        switch message.kind {
        case .photo(let media):
            guard let imageUrl = media.url else {
                return
            }
            imageView.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "card_bg"))
        default:
            break
        }
    }
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        let sender = message.sender
        if sender.senderId == selfSender?.senderId {
            // our message that we've sent
            if #available(iOS 13.0, *) {
                return .link
            } else {
                // Fallback on earlier versions
                return #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            }
        }
        
        if #available(iOS 13.0, *) {
            return .secondarySystemBackground
        } else {
            // Fallback on earlier versions
            return #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        }
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        let sender = message.sender
        
        let place = #imageLiteral(resourceName: "ic_chat")
        if sender.senderId == selfSender?.senderId {
            // show our image
            if let currentUserImageURL = self.senderPhotoURL {
                //avatarView.sd_setImage(with: currentUserImageURL, completed: nil)
                avatarView.sd_setImage(with: currentUserImageURL, placeholderImage: #imageLiteral(resourceName: "ic_chat"))
            }
            else {
                avatarView.image = place
            }
        }
        else {
            // other user image
            if let otherUsrePHotoURL = self.otherUserPhotoURL {
                avatarView.sd_setImage(with: otherUsrePHotoURL, placeholderImage: #imageLiteral(resourceName: "ic_chat"))
            }
            else {
                // fetch url
                avatarView.image = place
            }
        }
    }
}

extension ChatViewController {
    
    func didTapMessage(in cell: MessageCollectionViewCell) {
        guard let indexPath = messagesCollectionView.indexPath(for: cell) else {
            return
        }
        let message = messages[indexPath.section]
        
        switch message.kind {
        case .location(let locationData):
            let coordinates = locationData.location.coordinate
        //let vc = LocationPickerViewController(coordinates: coordinates)
        
        //vc.title = "Location"
        //navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    func didTapImage(in cell: MessageCollectionViewCell) {
        guard let indexPath = messagesCollectionView.indexPath(for: cell) else {
            return
        }
        
        let message = messages[indexPath.section]
        
        switch message.kind {
        case .photo(let media):
            guard let imageUrl = media.url else {
                return
            }
        //        let vc = PhotoViewerViewController(with: imageUrl)
        //        navigationController?.pushViewController(vc, animated: true)
        case .video(let media):
            guard let videoUrl = media.url else {
                return
            }
            let vc = AVPlayerViewController()
            vc.player = AVPlayer(url: videoUrl)
            present(vc, animated: true)
        default:
            break
        }
    }
}
