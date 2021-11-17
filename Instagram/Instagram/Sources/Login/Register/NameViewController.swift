//
//  NameViewController.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/16.
//

import UIKit

class NameViewController: BaseViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    var name: String = ""
    var fbAccessToken: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.customButton()
    }
    
    @IBAction func goToNext(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "PasswordVC") as? PasswordViewController else { return }
        name = nameTextField.text ?? "user"
        vc.fbAccessToken = fbAccessToken
        vc.name = name
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
