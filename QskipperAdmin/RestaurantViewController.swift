//
//  RestaurantViewController.swift
//  QskipperAdmin
//
//  Created by Batch-1 on 24/05/24.
//

import UIKit
import MultipartFormDataKit

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
        
        
        
        let cuisine = selectedRowAt // Assuming this is a single selected cuisine

          // Create form data
        print(currentImage?.image , Restaurant_Name.text , selectedRowAt )
        if let formData = createFormData(image: (currentImage?.image)!, restaurantName: Restaurant_Name.text!, cuisines: selectedRowAt, estimatedTime: Int(EstimatedTime.text!)!) {
            
            debugPrint(formData)
            print("cxecwe")
              var request = URLRequest(url: URL(string: "https://rev-ee-gates-added.trycloudflare.com/register-restaurant")!)
              request.httpMethod = "POST"
//            let boundary =
//              request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
////            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
////                request.setValue("application/json", forHTTPHeaderField: "Accept")
            ///
        
            request.setValue(formData.contentType, forHTTPHeaderField: "Content-Type")

            request.httpBody = formData.body

              URLSession.shared.dataTask(with: request) { (data, response, error) in
                  if let error = error {
                      print("Error: \(error.localizedDescription)")
                      return
                  }
                  // Handle response
                  if let data = data, let responseString = String(data: data, encoding: .utf8) {
                      print("Response: \(responseString)")
                  }
              }.resume()
          } else {
              print("Failed to create form data.")
          }
      }
        
        
        
        
        
        

        
        
//        let formData = createFormData(currentImage?.image!: UIImage, Restaurant_Name: String , boolValue: Bool)
        
        
        
//        
//   Task.init(){
//            do{
//               try await  sendRestaurantData(restaurant: DataControlller.shared.restaurant)
//            }
//        }
//    }
//    func sendRestaurantData(restaurant: Restaurant) async throws {
//        guard let url = URL(string: "https://queueskipperbackend.onrender.com/register-restaurant") else { return }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        
//        let jsonEncoder = JSONEncoder()
//        let jsonData = try? jsonEncoder.encode(restaurant)
//        request.httpBody = jsonData
//        
//        let (data , response) = try await URLSession.shared.data(for: request)
//        
//        print(data)
//        if let string = String(data: data, encoding: .utf8)
//        {
//            debugPrint(string)
//        }
//        
//        guard let httpResponse = response as? HTTPURLResponse,
//              httpResponse.statusCode == 202 else{
//            print("errpor")
//            return
//            
//        }
//        
//    }
//    
    
    
    
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
        
        guard let url = URL(string: "https://rev-ee-gates-added.trycloudflare.com/create-product") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
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
    
    func createFormData(image: UIImage, restaurantName: String, cuisines: String, estimatedTime: Int) -> MultipartFormData.BuildResult? {
//        let boundary = UUID().uuidString
//        var formData = Data()
//
//        formData.append("--\(boundary)\r\n")
//        formData.append("Content-Disposition: form-data; name=\"restaurantName\"\r\n\r\n")
//        formData.append("\(restaurantName)\r\n")
//
//        if let imageData = image.jpegData(compressionQuality: 1.0) {
//            formData.append("--\(boundary)\r\n")
//            formData.append("Content-Disposition: form-data; name=\"restaurantImage\"; filename=\"restaurant.jpg\"\r\n")
//            formData.append("Content-Type: image/jpeg\r\n\r\n")
//            formData.append(imageData)
//            formData.append("\r\n")
//        }
//
//        formData.append("--\(boundary)\r\n")
//        formData.append("Content-Disposition: form-data; name=\"cuisines\"\r\n\r\n")
//        formData.append("\(cuisines)\r\n")
//
//        formData.append("--\(boundary)\r\n")
//        formData.append("Content-Disposition: form-data; name=\"estimatedTime\"\r\n\r\n")
//        formData.append("\(estimatedTime)\r\n")
//
//        formData.append("--\(boundary)--\r\n")
//
//        return formData
        
        let multipartFormData = try? MultipartFormData.Builder.build(
            with: [
                (
                    name: "restaurant_Name",
                    filename: nil,
                    mimeType: nil,
                    data: "Hello, World!".data(using: .utf8)!
                ),
                (
                    name: "cuisines",
                    filename: nil,
                    mimeType: nil,
                    data: "ccc".data(using: .utf8)!
                ),
                (
                    name: "estimatedTime",
                    filename: nil,
                    mimeType: nil,
                    data: "17".data(using: .utf8)!
                ),
                (
                    name: "bannerPhoto64Image",
                    filename: "example.jpeg",
                    mimeType: MIMEType.imageJpeg,
                    data: image.jpegData(compressionQuality: 0.1)!
                ),
            ],
            willSeparateBy: RandomBoundaryGenerator.generate()
        )
        
        return multipartFormData
    }
    
    
    
//    func createFormData(image: UIImage, restaurantName: String, cuisines: String, estimatedTime: Int) -> Data? {
//        let boundary = UUID().uuidString
//        var formData = Data()
//
//        // Add restaurant name to form data
//        formData.append("--\(boundary)\r\n")
//        formData.append("Content-Disposition: form-data; name=\"restaurantName\"\r\n\r\n")
//        formData.append(restaurantName.data(using: .utf8)!)
//        formData.append("\r\n")
//
//        // Add image data to form data
//        if let imageData = image.jpegData(compressionQuality: 1.0) {
//            formData.append("--\(boundary)\r\n")
//            formData.append("Content-Disposition: form-data; name=\"restaurantImage\"; filename=\"restaurant.jpg\"\r\n")
//            formData.append("Content-Type: image/jpeg\r\n\r\n")
//            formData.append(imageData)
//            formData.append("\r\n")
//        }
//
//        // Add cuisines to form data
//        formData.append("--\(boundary)\r\n")
//        formData.append("Content-Disposition: form-data; name=\"cuisines\"\r\n\r\n")
//        formData.append(cuisines.data(using: .utf8)!)
//        formData.append("\r\n")
//
//        // Add estimated time to form data
//        formData.append("--\(boundary)\r\n")
//           
//        formData.append("Content-Disposition: form-data; name=\"estimatedTime\"\r\n\r\n")
//           formData.append(String(estimatedTime))
//           formData.append("\r\n")
//
//        formData.append("--\(boundary)--\r\n")
//        
//        debugPrint(formData)
//
//        return formData
//    }
//
//    
//    
//    
//    
}
    


extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}


