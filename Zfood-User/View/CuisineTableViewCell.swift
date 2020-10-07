//
//  CuisineTableViewCell.swift
//  Zfood-User
//
//  Created by apple on 09/05/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit

class CuisineTableViewCell: UITableViewCell {

    var dataArr = [Dishdetail]()
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        collectionView.register(UINib(nibName: "cell_collectionItem", bundle: nil), forCellWithReuseIdentifier: "cell_collectionItem")
    }

    func getItemsInCuisine(items:[Dishdetail]?){
        if items != nil{
            if items!.count != 0{
                dataArr = items!
            self.collectionView.reloadData()
        }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension CuisineTableViewCell:UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell_collectionItem", for: indexPath) as! cell_collectionItem
        cell.addAdta(data: dataArr[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width/1.2, height: self.collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let userInfo = ["data":dataArr[indexPath.row]]
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: changeScreenNotification), object: self, userInfo: userInfo as [NSObject : AnyObject])
        
    }
}

