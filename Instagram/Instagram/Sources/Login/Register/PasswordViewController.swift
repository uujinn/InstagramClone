//
//  PasswordViewController.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/16.
//

import UIKit
import SimpleCheckbox

class PasswordViewController: BaseViewController {

    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var checkBox: Checkbox!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var name: String = ""
    var password: String = ""
    var fbAccessToken: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkBoxSetting()
        nextBtn.customButton()
        
    }
    
    func checkBoxSetting(){
        checkBox.checkedBorderColor = UIColor(hex: 0x3B97FD)
        checkBox.uncheckedBorderColor = .gray
        checkBox.borderStyle = .square
        checkBox.checkmarkColor = UIColor(hex: 0x3B97FD)
        checkBox.checkboxFillColor = .white
        checkBox.checkmarkStyle = .tick
        checkBox.addTarget(self, action: #selector(checkboxValueChanged(sender:)), for: .valueChanged)
    }
    
    @objc func checkboxValueChanged(sender: Checkbox) {
//        if sender.isChecked{
//            print("비밀번호가 저장됩니다.")
//        }else{
//            print("비밀번호를 저장하지 않습니다.")
//        }
//        print("checkbox value change: \(sender.isChecked)")
    }
    @IBAction func goToNext(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "IdVC") as? IDViewController else { return }
        vc.fbAccessToken = fbAccessToken
        vc.name = name
        password = passwordTextField.text!
        vc.password = password
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
