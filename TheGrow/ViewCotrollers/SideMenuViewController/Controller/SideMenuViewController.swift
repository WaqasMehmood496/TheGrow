//
//  SideMenuViewController.swift
//  TastyBox
//
//  Created by Adeel on 11/04/2020.
//  Copyright © 2020 Buzzware. All rights reserved.
//

import UIKit
import LGSideMenuController
import JGProgressHUD

class SideMenuViewController: UIViewController {
    
    //MARK: IBOUTLET'S
    @IBOutlet weak var SideMenuTableView: UITableView!
    @IBOutlet weak var avatarView:UIImageView!
    @IBOutlet weak var avatarTap:UITapGestureRecognizer!
    @IBOutlet weak var UserName: UILabel!
    
    //MARK: VARIABEL'S
    var menuArray = [SideMenuModel]()
    var dataDic = [String:Any]()
    var selectedIndexPath :IndexPath? = IndexPath(row: 0, section: 0)
    var storyboardId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SideMenuTableView.tableFooterView = UIView()
        self.loadArray()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if let index = UserDefaults.standard.value(forKey: Constant.avatar) as? Int{
            self.avatarView.image = UIImage(named: "ic_avatar\(index)")
        }
        else{
            self.avatarView.image = UIImage(named: "ic_avatar7")
        }
        if let name = CommonHelper.getCachedUserData()?.user_name {
            self.UserName.text = name
        }
        self.view.layer.contents = #imageLiteral(resourceName: "main_bg").cgImage
    }
    
    func loadArray(){
//        if (UserDefaults.standard.value(forKey: Constant.user_id) as? String) != nil{
//            menuArray = [
//                SideMenuModel(name: "Home", img: "menu00", img1: "menu0"),
//                SideMenuModel(name: "My Profile", img: "menu44", img1: "menu4"),
//                SideMenuModel(name: "My Orders", img: "menu55", img1: "menu5"),
//                SideMenuModel(name: "Contact Us", img: "menu66", img1: "menu6"),
//                SideMenuModel(name: "Privacy Policy", img: "menu77", img1: "menu7"),
//                SideMenuModel(name: "Terms & Conditions", img: "menu88", img1: "menu8"),
//                SideMenuModel(name: "Logout", img: "menu99", img1: "menu9")
//            ]
//        }
//        else{
            menuArray = [
                SideMenuModel(name: "Home", img: "menu00", img1: "menu0"),
                SideMenuModel(name: "Grow Exercise", img: "menu44", img1: "menu4"),
                SideMenuModel(name: "Grow Mediation", img: "menu55", img1: "menu5"),
                SideMenuModel(name: "Grow Food Plan", img: "menu66", img1: "menu6"),
                SideMenuModel(name: "Grow Exercise Equipment", img: "menu77", img1: "menu7"),
                SideMenuModel(name: "Chat with Coach", img: "menu88", img1: "menu8"),
                SideMenuModel(name: "Membership", img: "menu88", img1: "menu8"),
                SideMenuModel(name: "Grow Education", img: "menu88", img1: "menu8")
            ]
       // }
    }
    
    @IBAction func avatarBtnPressed(_ sender: Any) {
        let navviewController =  self.storyboard!.instantiateViewController(identifier: "NavAvatarsViewController") as? UINavigationController
        let viewController =  self.storyboard!.instantiateViewController(identifier: "AvatarsViewController") as! AvatarsViewController
        viewController.delegate = self
        navviewController?.setViewControllers([viewController], animated: true)
        self.sideMenuController?.rootViewController = navviewController
        self.sideMenuController?.toggleLeftViewAnimated(sender: self)
    }
    
    @IBAction func SideMenuBtn(_ sender:Any){
        self.sideMenuController?.toggleLeftView(animated: true, completion: nil)
    }
    @IBAction func logoutBtnAction(_ sender: Any) {
        storyboardId = "LoginVC"
        CommonHelper.removeCachedUserData()
        self.changeRootVC()
    }
//    @IBAction func switchChanged(_ sender: UISwitch!) {
//        if let userid = UserDefaults.standard.value(forKey: Constant.user_id) as? String{
//            print("Switch value is \(sender.isOn)")
//            showHUDView(hudIV: .indeterminate, text: .LoadingTastybox) { (hud) in
//                hud.show(in: self.view, animated: true)
//                if(sender.isOn){
//                    UserDefaults.standard.set(true, forKey: Constant.isNotify)
//                    let token = UserDefaults.standard.value(forKey: Constant.token_id) as! String
//                    self.dataDic = [String:Any]()
//                    self.dataDic = [
//                        Constant.user_id:userid,
//                        Constant.token_id:token
//                    ]
//                }
//                else{
//                    UserDefaults.standard.set(false, forKey: Constant.isNotify)
//                    print("Off")
//                    self.dataDic = [String:Any]()
//                    self.dataDic = [
//                        Constant.user_id:userid,
//                        Constant.token_id:""
//                    ]
//                }
//                self.getNotifyWebservice(hud: hud)
//            }
//        }
//        else{
//            let viewController =  self.storyboard!.instantiateViewController(identifier: "SignInViewController") as! UINavigationController
//            self.present(viewController, animated: true) {
//                self.sideMenuController?.toggleLeftViewAnimated(sender: self)
//            }
//        }
//    }
}

