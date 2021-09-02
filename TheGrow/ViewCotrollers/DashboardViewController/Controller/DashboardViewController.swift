//
//  DashboardViewController.swift
//  TheGrow
//
//  Created by Adeel on 02/10/2020.
//  Copyright © 2020 Buzzware. All rights reserved.
//

import UIKit
import MSCircularSlider
import LGSideMenuController
import JGProgressHUD
import FirebaseMessaging

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var circleSlide:MSCircularSlider!
    @IBOutlet weak var exerciseView:UIView!
    @IBOutlet weak var mediationView:UIView!
    @IBOutlet weak var foodView:UIView!
    @IBOutlet weak var equipmentView:UIView!
    @IBOutlet weak var exerciseTap:UITapGestureRecognizer!
    @IBOutlet weak var mediationTap:UITapGestureRecognizer!
    @IBOutlet weak var foodTap:UITapGestureRecognizer!
    @IBOutlet weak var equipmentTap:UITapGestureRecognizer!
    @IBOutlet weak var avatarView:UIImageView!
    
    var semiCircleLayer   = CAShapeLayer()
    var dataDic = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCircleProgress()
        setupSideMenu()
    }
    override func viewWillAppear(_ animated: Bool) {
        if let index = UserDefaults.standard.value(forKey: Constant.avatar) as? Int{
            self.avatarView.image = UIImage(named: "ic_avatar\(index)")
        }
        else{
            self.avatarView.image = UIImage(named: "ic_avatar7")
        }
    }
    @IBAction func viewExrcisePressed(_ sender:Any){
        //self.performSegue(withIdentifier: "toExer", sender: nil)
        let controller = self.storyboard!.instantiateViewController(identifier: "ExerciseViewController") as! UINavigationController
        self.sideMenuController?.rootViewController = controller
    }
    @IBAction func viewMediationPressed(_ sender:Any){
        //self.performSegue(withIdentifier: "toMedi", sender: nil)
        let controller = self.storyboard!.instantiateViewController(identifier: "MediationViewController") as! UINavigationController
        self.sideMenuController?.rootViewController = controller
    }
    @IBAction func viewFoodPressed(_ sender:Any){
        //self.performSegue(withIdentifier: "toFood", sender: nil)
        let controller = self.storyboard!.instantiateViewController(identifier: "FoodViewController") as! UINavigationController
        self.sideMenuController?.rootViewController = controller
    }
    @IBAction func viewEquipmentPressed(_ sender:Any){
        //self.performSegue(withIdentifier: "toEquip", sender: nil)
        let controller = self.storyboard!.instantiateViewController(identifier: "EquipmentViewController") as! UINavigationController
        self.sideMenuController?.rootViewController = controller
    }
    
    @IBAction func SideMenuBtn(_ sender:Any){
        self.sideMenuController?.toggleLeftView(animated: true, completion: nil)
    }
}



//MARK:- HELPING METHOD'S
extension DashboardViewController {
    func setupCircleProgress() {
        circleSlide.maximumAngle = 110.0
        circleSlide.minimumValue = 0
        circleSlide.maximumValue = 100
        circleSlide.currentValue = 0
        circleSlide.labelFont = UIFont(name: "Montserrat-Medium", size: 10)!
        circleSlide.labels = ["0%", "50%", "100%"]
    }
    
    func setupSideMenu() {
        sideMenuController?.leftViewWidth = self.view.bounds.width - self.view.bounds.width/4
        sideMenuController?.rootViewCoverAlphaForLeftView = 0.9
        sideMenuController?.rootViewLayerShadowRadius = 10.0
        
        sideMenuController?.leftViewSwipeGestureRange = .init(left: 0.0, right: 10.0)
        sideMenuController?.leftViewPresentationStyle = .scaleFromBig
        sideMenuController?.leftViewAnimationDuration = 1.0
    }
}


//MARK:- API CALLING METHOD'S
extension DashboardViewController {
    func sendtoken(){
        showHUDView(hudIV: .indeterminate, text: .LoadingTastybox) { (hud) in
            //hud.show(in: self.view, animated: true)
            if let userId = CommonHelper.getCachedUserData()?.user_id {
                let token = Messaging.messaging().fcmToken
                UserDefaults.standard.set(token, forKey: Constant.token_id)
                UserDefaults.standard.set(true, forKey: Constant.isNotify)
                UserDefaults.standard.synchronize()
                self.dataDic  = [String:String]()
                self.dataDic[Constant.user_id] = userId
                self.dataDic[Constant.token_id] = token
                self.callWebService(.add_token, hud: hud)
                
            }
        }
    }
}


// MARK:- WEBSERVICE DELEGATE METHOD'S EXTENSION
extension DashboardViewController:WebServiceResponseDelegate {
    
    func callWebService(_ url:webserviceUrl,hud: JGProgressHUD){
        
        let helper = WebServicesHelper(serviceToCall: url, withMethod: .post, havingParameters: self.dataDic, relatedViewController: self,hud: hud)
        helper.delegateForWebServiceResponse = self
        helper.callWebService()
    }
    func webServiceDataParsingOnResponseReceived(url: webserviceUrl?, viewControllerObj: UIViewController?, dataDict: Any, hud: JGProgressHUD) {
        switch url {
        case .add_token:
            hud.dismiss()
            break
        default:
            hud.dismiss()
        }
    }
}
