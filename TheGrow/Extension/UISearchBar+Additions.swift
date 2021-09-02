//
//  UISearchBar+Additions.swift
//  TastyBox
//
//  Created by Adeel on 15/07/2020.
//  Copyright © 2020 Buzzware. All rights reserved.
//

import UIKit

class UISearchBar_Additions: UISearchBar {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    

}
extension UISearchBar{
    func searchbarSetting(){
        if UIDevice.current.userInterfaceIdiom == .phone{
            if #available(iOS 13.0, *) {
                self.searchTextField.font = UIFont(name: "Montserrat-Medium", size: 10)!
            } else {
                // Fallback on earlier versions
            }
        }
        else{
            if #available(iOS 13.0, *) {
                self.searchTextField.font = UIFont(name: "Montserrat-Medium", size: 12)!
            } else {
                // Fallback on earlier versions
            }
        }
        
        if #available(iOS 13.0, *) {
            self.searchTextField.placeHolderColor = UIColor().colorsFromAsset(name: .lite)
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            self.searchTextField.textColor = UIColor().colorsFromAsset(name: .lite)
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            self.searchTextField.backgroundColor = UIColor().colorsFromAsset(name: .lite)
        } else {
            // Fallback on earlier versions
        }
        self.tintColor = UIColor().colorsFromAsset(name: .lite)
        self.setImage(#imageLiteral(resourceName: "ic_search"), for: .search, state: .normal)
        self.layer.cornerRadius = self.frame.height/2
    }
}
