//
//  LoginAndRegisterViewController.swift
//  QskipperAdmin
//
//  Created by Batch-1 on 28/05/24.
//

import UIKit

class LoginAndRegisterViewController: UIViewController {
    
//    static let shared = LoginAndRegisterViewController()

    @IBOutlet var UserLogin_id: UITextField!
    @IBOutlet var userLoginPassword: UITextField!
    
    
    
    
    @IBOutlet var userRegisterEmailId: UITextField!
    @IBOutlet var userRegisterPassword: UITextField!
    @IBOutlet var userRegisterSecurityCode: UITextField!
    
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
       

        
    }

    @IBAction func RegisterNewUser(_ sender: UIButton) {
        
        Task {
             // Get user input
             let email = userRegisterEmailId.text!
             let password = userRegisterPassword.text!
             let securityCode = userRegisterSecurityCode.text!

             // Create a User instance
            let currentUser = user(email: email, password: password, securityCode: securityCode)
            
             do {
                 if let response = try await Networking.shared.registerUser(currentUser: currentUser) {
                     DataControlller.shared.setID(id: response.id)
                     
                     await MainActor.run {
                         // Update the UI with the response

                     }
                 }
                 
             } catch {
                 await MainActor.run {
                     // Handle errors on the main thread
                     print("Registration failed: \(error)")
                 }
             }
         }
     }
    
    @IBAction func SubmitNameUser(_ sender: UIButton) {
        
        Task{
            
            let userName = UserLogin_id.text!
            let userPassword = userLoginPassword.text!
            
            let currentUser = user(email: userName , password: userPassword)
            
            do {
                // login  user
               
                if let response = try await Networking.shared.loginUser(currentUser: currentUser) {
                    debugPrint(response)
                     performSegue(withIdentifier: "loginSuccess", sender: nil)
                    
                    if(DataControlller.shared.Currentuser.id != response.id){
                        DataControlller.shared.setID(id: response.id)
                    }
                    debugPrint(DataControlller.shared.Currentuser.id)
                    
                    await MainActor.run {
                    }
                }
            } catch {
                await MainActor.run {
                    // Handle errors on the main thread
                    print("login failed: \(error)")
                }
            }
            
        }
    }
}

