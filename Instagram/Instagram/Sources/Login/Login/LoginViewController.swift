//
//  ViewController.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/16.
//

import UIKit
import FBSDKLoginKit
class LoginViewController: UIViewController, LoginButtonDelegate {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var facebookBtn: FBLoginButton!
    
    lazy var dataManager: LoginDataManager = LoginDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.facebookBtn.delegate = self
        loginBtn.layer.cornerRadius = 5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let manager = LoginManager()
//        guard let facebookToken = AccessToken.current?.tokenString else {return}
        manager.logOut()
        
    }

    @IBAction func tappedToLogin(_ sender: Any) {
        
        let loginInput = LoginRequest(accountName: idTextField.text, password: pwTextField.text)
        print("input: \(loginInput)")
        
        dataManager.postLogin(loginInput, delegate: self)
    }
    
    @IBAction func tappedToJoin(_ sender: Any) {
        let manager = LoginManager()
        manager.logIn(permissions: ["public_profile"], from: self) { result, error in
                if let error = error {
                    print("Process error: \(error)")
                    return
                }else{
                    guard let facebookToken = AccessToken.current?.tokenString else {return}
                    print("facebookToken: \(facebookToken)")
                    guard let vc = self.storyboard?.instantiateViewController(identifier: "NameVC") as? NameViewController else { return }
                    vc.fbAccessToken = facebookToken
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                guard let result = result else {
                    print("No Result")
                    return
                }
                if result.isCancelled {
                    print("Login Cancelled")
                    return
                }
            // result properties
            //  - token : 액세스 토큰
            //  - isCancelled : 사용자가 로그인을 취소했는지 여부
            //  - grantedPermissions : 부여 된 권한 집합
            //  - declinedPermissions : 거부 된 권한 집합
        }
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
          print(error.localizedDescription)
          return
        }else{
            guard let facebookToken = AccessToken.current?.tokenString else {return}
            print("facebookToken: \(facebookToken)")
            guard let vc = self.storyboard?.instantiateViewController(identifier: "NameVC") as? NameViewController else { return }
            vc.fbAccessToken = facebookToken
            self.navigationController?.pushViewController(vc, animated: true)
        }
        print("Login")
 
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Logout")
    }
}

extension LoginViewController {
    func didSuccessSignIn(_ jwt: String, _ accountIdx: Int) {
//        print("jwtToken: \(result)")
        // jwt 토큰, 현재 user의 accountIdx userdefaults에 저장
        Constant.accessToken = jwt
        Constant.userIdx = accountIdx
        let alert = UIAlertController(title: "로그인", message: "성공하였습니다.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // 로그인 성공 시
            let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TabVC")
            self.changeRootViewController(mainTabBarController)
            
        }
        alert.addAction(okAction)
        present(alert,animated: false,completion: nil)
    }
    
    func failedToRequest(message: String) {
        let alert = UIAlertController(title: "로그인", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
//            self.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(okAction)
        present(alert,animated: false,completion: nil)
    }
}
