//
//  ShopViewController.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/28.
//

import UIKit

class ShopViewController: UIViewController {

    let imageList = ["1","2","3","4","5","6","7","8","9","10"]
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        setupFlowLayout()
    }
    

}

extension ShopViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCell", for: indexPath) as! ShopCell
        
        cell.img.image = UIImage(named: "\(imageList[indexPath.row])")
        
        return cell
    }

    
    private func setupFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.minimumLineSpacing = 1

        let width = (collectionView.frame.size.width - 3 * flowLayout.minimumInteritemSpacing)/2
        flowLayout.itemSize = CGSize(width: width * 1 , height: width * 1)
        self.collectionView.collectionViewLayout = flowLayout
    }
    
    // 위 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width: CGFloat = (view.bounds.width - 3 * 1 )/2

        let size = CGSize(width: width, height: width)
        return size
    }

    

}
