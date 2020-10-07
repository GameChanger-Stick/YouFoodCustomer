//
//  cell_collectionItemImages.swift
//  Zfood-User
//
//  Created by bhavya on 12/27/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit

class cell_collectionItemImages: UICollectionViewCell {

    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func addData(data :String )
    {
        self.imgView.getImage(url: data)
    }
}
