//
//  ViewController.swift
//  testBuanaVariaUtama
//
//  Created by Aries Dwi Prasetiyo on 02/12/20.
//  Copyright © 2020 Aries Dwi Prasetiyo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet var Navbar: UINavigationItem!
    @IBOutlet var collectView: UICollectionView!
    
    var shop:[BarangJualan] = []
    var buku = BarangJualan(id: 1, name: "Buku", category: "School", variant: "Black", price: 30000, images: "https://www.kelaspintar.id/blog/wp-content/uploads/2019/10/Resensi-buku.jpg", Discount: 20, description: "Buku adalah kumpulan/himpunan kertas atau bahan lainnya yang dijilid menjadi satu pada salah satu ujungnya dan berisi tulisan, gambar, atau tempelan. Setiap sisi dari sebuah lembaran kertas pada buku disebut sebuah halaman")
    var Tas = BarangJualan(id: 2, name: "Bag", category: "School", variant: "White", price: 35000, images: "https://cf.shopee.co.id/file/74915c863ef6c19a4a3029151f73ca95", Discount: 20, description: "Tas adalah wadah tertutup yang dapat dibawa bepergian. Materi untuk membuat tas antara lain adalah kertas, plastik, kulit, kain, dan lain-lain. Biasanya digunakan untuk membawa pakaian, buku, dan lain-lain")
    var Sepatu = BarangJualan(id: 3, name: "Sepatu", category: "School", variant: "Black", price: 40000, images: "https://pustakalewi.com/t0k0hkit4/_1m4g3st0k0h/2017-08-14Sepatu-Adidas-Jogging-Hitam-39-43-200-Ribu.jpg", Discount: 20, description: "Sepatu adalah salah satu jenis alas kaki yang biasanya terdiri atas bagian-bagian sol, hak, kap, tali, dan lidah")
    var Sandal = BarangJualan(id: 4, name: "Sandal", category: "School", variant: "Black", price: 10000, images: "https://cdn.shopify.com/s/files/1/0016/5111/4048/products/sandal_outdoor_green_01_580x.jpg?v=1571921979", Discount: 20, description: "Sandal atau sendal adalah salah satu model alas kaki yang terbuka pada bagian jari kaki atau tumit pemakainya. Bagian alas dihubungkan dengan tali atau sabuk yang berfungsi sebagai penjepit di bagian jari, punggung kaki, atau pergelangan kaki agar sandal tidak terlepas dari kaki pemakainya")
    var Topi = BarangJualan(id: 5, name: "Topi", category: "School", variant: "Black", price: 70000, images: "https://cf.shopee.co.id/file/c5ec1bd6ff4da10e7d1c5c7f3d20c0c4", Discount: 20, description: "Topi adalah suatu jenis penutup kepala. Penggunaan Topi dimaksudkan untuk beberapa alasan. Umumnya digunakan sebagai aksesoris pakaian dan sebagai pelindung dari sinar matahari.. Dalam beberapa upacara seremonial dan keagamaan penggunaan topi dapat menjadi keharusan")
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadBarang()
        let nib = UINib(nibName: "BarangCell", bundle: nil )
        collectView.register(nib, forCellWithReuseIdentifier: "BarangCell")
             
        
        collectView.delegate = self
        collectView.dataSource = self
        setupNavbar()
        // Do any additional setup after loading the view.
    }

    func LoadBarang(){
        shop.append(buku)
        shop.append(Tas)
        shop.append(Sepatu)
        shop.append(Sandal)
        shop.append(Topi)
    }
    
    func setupNavbar(){
           let searchController = UISearchController(searchResultsController: nil)
           Navbar.searchController = searchController
       }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shop.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "BarangCell"
        guard let cell = collectView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? BarangCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        let barangDetail = shop[indexPath.row]
        let price = "\(barangDetail.price)"
        let completeImage = barangDetail.images
        cell.BarangNameLabel.text = barangDetail.name
        cell.priceLabel.text = price
           
        cell.BarangimageView.downloaded(from: completeImage)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let barangDetail = shop[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "barangDetailStory") as! DetailViewController
        vc.nameProduct = barangDetail.name
        vc.priceProduct = barangDetail.price
        vc.imgUrl = barangDetail.images
        vc.desc = barangDetail.description
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }

   
}