//MARK:- WEBSERVICE DELEGATE AND METHID'S
extension SideMenuViewController: WebServiceResponseDelegate{
    func getNotifyWebservice(hud: JGProgressHUD){
        
        let helper = WebServicesHelper(serviceToCall: .add_token, withMethod: .post, havingParameters: self.dataDic, relatedViewController: self,hud: hud)
        helper.delegateForWebServiceResponse = self
        helper.callWebService()
    }
    
    func webServiceDataParsingOnResponseReceived(url: webserviceUrl?, viewControllerObj: UIViewController?, dataDict: Any, hud: JGProgressHUD) {
        if let data = dataDict as? Dictionary<String, Any>{
            
        }
        hud.dismiss(animated: true)
    }
    
    func changeRootVC() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: storyboardId)
        self.sideMenuController?.rootViewController = viewController
        self.sideMenuController?.toggleLeftViewAnimated(sender: self)
        
    }
}

//MARK:- UITABLEVIEW DELEGATE AND DATASOURCE
extension SideMenuViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SideMenuTableViewCell
        if (selectedIndexPath == indexPath){
            cell.isSelected = true
            cell.backgroundColor = UIColor().colorsFromAsset(name: .yellowColor)
            cell.dotView.backgroundColor = UIColor().colorsFromAsset(name: .themeColor)
        }
        else{
            cell.isSelected = false
            cell.backgroundColor = .clear
            cell.dotView.backgroundColor = .clear
        }
        cell.lblName.text = menuArray[indexPath.row].menuName
        //cell.lblName.font = font
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndexPath != nil {
            tableView.deselectRow(at: selectedIndexPath!, animated: true)
        }
        
        let cell = tableView.cellForRow(at: indexPath) as! SideMenuTableViewCell
        cell.isSelected = true
        selectedIndexPath = indexPath
        cell.backgroundColor = UIColor().colorsFromAsset(name: .yellowColor)
        cell.dotView.backgroundColor = UIColor().colorsFromAsset(name: .themeColor)
        tableView.reloadRows(at: tableView.indexPathsForVisibleRows!, with: .fade)
        
        let viewController: UINavigationController!
        let userDef = UserDefaults.standard
        
        switch indexPath.row {
        case 0:
            viewController =  self.storyboard!.instantiateViewController(identifier: "DashboardViewController") as? UINavigationController
            
            
            self.sideMenuController?.rootViewController = viewController
            self.sideMenuController?.toggleLeftViewAnimated(sender: self)
            
        case 1:
            if (userDef.value(forKey: Constant.user_id) as? String) != nil{
                viewController =  self.storyboard!.instantiateViewController(identifier: "ExerciseViewController") as? UINavigationController
                
                self.sideMenuController?.rootViewController = viewController
                self.sideMenuController?.toggleLeftViewAnimated(sender: self)
            }
            else{
                viewController =  self.storyboard!.instantiateViewController(identifier: "ExerciseViewController") as? UINavigationController
                
                self.sideMenuController?.rootViewController = viewController
                self.sideMenuController?.toggleLeftViewAnimated(sender: self)
            }
            
        case 2:
            if (userDef.value(forKey: Constant.user_id) as? String) != nil{
                viewController =  self.storyboard!.instantiateViewController(identifier: "MediationViewController") as? UINavigationController
                
                self.sideMenuController?.rootViewController = viewController
                self.sideMenuController?.toggleLeftViewAnimated(sender: self)
            }
            else{
                viewController =  self.storyboard!.instantiateViewController(identifier: "MediationViewController") as? UINavigationController
                
                self.sideMenuController?.rootViewController = viewController
                self.sideMenuController?.toggleLeftViewAnimated(sender: self)
            }
            
        case 3:
            viewController =  self.storyboard!.instantiateViewController(identifier: "FoodViewController") as? UINavigationController
            
            self.sideMenuController?.rootViewController = viewController
            self.sideMenuController?.toggleLeftViewAnimated(sender: self)
            
        case 4:
            viewController =  self.storyboard!.instantiateViewController(identifier: "EquipmentViewController") as? UINavigationController
            
            
            self.sideMenuController?.rootViewController = viewController
            self.sideMenuController?.toggleLeftViewAnimated(sender: self)
            
        case 5:
            viewController =  self.storyboard!.instantiateViewController(identifier: "ChatViewController") as? UINavigationController
            
            
            self.sideMenuController?.rootViewController = viewController
            self.sideMenuController?.toggleLeftViewAnimated(sender: self)
            
        case 6:
            self.sideMenuController?.toggleLeftViewAnimated(sender: self)
        
        case 7:
            viewController =  self.storyboard!.instantiateViewController(identifier: "EducationViewController") as? UINavigationController
            
            self.sideMenuController?.rootViewController = viewController
            self.sideMenuController?.toggleLeftViewAnimated(sender: self)
            
        default:
            break
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
