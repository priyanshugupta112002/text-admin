//
//  RestaurantViewController.swift
//  QskipperAdmin
//
//  Created by Batch-1 on 24/05/24.
//

import UIKit

class RestaurantViewController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate, UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Cuisine.count
    }
    
    var selectedRowAt: String = ""
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cuisineCell", for: indexPath)

        let cuisineTypeForThisCell = Cuisine[indexPath.row]
        var contnet = cell.defaultContentConfiguration()
        
        contnet.text = cuisineTypeForThisCell
        cell.contentConfiguration = contnet
        
        
        if(selectedRowAt == cuisineTypeForThisCell){
            cell.accessoryType = .checkmark
        }else {
                cell.accessoryType = .none
        }
        return cell;
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedRowAt = Cuisine[indexPath.row]
//        if(!selectedRowAt.contains(cuisine.all[indexPath.row])){
//            selectedRowAt.append( cuisine.all[indexPath.row])gjh
//        }
        print(selectedRowAt)
        tableView.reloadData()
    }
    

    @IBOutlet var Restaurant_Name: UITextField!
    @IBOutlet var Restaurant_Image: UIImageView!
    @IBOutlet var Restaurant_Cusinie: UITableView!
    @IBOutlet var Submit_Information: UIButton!
    @IBOutlet var Restaurant_Button1: UIButton!
    @IBOutlet var Restaurant_Button2: UIButton!
    @IBOutlet var EstimatedTime: UITextField!
    
    
    var currentImage :UIImageView?
    

    
    
    
    
    @IBOutlet var Product_Name: UITextField!
    @IBOutlet var Product_Image: UIImageView!
    @IBOutlet var Preparation_Time: UITextField!
    @IBOutlet var Product_Price: UITextField!
    @IBOutlet var Product_Description: UITextField!
    
    
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        Product_Description.placeholder = "Enter The Description Of The Product"
        Restaurant_Cusinie.delegate = self
        Restaurant_Cusinie.dataSource = self
        
//        Restaurant_Name.text = DataControlller.shared.restaurant.restaurant_Name
        
        
    }
    
    @IBAction func OnSubmit(_ sender: UIButton) {
        
        DataControlller.shared.set_restaurant(name: Restaurant_Name.text!)
        DataControlller.shared.set_restaurant_banner(image: (currentImage?.image)!)
        DataControlller.shared.set_restaurant_cuisine(cuisine: selectedRowAt)
        DataControlller.shared.setEstimatedTime(time: Int(EstimatedTime.text!)!)
        print("Image String ")
        print(DataControlller.shared.restaurant.banner_photo)
   Task.init(){
            do{
               try await  sendRestaurantData(restaurant: DataControlller.shared.restaurant)
            }
        }
    }
    func sendRestaurantData(restaurant: Restaurant) async throws {
        guard let url = URL(string: "https://queueskipperbackend.onrender.com/register-restaurant") else {
            print("Error: Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        let contentType = "multipart/form-data; boundary=\(boundary)"
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        // Add other fields
        if let user = restaurant.user.data(using: .utf8) {
            body.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"user\"\r\n\r\n".data(using: .utf8)!)
            body.append(user)
        }
        
        if let restaurantName = restaurant.restaurant_Name.data(using: .utf8) {
            body.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"restaurant_Name\"\r\n\r\n".data(using: .utf8)!)
            body.append(restaurantName)
        }
        
        // Add image
        if let image = restaurant.banner_photo, let imageData = image.jpegData(compressionQuality: 0.5) {
            body.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"bannerPhoto64Image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
        }
        
        // Add other fields
        // ...
        
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        do {
            let (data , response) = try await URLSession.shared.data(for: request)
            
            print(data)
//            if let string = String(data: data, encoding: .utf8) {
//                debugPrint(string)
//            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error: Unexpected response status code")
                return
            }
        } catch {
            print("Error: \(error)")
        }
    }


    
    
    
    
    @IBAction func Upload_Banner_Photo(_ sender: UIButton) {
        
        if(sender.tag == 0){
            currentImage = Restaurant_Image
        }else if(sender.tag == 1){
            currentImage = Product_Image
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Choose Image Of Your Resturant", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {action in imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            let photoAction = UIAlertAction(title: "Photo", style: .default, handler: {action in imagePicker.sourceType = .photoLibrary
                self.present(imagePicker,animated: true , completion: nil)})
            alertController.addAction(photoAction)
            
        }
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.sourceView=sender
        present(alertController,animated: true ,completion: nil )
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectImage=info[.originalImage] as? UIImage else{return}
        currentImage?.image = selectImage
        dismiss(animated: true ,completion: nil)
                
    }
    
    
                                                                // ADD PRODUCT
 

    

    

     
    @IBAction func Add_Product(_ sender: Any) {
        
        DataControlller.shared.set_product_name(name: Product_Name.text ?? "product")
        DataControlller.shared.set_prepTime(time : Double(Preparation_Time.text!) ?? 0)
        DataControlller.shared.set_product_image(image: (currentImage?.image!)!)
        DataControlller.shared.set_product_price(price: Int(Product_Price.text!) ?? 0)
        DataControlller.shared.set_product_category(category:"Veg" )
        DataControlller.shared.set_product_description(description: Product_Description.text ?? "Veg")
        DataControlller.shared.set_products_resturation_id(id: DataControlller.shared.restaurant.user)
        
        
        
        Task.init(){
                 do{
                    try await  sendProductData(product: DataControlller.shared.product)
                 }
             }
         }
    
    
    
    
    
    func sendProductData(product : Product) async throws {
        
        guard let url = URL(string: "https://queueskipperbackend.onrender.com/create-product") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        debugPrint("Efwefewf")
        debugPrint(product)
        
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(product)
        request.httpBody = jsonData
        
        debugPrint(product)
        
        let (data , response) = try await URLSession.shared.data(for: request)
        
        print(data)
        if let string = String(data: data, encoding: .utf8)
        {
            debugPrint(string)
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 202 else{
            print("errpor")
            return
            
        }
        
        
        
    }
}
    





