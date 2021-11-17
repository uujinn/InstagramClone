//
//  ProfileEditViewController.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/27.
//

import UIKit
import Kingfisher

class ProfileEditViewController: UIViewController {

    @IBOutlet weak var nametf: UITextField!
    @IBOutlet weak var accountNametf: UITextField!
    @IBOutlet weak var websitetf: UITextField!
    @IBOutlet weak var biotv: UITextView!
    
    @IBOutlet weak var profileImg: UIImageView!
    
    lazy var datamanager: ProfileAccountDataManager = ProfileAccountDataManager()
    lazy var profileEditmanager: ProfileEditDataManager = ProfileEditDataManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        datamanager.getProfileAccount(delegate: self)
        
        let completedEditBtn = UIBarButtonItem.init(title: "완료",style: .plain, target: self, action: #selector(completedEdit(_:)))
        completedEditBtn.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = completedEditBtn
        
        profileImg.layer.cornerRadius = profileImg.bounds.height/2
        profileImg.clipsToBounds = true
    }
    

    @objc func completedEdit(_ sender: UIBarButtonItem) {
        print("프로필 편집 시작")
        let editInput = ProfileEditRequest(profilePhotoUrl: "http://poomasi.pushweb.kr/common/img/default_profile.png", name: self.nametf.text!, accountName: self.accountNametf.text!, bio: self.biotv.text)
        profileEditmanager.postPosts(editInput, delegate: self)
     }

}

extension ProfileEditViewController{
    func didSuccessgetProfileAccount(result: ProfileResult){
//        print(result)
        profileImg.kf.setImage(with: URL(string: result.profilePhotoUrl))
        nametf.text = result.name
        accountNametf.text = result.accountName
        biotv.text = result.bio
    }
    
    func failedToRequestProfileAccount(message: String){
        print(message)
    }
}

extension ProfileEditViewController{
    func didSuccessEdit(){
        print("프로필 편집을 마쳤습니다.")
        self.navigationController?.popViewController(animated: true)
    }
    
    func failedToRequestEdit(message: String){
        print(message)
    }
}
