//
//  QuestionViewController.swift
//  TheGrow
//
//  Created by Buzzware Tech on 24/05/2021.
//  Copyright © 2021 Buzzware. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}

//MARK:- TABLEVIEW EXTENSION
extension QuestionViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath) as! QuestionTableViewCell
        return cell
    }
    
    
}
