//
//  ChatLoadViewController.swift
//  TheGrow
//
//  Created by Buzzware Tech on 30/05/2021.
//  Copyright © 2021 Buzzware. All rights reserved.
//

import UIKit

class ChatLoadViewController: UIViewController {

    @IBOutlet weak var ChatContainerVIew: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadChatViewController()
    }
    func loadChatViewController() {
        let vc = (storyboard?.instantiateViewController(withIdentifier: "ChatVC"))!
        self.addChild(vc)
        vc.view.frame = CGRect(x: 0, y: 0, width: self.ChatContainerVIew.frame.size.width, height: self.ChatContainerVIew.frame.size.height);
        self.ChatContainerVIew.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    @IBAction func SideMenuBtn(_ sender:Any){
        self.sideMenuController?.toggleLeftView(animated: true, completion: nil)
    }
}
