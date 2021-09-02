//
//  AvatarsViewController.swift
//  TheGrow
//
//  Created by Adeel on 07/10/2020.
//  Copyright © 2020 Buzzware. All rights reserved.
//

import UIKit

class AvatarsViewController: UIViewController {
    // MARK: IBOUTLET'S
    @IBOutlet weak var avatarCollectionView:UICollectionView!
    
    // MARK: VARIABLE'S
    var avatarArray = [AvatarModel]()
    var delegate = SideMenuViewController()
    private let spacingIphone:CGFloat = 15.0
    private let spacingIpad:CGFloat = 30.0
    var selectedIndexPath :IndexPath? = IndexPath(row: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.avatarArray = [
            AvatarModel(id: "0", img: "ic_avatar0"),
            AvatarModel(id: "1", img: "ic_avatar1"),
            AvatarModel(id: "2", img: "ic_avatar2"),
            AvatarModel(id: "3", img: "ic_avatar3"),
            AvatarModel(id: "4", img: "ic_avatar4"),
            AvatarModel(id: "5", img: "ic_avatar5"),
            AvatarModel(id: "6", img: "ic_avatar6"),
            AvatarModel(id: "7", img: "ic_avatar7"),
            AvatarModel(id: "8", img: "ic_avatar8"),
            AvatarModel(id: "9", img: "ic_avatar9"),
            AvatarModel(id: "10", img: "ic_avatar10"),
            AvatarModel(id: "11", img: "ic_avatar11"),
            AvatarModel(id: "12", img: "ic_avatar12"),
            AvatarModel(id: "13", img: "ic_avatar13"),
            AvatarModel(id: "14", img: "ic_avatar14")
        ]
        if let index = UserDefaults.standard.value(forKey: Constant.avatar) as? Int{
            self.selectedIndexPath?.row = index
        }
        let layout = UICollectionViewFlowLayout()
        if UIDevice.current.userInterfaceIdiom == .phone{
            layout.sectionInset = UIEdgeInsets(top: spacingIphone, left: spacingIphone, bottom: spacingIphone, right: spacingIphone)
            layout.minimumLineSpacing = spacingIphone
            layout.minimumInteritemSpacing = spacingIphone
        }
        else{
            layout.sectionInset = UIEdgeInsets(top: spacingIpad, left: spacingIpad, bottom: spacingIpad, right: spacingIpad)
            layout.minimumLineSpacing = spacingIpad
            layout.minimumInteritemSpacing = spacingIpad
        }
        self.avatarCollectionView?.collectionViewLayout = layout
    }
    
    @IBAction func SideMenuBtn(_ sender:Any){
        self.sideMenuController?.toggleLeftView(animated: true, completion: nil)
    }
}


//MARK:- UICOLLECTION VIEW DELEGATE AND DATASOURCE
extension AvatarsViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.avatarArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AvatarsCollectionViewCell
        if (selectedIndexPath == indexPath){
            
            
            cell.isSelected = true
            cell.layer.borderColor = UIColor().colorsFromAsset(name: .yellowColor).cgColor
        }
        else{
            
            cell.isSelected = false
            cell.layer.borderColor = UIColor.black.cgColor
            
            
        }
        if let imag = self.avatarArray[indexPath.row].menuImage{
            cell.ivImage.image = UIImage(named: imag)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndexPath != nil {
            collectionView.deselectItem(at: selectedIndexPath!, animated: true)
        }
        
        print("Selected:\(indexPath)")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AvatarsCollectionViewCell
        cell.isSelected = true
        selectedIndexPath = indexPath
        cell.layer.borderColor = UIColor().colorsFromAsset(name: .yellowColor).cgColor
        collectionView.reloadItems(at: collectionView.indexPathsForVisibleItems)
        UserDefaults.standard.set(indexPath.row, forKey: Constant.avatar)
        self.delegate.avatarView.image = UIImage(named: "ic_avatar\(indexPath.row)")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 2
        let spacingBetweenCellsIphone:CGFloat = 15
        let spacingBetweenCellsIpad:CGFloat = 30
        
        if UIDevice.current.userInterfaceIdiom == .phone{
            let totalSpacing = (2 * self.spacingIphone) + ((numberOfItemsPerRow - 1) * spacingBetweenCellsIphone) //Amount of total spacing in a row
            
            if let collection = self.avatarCollectionView{
                let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
                return CGSize(width: width , height: width - spacingBetweenCellsIphone)
            }else{
                return CGSize(width: 0, height: 0)
            }
        }
        else{
            let totalSpacing = (2 * self.spacingIpad) + ((numberOfItemsPerRow - 1) * spacingBetweenCellsIpad) //Amount of total spacing in a row
            
            if let collection = self.avatarCollectionView{
                let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
                return CGSize(width: width , height: width - spacingBetweenCellsIpad)
            }else{
                return CGSize(width: 0, height: 0)
            }
        }
    }
}
