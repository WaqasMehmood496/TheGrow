//
//  EquipmentViewController.swift
//  TheGrow
//
//  Created by Adeel on 05/10/2020.
//  Copyright © 2020 Buzzware. All rights reserved.
//

import UIKit
import JGProgressHUD
import SDWebImage

class EquipmentViewController: UIViewController {
    
    // MARK: IBOUTLET'S
//    @IBOutlet weak var exerciseView:UIView!
//    @IBOutlet weak var mediationView:UIView!
//    @IBOutlet weak var foodView:UIView!
//    @IBOutlet weak var equipmentView:UIView!
//
    @IBOutlet weak var exerciseTap:UITapGestureRecognizer!
    @IBOutlet weak var mediationTap:UITapGestureRecognizer!
    @IBOutlet weak var foodTap:UITapGestureRecognizer!
    @IBOutlet weak var equipmentTap:UITapGestureRecognizer!
    
    @IBOutlet weak var equipmentTableView:UITableView!
    
    // MARK: VARIABLES
    var equipmentArray = [EquipmentModel]()
    let hud = JGProgressHUD()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.equipmentTableView.tableFooterView = UIView()
        //        self.equipmentArray = [
        //            EquipmentModel(name: "Pumps", img: "ic_equip0", time: "", detail: "It is long established fact is that readable"),
        //            EquipmentModel(name: "Prostat Massagers", img: "ic_equip1", time: "07:28 PM", detail: "It is long established fact is that readable"),
        //            EquipmentModel(name: "Suppliments", img: "ic_equip2", time: "07:28 PM", detail: "It is long established fact is that readable"),
        //            EquipmentModel(name: "Shockwave Devices", img: "ic_equip3", time: "07:28 PM", detail: "It is long established fact is that readable"),
        //            EquipmentModel(name: "Cock Rings", img: "ic_equip4", time: "07:28 PM", detail: "It is long established fact is that readable")
        //        ]
        
        callingEquipmentsApi()
        
        // Do any additional setup after loading the view.
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




// MARK:- FUNCTION'S
extension EquipmentViewController{
    
    func callingEquipmentsApi() {
        let headers = ["Accept":"application/json","Content-Type":"application/x-www-form-urlencoded"]
        //let parameter = ["user_email":"\(email)","user_password":"\(password)"]
        self.hud.show(in: self.view)
        if Connectivity.isConnectedToNetwork(){
            // ActivityIndicatorView.startAnimating()
            AlamoHelper.GetRequest(Url: Constant.base_Url+"retriveCategory/equipment", Header: headers, Parm: ["":""]) { (JSON) in
                //print(JSON)
                let exerciseData = JSON["excercise_detail"].arrayValue
                for exer in exerciseData{
                    let tempObj = EquipmentModel()
                    tempObj.exercise_id = exer["exercise_id"].stringValue
                    tempObj.title = exer["title"].stringValue
                    tempObj.descriptions = exer["description"].stringValue
                    tempObj.image_url = exer["image_url"].stringValue
                    tempObj.duration = exer["duration"].stringValue
                    tempObj.type = exer["type"].stringValue
                    tempObj.media_file = exer["media_file"].stringValue
                    tempObj.inserted_date = exer["inserted_date"].stringValue
                    self.equipmentArray.append(tempObj)
                }
                self.equipmentTableView.reloadData()
                self.hud.removeFromSuperview()
            }
        }else{
            // Show toast message
            print("Network not found")
            //ShowAlert(view: self, message: "You are not connected to the internet. Please check your connection", Title: "Network Connection Error")
        }
    }
}





extension EquipmentViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.equipmentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EquipmentTableViewCell
        cell.lblName.text = self.equipmentArray[indexPath.row].title
        cell.lblDetail.text = self.equipmentArray[indexPath.row].descriptions
        let date = self.equipmentArray[indexPath.row].inserted_date
        let checkTime = Globals.dateSplit(dateInString: date)
        //print(checkTime)
        cell.lbltime.text = checkTime
        let url = self.equipmentArray[indexPath.row].image_url
        cell.ivImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: ""))
        return cell
    }
    
    
}
