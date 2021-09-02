//
//  FoodViewController.swift
//  TheGrow
//
//  Created by Adeel on 05/10/2020.
//  Copyright © 2020 Buzzware. All rights reserved.
//

import UIKit
import JGProgressHUD
import SDWebImage

class FoodViewController: UIViewController {
    
    // MARK: IBOUTLET'S
    @IBOutlet weak var exerciseView:UIView!
    @IBOutlet weak var mediationView:UIView!
    @IBOutlet weak var foodView:UIView!
    @IBOutlet weak var equipmentView:UIView!
    
    @IBOutlet weak var exerciseTap:UITapGestureRecognizer!
    @IBOutlet weak var mediationTap:UITapGestureRecognizer!
    @IBOutlet weak var foodTap:UITapGestureRecognizer!
    @IBOutlet weak var equipmentTap:UITapGestureRecognizer!
    
    @IBOutlet weak var foodTableView:UITableView!
    
    
    // MARK: VARIABLES
    var foodArray = [FoodModel]()
    let hud = JGProgressHUD()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.foodTableView.tableFooterView = UIView()
        //        self.foodArray = [
        //            FoodModel(name: "Bananas", img: "ic_food0", time: "07:28 PM", detail: "12 Bananas today"),
        //            FoodModel(name: "Apple", img: "ic_food1", time: "07:28 PM", detail: "8 Apples today"),
        //            FoodModel(name: "Chiken", img: "ic_food2", time: "07:28 PM", detail: "2 Chiken today")
        //        ]
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        callingFoodApi()
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
extension FoodViewController{
    
    func callingFoodApi() {
        let headers = ["Accept":"application/json","Content-Type":"application/x-www-form-urlencoded"]
        //let parameter = ["user_email":"\(email)","user_password":"\(password)"]
        self.hud.show(in: self.view)
        if Connectivity.isConnectedToNetwork(){
            // ActivityIndicatorView.startAnimating()
            AlamoHelper.GetRequest(Url: Constant.base_Url+"retriveCategory/food", Header: headers, Parm: ["":""]) { (JSON) in
                //print(JSON)
                let exerciseData = JSON["excercise_detail"].arrayValue
                for exer in exerciseData{
                    let tempObj = FoodModel()
                    tempObj.exercise_id = exer["exercise_id"].stringValue
                    tempObj.title = exer["title"].stringValue
                    tempObj.descriptions = exer["description"].stringValue
                    tempObj.image_url = exer["image_url"].stringValue
                    tempObj.duration = exer["duration"].stringValue
                    tempObj.type = exer["type"].stringValue
                    tempObj.media_file = exer["media_file"].stringValue
                    tempObj.inserted_date = exer["inserted_date"].stringValue
                    self.foodArray.append(tempObj)
                }
                self.foodTableView.reloadData()
                self.hud.removeFromSuperview()
            }
        }else{
            // Show toast message
            print("Network not found")
            //ShowAlert(view: self, message: "You are not connected to the internet. Please check your connection", Title: "Network Connection Error")
        }
    }
}


// MARK:- UITABLEVIEW
extension FoodViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.foodArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FoodTableViewCell
        cell.lblName.text = self.foodArray[indexPath.row].title
        cell.lblDetail.text = self.foodArray[indexPath.row].descriptions
        let date = self.foodArray[indexPath.row].inserted_date
        let checkTime = Globals.dateSplit(dateInString: date)
        //print(checkTime)
        cell.lbltime.text = checkTime
        let url = self.foodArray[indexPath.row].image_url
        cell.ivImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: ""))
        return cell
    }
    
    
}
