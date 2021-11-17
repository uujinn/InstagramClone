//
//  UserNameViewController.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/17.
//

import UIKit

class IDViewController: BaseViewController {

    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var textField: UITextField!
    var name: String = ""
    var password: String = ""
    var username: String = ""
    var fbAccessToken: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nextBtn.customButton()
    }
    

    @IBAction func goToNext(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "RegisterVC") as? RegisterViewController else { return }
        vc.username = textField.text!
        vc.fbAccessToken = fbAccessToken
        vc.password = password
        vc.accountName = textField.text!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
