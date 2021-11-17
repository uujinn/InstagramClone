//
//  EndLoginViewController.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/17.
//

import UIKit
import Alamofire

class RegisterViewController: BaseViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    var username: String = ""
    var accountName: String = ""
    var password: String = ""
    var fbAccessToken: String = ""
    lazy var dataManager: RegisterDataManager = RegisterDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = username
        nextBtn.customButton()
    }
    
    @IBAction func joinCompleted(_ sender: Any) {
        // Requst Register
        self.dismissKeyboard()

        let input = RegisterRequest(fbAccessToken: fbAccessToken, accountName: accountName, password: password, name: username)
        print("input: \(input)")
        
        dataManager.postRegister(input, delegate: self)
        
    }
    

}
extension RegisterViewController {
    func didSuccessSignIn() {

        let alert = UIAlertController(title: "회원가입", message: "성공하였습니다.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(okAction)
        present(alert,animated: false,completion: nil)
    }
    
    func failedToRequest(message: String) {
        let alert = UIAlertController(title: "회원가입", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(okAction)
        present(alert,animated: false,completion: nil)
    }
}
