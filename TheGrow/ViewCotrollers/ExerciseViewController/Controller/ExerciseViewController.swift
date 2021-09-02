//
//  ExerciseViewController.swift
//  TheGrow
//
//  Created by Adeel on 05/10/2020.
//  Copyright © 2020 Buzzware. All rights reserved.
//

import UIKit
import JGProgressHUD
import SDWebImage

class ExerciseViewController: UIViewController {
    
    // MARK: IBOUTLET'S
    @IBOutlet weak var exerciseView:UIView!
    @IBOutlet weak var mediationView:UIView!
    @IBOutlet weak var foodView:UIView!
    @IBOutlet weak var equipmentView:UIView!
    @IBOutlet weak var exerciseTap:UITapGestureRecognizer!
    @IBOutlet weak var mediationTap:UITapGestureRecognizer!
    @IBOutlet weak var foodTap:UITapGestureRecognizer!
    @IBOutlet weak var equipmentTap:UITapGestureRecognizer!
    @IBOutlet weak var exerciseTableView:UITableView!
    
    // MARK: VARIABLES
    var exerciseArray = [ExerciseModel]()
    let hud = JGProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.exerciseTableView.tableFooterView = UIView()
        callingExerciseApi()
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    
    // MARK: IBACTION'S
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
extension ExerciseViewController {
    func callingExerciseApi() {
        let headers = ["Accept":"application/json","Content-Type":"application/x-www-form-urlencoded"]
        self.hud.show(in: self.view)
        if Connectivity.isConnectedToNetwork() {
            AlamoHelper.GetRequest(Url: Constant.mainUrl+"retriveCategory/grow", Header: headers, Parm: ["":""]) { (JSON) in
                let exerciseData = JSON["excercise_detail"].arrayValue
                for exer in exerciseData{
                    let tempObj = ExerciseModel()
                    tempObj.exercise_id = exer["exercise_id"].stringValue
                    tempObj.title = exer["title"].stringValue
                    tempObj.descriptions = exer["description"].stringValue
                    tempObj.image_url = exer["image_url"].stringValue
                    tempObj.duration = exer["duration"].stringValue
                    tempObj.type = exer["type"].stringValue
                    tempObj.media_file = exer["media_file"].stringValue
                    tempObj.inserted_date = exer["inserted_date"].stringValue
                    self.exerciseArray.append(tempObj)
                }
                self.exerciseTableView.reloadData()
                self.hud.removeFromSuperview()
            }
        } else {
            hud.textLabel.text = "You are not connected to the internet. Please check your connection"
            hud.indicatorView = JGProgressHUDErrorIndicatorView()
            hud.dismiss(afterDelay: 2, animated: true)
        }
    }
}


// MARK:- UITABLEVIEW
extension ExerciseViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.exerciseArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ExerciseTableViewCell
        cell.lblName.text = self.exerciseArray[indexPath.row].title
        
        cell.lblDetail.text = self.exerciseArray[indexPath.row].duration
        
        let url = self.exerciseArray[indexPath.row].image_url
        cell.ivImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: ""))
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        PopupHelper.alertTimerView(title: "", msg: "", image: "", controler: self)
    }
}
