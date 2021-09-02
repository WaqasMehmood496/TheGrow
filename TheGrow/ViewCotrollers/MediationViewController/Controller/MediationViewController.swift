//
//  MediationViewController.swift
//  TheGrow
//
//  Created by Adeel on 05/10/2020.
//  Copyright © 2020 Buzzware. All rights reserved.
//

import UIKit
import JGProgressHUD
import SDWebImage
import AVKit
import AVFoundation

class MediationViewController: UIViewController {
    // MARK: IBOUTLET'S
    @IBOutlet weak var exerciseTap:UITapGestureRecognizer!
    @IBOutlet weak var mediationTap:UITapGestureRecognizer!
    @IBOutlet weak var foodTap:UITapGestureRecognizer!
    @IBOutlet weak var equipmentTap:UITapGestureRecognizer!
    @IBOutlet weak var MediationTableView:UITableView!
    
    // MARK: VARIABLE'S
    var mediationArray = [MediationModel]()
    let hud = JGProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.MediationTableView.tableFooterView = UIView()
        callingMeditationApi()
    }
    @IBAction func viewExrcisePressed(_ sender:Any){
        let controller = self.storyboard!.instantiateViewController(identifier: "ExerciseViewController") as! UINavigationController
        self.sideMenuController?.rootViewController = controller
        
    }
    @IBAction func viewMediationPressed(_ sender:Any){
        let controller = self.storyboard!.instantiateViewController(identifier: "MediationViewController") as! UINavigationController
        self.sideMenuController?.rootViewController = controller
    }
    @IBAction func viewFoodPressed(_ sender:Any){
        let controller = self.storyboard!.instantiateViewController(identifier: "FoodViewController") as! UINavigationController
        self.sideMenuController?.rootViewController = controller
    }
    @IBAction func viewEquipmentPressed(_ sender:Any){
        let controller = self.storyboard!.instantiateViewController(identifier: "EquipmentViewController") as! UINavigationController
        self.sideMenuController?.rootViewController = controller
    }
    @IBAction func SideMenuBtn(_ sender:Any){
        self.sideMenuController?.toggleLeftView(animated: true, completion: nil)
    }
    
}


// MARK:- FUNCTION'S
extension MediationViewController{
    
    func callingMeditationApi() {
        let headers = ["Accept":"application/json","Content-Type":"application/x-www-form-urlencoded"]
        //let parameter = ["user_email":"\(email)","user_password":"\(password)"]
        self.hud.show(in: self.view)
        if Connectivity.isConnectedToNetwork(){
            AlamoHelper.GetRequest(Url: Constant.base_Url+"retriveCategory/plan", Header: headers, Parm: ["":""]) { (JSON) in
                let exerciseData = JSON["excercise_detail"].arrayValue
                for exer in exerciseData{
                    let tempObj = MediationModel()
                    tempObj.exercise_id = exer["exercise_id"].stringValue
                    tempObj.title = exer["title"].stringValue
                    tempObj.descriptions = exer["description"].stringValue
                    tempObj.image_url = exer["image_url"].stringValue
                    tempObj.duration = exer["duration"].stringValue
                    tempObj.type = exer["type"].stringValue
                    tempObj.media_file = exer["media_file"].stringValue
                    tempObj.inserted_date = exer["inserted_date"].stringValue
                    self.mediationArray.append(tempObj)
                }
                self.MediationTableView.reloadData()
                self.hud.removeFromSuperview()
            }
        }else{
            hud.textLabel.text = "You are not connected to the internet. Please check your connection"
            hud.indicatorView = JGProgressHUDErrorIndicatorView()
            hud.dismiss(afterDelay: 2, animated: true)
        }
    }
    
    // Video Player
    func PlayVideo(url:String) {
        let videoURL = URL(string: "\(url)")
        if let url = videoURL{
            let player = AVPlayer(url: url)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true, completion: {
                playerViewController.player!.play()
            })
            // Calculating Time of video played
            var timeObserverToken: Any?
            let timeScale = CMTimeScale(NSEC_PER_SEC)
            let time = CMTime(seconds: 0.5, preferredTimescale: timeScale)
            timeObserverToken = player.addPeriodicTimeObserver(forInterval: time,
                                                               queue: .main) {
                [weak self] time in
                print(time.seconds)
                // update player transport UI
            }
        }else{
            let hud = JGProgressHUD()
            hud.textLabel.text = "video can not be found"
            hud.indicatorView = JGProgressHUDIndicatorView()
            hud.dismiss(afterDelay: 2, animated: true)
        }
    }
}

// MARK:- UITABLEVIEW
extension MediationViewController:UITableViewDelegate,UITableViewDataSource,BtnDelegateDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mediationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MediationTableViewCell
        cell.lblName.text = self.mediationArray[indexPath.row].title
        cell.delegate = self
        
        let url = self.mediationArray[indexPath.row].image_url
        cell.ivImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: ""))
        let s = Float("1:30".replacingOccurrences(of: ":", with: ".")) ?? 0.0
        cell.sInterval.minimumValue = s
        cell.lblStartTime.text = "1:30"
        
        let e = Float("3:00".replacingOccurrences(of: ":", with: ".")) ?? 0.0
        cell.sInterval.maximumValue = e
        cell.lblEndTime.text = "3:00"
        let result = e - s
        cell.sInterval.value = result
        return cell
    }
    
    func buttonTapped(cell: MediationTableViewCell) {
        guard let indexPath = self.MediationTableView.indexPath(for: cell) else {
            return
        }
        print("Btn press")
        print(self.mediationArray[indexPath.row].media_file)
        PlayVideo(url: self.mediationArray[indexPath.row].media_file)
    }
}
