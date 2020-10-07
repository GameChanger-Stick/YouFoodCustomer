//
//  SearchDishListViewController.swift
//  Zfood-User
//
//  Created by bhavya on 2/7/20.
//  Copyright © 2020 WemakeAppz. All rights reserved.
//

import UIKit

//cell_searchDishList
extension SearchDishListViewController{
    func setupUI(){
        self.searchBar.delegate = self
        self.tableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
        self.searchBar.resignFirstResponder()
    }
}

class SearchDishListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var arrSearchList : ModelSearchDishList?
    var cellName = "cell_searchDishList"
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
//http://3.94.1.254/mobile/searchDishlist?name=test
    func gotoChegDetail(id:String){
        let chefDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.CHEF_DETAILS)as! ZFUChefDetailsVC
                       chefDetailsVC.chefId = id
    GlofromSearchList = true
                             chefDetailsVC.modalPresentationStyle = .overFullScreen
                             self.present(chefDetailsVC, animated: true, completion: nil)
    }
}
extension SearchDishListViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrSearchList?.dishlist.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! cell_searchDishList
        cell.addData(data: (self.arrSearchList?.dishlist[indexPath.row])!)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      self.gotoChegDetail(id: self.arrSearchList?.dishlist[indexPath.row].chefData.inChefId ?? "")
    }
    
}
extension SearchDishListViewController{
    //MARK:- API FUNCTION
    func getDishList(loader:Bool, cuisineId: String,name:String) {
        let param = ["name":name,"lat":Double(userLAT),"lng":Double(userLNG),"minDistance":"0","maxDistance":"100"] as [String : Any]
                 APIServices().GET_SerachDish_LIST(params: param, viewController: self, loader: loader) { (data, error) in
                     if data == nil{
                        self.arrSearchList = data
                                          self.tableView.reloadData()
                        return}
                    self.arrSearchList = data
                    self.tableView.reloadData()
                   
                 }
             }
}
extension SearchDishListViewController : UISearchBarDelegate{
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: false) {
            
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
          self.getDishList(loader: false, cuisineId: "", name: searchBar.text ?? "")

    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       // self.getDishList(loader: false, cuisineId: "", name: searchBar.text ?? "")
    }
}
