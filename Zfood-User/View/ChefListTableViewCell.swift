//
//  ChefListTableViewCell.swift
//  Zfood-User
//
//  Created by apple on 06/05/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit
import Cosmos
import SDWebImage

class ChefListTableViewCell: UITableViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var milesLbl: UILabel!
    var indexpathQ = Int()
    @IBOutlet weak var imgHandler: UIImageView!
    @IBOutlet weak var lblHandler: UILabel!
    @IBOutlet weak var chefPicImageView: UIImageView!
    @IBOutlet weak var chefRatingLabel: UILabel!
    @IBOutlet weak var chefNameLabel: UILabel!
    @IBOutlet weak var chefAddressLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var imgFav: UIImageView!
    @IBOutlet weak var btn_avaibility: UIButton!
    
    @IBOutlet weak var viewFoodDoner: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pickupView: UIView!
    @IBOutlet weak var deliveryView: UIView!
    
    @IBOutlet weak var viewFav: UIView!
    var detailChef : ChefInfo?
    @IBOutlet weak var viewRating: CosmosView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "dishListCollectionCell", bundle: nil), forCellWithReuseIdentifier: "dishListCollectionCell")
        if isguest{
            self.viewFav.isHidden = true
        }else{
            self.viewFav.isHidden = false

        }
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layoutIfNeeded()
    }
    
    @IBAction func handleAvaibility(_ sender: Any) {
    }
    
    @IBAction func handleFavBtn(_ sender: UIButton) {
        var userInfo = [String:Any]()
       if imgFav.image == #imageLiteral(resourceName: "Path_pink"){
        imgFav.image = #imageLiteral(resourceName: "ic_favorite_accent")
         userInfo = [ "index" : sender.tag,"status":"1"] as [String : Any]
        }else{
         userInfo = [ "index" : sender.tag,"status":"0"] as [String : Any]
        imgFav.image = #imageLiteral(resourceName: "Path_pink")
        }
          NotificationCenter.default.post(name: .favChef, object: nil, userInfo: userInfo)
    }
    func getChef(detail:ChefInfo){
        self.detailChef = detail
        self.collectionView.reloadData()
        self.chefNameLabel.text = detail.chefName
        self.chefRatingLabel.text =  "(\(detail.no_order ?? ""))"
       // guard let da = Double(detail.rating ?? "0.0") {return}
        self.viewRating.rating = Double(detail.rating ?? "0.0")!
        self.chefAddressLabel.text = detail.smallAddress
        self.chefPicImageView.getImage(url: detail.chefProfileImage)
        if detail.isexpand{
        }else{
        }
        if detail.order_type == "1"{
            self.deliveryView.isHidden = false
                       self.pickupView.isHidden = true
        }else if detail.order_type == "2"{
            self.deliveryView.isHidden = true
                       self.pickupView.isHidden = false
        }else{
            self.deliveryView.isHidden = false
            self.pickupView.isHidden = false

        }
        if detail.handler == "" || detail.handler == nil{
            self.lblHandler.isHidden = true
            self.imgHandler.isHidden = true

        }else{
            self.lblHandler.isHidden = false
                       self.imgHandler.isHidden = false
        }
        if detail.freeDish == "1"{
            viewFoodDoner.isHidden = false
        }else{
            viewFoodDoner.isHidden = true
        }
        self.milesLbl.text = detail.distance
        self.getAvailability(detail: detail)
        imgFav.image = detail.fav == "0" ? #imageLiteral(resourceName: "Path_pink"):#imageLiteral(resourceName: "ic_favorite_accent")
    }
    
    func getAvailability(detail:ChefInfo){}
}
extension ChefListTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailChef?.dishlist.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "dishListCollectionCell", for: indexPath) as! dishListCollectionCell
        cell.imgView.getImage(url: detailChef?.dishlist[indexPath.item].imageURL ?? "")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width/3.3, height: self.collectionView.frame.height - 1)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationCenter.openchefList), object: nil,userInfo: ["id":indexpathQ])

    }
}
