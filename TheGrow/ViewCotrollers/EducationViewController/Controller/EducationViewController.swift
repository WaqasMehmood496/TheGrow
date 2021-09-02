//
//  EducationViewController.swift
//  TheGrow
//
//  Created by Adeel on 07/10/2020.
//  Copyright © 2020 Buzzware. All rights reserved.
//

import UIKit
import FSPagerView
import JGProgressHUD

class EducationViewController: UIViewController {
    
    // MARK:IBOUTLET'S
    @IBOutlet weak var equipmentTableView:UITableView!
    
    // MARK: VARIABLES
    let hud = JGProgressHUD()
    var educationArray = [EducationModel]()
    var featureVideo:[String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callingEducationApi()
    }
    
    @IBAction func SideMenuBtn(_ sender:Any){
        self.sideMenuController?.toggleLeftView(animated: true, completion: nil)
    }
    
}



// MARK:- FUNCTION'S
extension EducationViewController{
    
    func callingEducationApi() {
        let headers = ["Accept":"application/json","Content-Type":"application/x-www-form-urlencoded"]
        self.hud.show(in: self.view)
        if Connectivity.isConnectedToNetwork(){
            AlamoHelper.GetRequest(Url: Constant.base_Url+"retriveCategory/groweducation", Header: headers, Parm: ["":""]) { (JSON) in
                //print(JSON)
                let exerciseData = JSON["excercise_detail"].arrayValue
                for exer in exerciseData{
                    let tempObj = EducationModel()
                    tempObj.exercise_id = exer["exercise_id"].stringValue
                    tempObj.title = exer["title"].stringValue
                    tempObj.descriptions = exer["description"].stringValue
                    tempObj.image_url = exer["image_url"].stringValue
                    tempObj.duration = exer["duration"].stringValue
                    tempObj.type = exer["type"].stringValue
                    tempObj.media_file = exer["media_file"].stringValue
                    tempObj.inserted_date = exer["inserted_date"].stringValue
                    self.educationArray.append(tempObj)
                }
                self.equipmentTableView.reloadData()
                self.hud.removeFromSuperview()
            }
        }else{
            // Show toast message
            PopupHelper.alertWithOk(title: "Network Connection Error", message: "You are not connected to the internet. Please check your connection", controler: self)
        }
    }
}


// MARK:- UITABLEVIEW
extension EducationViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.educationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EducationTableViewCell
        cell.pagerView.delegate = self
        cell.pagerView.dataSource = self
        //if let name = self.educationArray[indexPath.row].title{
            cell.lblName.text = self.educationArray[indexPath.row].title
        //}
        //if let detail = self.educationArray[indexPath.row].menuDetail{
            cell.lblDetail.text = self.educationArray[indexPath.row].description
        //}
        //        if let img = self.educationArray[indexPath.row].menuImage{
        //            cell.ivImage.image = UIImage(named: img)
        //        }
        //if let time = self.educationArray[indexPath.row].menuTime{
        cell.lbltime.text = self.educationArray[indexPath.row].inserted_date
        //}
        return cell
    }
    
}
extension EducationViewController:FSPagerViewDelegate,FSPagerViewDataSource{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
       // return self.featureVideo.count
        return 1
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        //        if let image = self.featureVideo[index]{
        //            cell.imageView?.image = UIImage(named: image)
        //        }
       // cell.imageView?.image = UIImage(named: self.featureVideo[Int.random(in: 0..<self.featureVideo.count)])
        let url = self.educationArray[index].image_url
        
        cell.imageView?.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: ""))
        
        //        if let url = URL(string: self.featureVideo[index]){
        //            cell.imageView?.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "imag11"), imageTransition: .crossDissolve(1.0) , runImageTransitionIfCached: true)
        //        }
        //self.pageControl.currentPage = index
        return cell
    }
    
    
}
