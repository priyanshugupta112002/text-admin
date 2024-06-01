//
//  All_Product_ViewController.swift
//  QskipperAdmin
//
//  Created by Batch-1 on 28/05/24.
//

import UIKit

class All_Product_ViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        allProduct.count
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "All_Product ", for: indexPath) as! All_Product_CollectionViewCell
//        cell.Product_Image.image = allProduct[indexPath.row].image
//        cell.Product_Price.text = "\(allProduct[indexPath.row].price)"
        
        return cell
        
    }
    

    @IBOutlet var All_ProductCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var firstNib = UINib(nibName: "All_Product", bundle: nil)
        All_ProductCollectionView.register(firstNib, forCellWithReuseIdentifier: "All_Product")
        
        All_ProductCollectionView.dataSource = self
        All_ProductCollectionView.delegate = self
        
        All_ProductCollectionView.setCollectionViewLayout(generateLayout(), animated: true)

        // Do any additional setup after loading the view.
    }
    
    func generateLayout () -> UICollectionViewLayout{
        
        let layout = UICollectionViewCompositionalLayout{
            (section,env) -> NSCollectionLayoutSection? in
            
        
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.9))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3 )
            
            let secction = NSCollectionLayoutSection(group: group)
            return secction
            
        }
        return layout
        
    }
    
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
