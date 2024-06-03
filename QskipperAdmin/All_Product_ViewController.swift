//
//  All_Product_ViewController.swift
//  QskipperAdmin
//
//  Created by Batch-1 on 28/05/24.
//

import UIKit

class All_Product_ViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    

    

    @IBOutlet var All_ProductCollectionView: UICollectionView!
    
    
    override func viewDidLoad()  {
        
        super.viewDidLoad()
        
        
        async {
            
            do{
                 let response = try await productApi.shared.getAllProduct()
                debugPrint(response)
                    DataControlller.shared.set_all_product(product: response)
                    
                    await MainActor.run {
                        // Update the UI with the response
                        self.All_ProductCollectionView.reloadData()

                    }
            
            }
            catch{
                await MainActor.run {
                    // Handle errors on the main thread
                    print("Registration failed: \(error)")
                }
            }
           
        }
        
      
        
        var firstNib = UINib(nibName: "All_Products", bundle: nil)
        All_ProductCollectionView.register(firstNib, forCellWithReuseIdentifier: "All_Products")
        
        All_ProductCollectionView.dataSource = self
        All_ProductCollectionView.delegate = self
        
        All_ProductCollectionView.setCollectionViewLayout(generateLayout(), animated: true)

        // Do any additional setup after loading the view.
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
      
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        debugPrint(DataControlller.shared.get_all_product.count)
        return DataControlller.shared.get_all_product.count
        
        
     
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "All_Products", for: indexPath) as! All_Product_CollectionViewCell
//        cell.Product_Image.image = DataControlller.shared.get_all_product[indexPath.row].

        cell.Product_Price.text = "\(DataControlller.shared.get_all_product[indexPath.row].product_price)"
        cell.Product_Name.text = "\(DataControlller.shared.get_all_product[indexPath.row].product_name)"
        
        return cell
        
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
    
    


}
