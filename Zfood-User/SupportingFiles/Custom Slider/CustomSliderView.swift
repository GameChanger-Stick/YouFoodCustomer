//
//  CustomSliderView.swift
//  Zfood-User
//
//  Created by apple on 09/05/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit

protocol CustomSliderDelegate {
    func didTapOnTitle(index: Int)
}

class CustomSliderView: UIView {

    @IBOutlet weak var sliderCollectionView: UICollectionView!
    
    var delegate:CustomSliderDelegate?
    
    var titleArray = [String]()
    var selectedTitleColor: UIColor!
    var deselectedTitleColor: UIColor!
    var selectedBarColor: UIColor!
    var deselectedBarColor: UIColor!
    var selectedIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.xibSetup()
    }
    
    func xibSetup() {
        let view = Bundle.main.loadNibNamed("CustomSliderView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        addSubview(view)
        self.sliderCollectionView.register(UINib(nibName: "SliderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SliderCollectionViewCell")
        self.sliderCollectionView?.contentInsetAdjustmentBehavior = .always
    }

}

extension CustomSliderView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionViewCell", for: indexPath) as! SliderCollectionViewCell
        cell.setCellData(title: self.titleArray[indexPath.row], index: indexPath.row, tappedIndex: self.selectedIndex, selectedTitleColor: self.selectedTitleColor, deselectedTitleColor: self.deselectedTitleColor, selectedBarColor: self.selectedBarColor, deselectedBarColor: self.deselectedBarColor)
        return cell
    }
}

extension CustomSliderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.frame.size.width / 3), height: self.frame.size.height)
    }
}

extension CustomSliderView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.selectedIndex != indexPath.item {
            self.selectedIndex = indexPath.item
            self.sliderCollectionView.reloadData()
            self.delegate?.didTapOnTitle(index: indexPath.item)
        }
    }
}
