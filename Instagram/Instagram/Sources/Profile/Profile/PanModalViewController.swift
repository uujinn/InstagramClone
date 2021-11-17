//
//  PanModalViewController.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/21.
//

import UIKit
import PanModal

class PanModalViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    let arr = ["설정","보관","내 활동","QR 코드", "저장됨","로그아웃"]
    let imgarr = ["gearshape", "timer.square", "timer", "qrcode", "bookmark", "heart"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorInset.right = 0
        tableView.separatorInset.left = 65

    }
    
}

extension PanModalViewController: UITableViewDelegate, UITableViewDataSource, PanModalPresentable{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ModalCell") as! ModalCell
        
        cell.contentLabel.text = arr[indexPath.row]
        cell.iconImg.image = UIImage(systemName: "\(imgarr[indexPath.row])")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        if indexPath.row == 5{
            print("로그아웃")
            UserDefaults.standard.removeObject(forKey: "AccessToken")
            UserDefaults.standard.removeObject(forKey: "userIdx")
            let loginViewController = UIStoryboard(name: "LoginStoryboard", bundle: nil).instantiateViewController(identifier: "LoginVC")
            changeRootViewController(loginViewController)
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    var panScrollable: UIScrollView? {
        nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(450)
    }

    var longFormHeight: PanModalHeight {
        return .contentHeight(450)
    }
    
    

}

