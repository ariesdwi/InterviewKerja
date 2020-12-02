//
//  DetailViewController.swift
//  testBuanaVariaUtama
//
//  Created by Aries Dwi Prasetiyo on 02/12/20.
//  Copyright © 2020 Aries Dwi Prasetiyo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var detailImageView: UIImageView!
    @IBOutlet var namaBarang: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    
    var nameProduct = ""
    var priceProduct = 0
    var imgUrl = ""
    var desc = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        namaBarang.text = nameProduct
        priceLabel.text = String(priceProduct)
        descLabel.text = desc
        detailImageView.downloaded(from: imgUrl)
        // Do any additional setup after loading the view.
    }
    
}


