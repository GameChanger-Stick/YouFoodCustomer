//
//  cell_collectionItem.swift
//  Zfood-User
//
//  Created by bhavya on 12/27/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.

import UIKit

class cell_collectionItem: UICollectionViewCell {
    @IBOutlet weak var lblNAme: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblPAymentMenthod: UILabel!
    @IBOutlet weak var lblMinOrder: UILabel!
    @IBOutlet weak var lblCookingTime: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imgV: UIImageView!
    
    @IBOutlet weak var btnAddToCart: UIButton!
    var arr : Dishdetail?
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "cell_collectionItemImages", bundle: nil), forCellWithReuseIdentifier: "cell_collectionItemImages")
        // Initialization code
    }
    func addAdta(data:Dishdetail){
        arr = data
        self.lblNAme.text = data.stDishName
        self.lblPrice.text = "$\(data.stPrice ?? "")"
        self.lblMinOrder.text = data.min_order
        self.imgV.getImage(url: data.image ?? "")
        self.lblPAymentMenthod.text = "Online"
        self.lblCookingTime.text = data.cooking_time
        
    }
    func gotoItemDetail(data12 :Dishdetail?){
        if data12 != nil{
        let userInfo = ["data":data12]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: changeScreenNotification), object: self, userInfo: userInfo as [NSObject : AnyObject])
    }
    }
    
    @IBAction func handleBtnAction(_ sender: Any) {
        gotoItemDetail(data12: arr)
    }
}
extension cell_collectionItem:UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell_collectionItemImages", for: indexPath) as! cell_collectionItemImages
       // cell.addData(data: arr[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.height)
    }
}
