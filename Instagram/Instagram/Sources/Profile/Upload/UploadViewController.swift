//
//  UploadViewController.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/24.
//

import UIKit
import Kingfisher
class UploadViewController: UIViewController {

    @IBOutlet weak var previewImg: UIImageView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var facebookSwitch: UISwitch!
    
    @IBOutlet weak var nvView: UIView!
    @IBOutlet weak var tagview: UIView!
    @IBOutlet weak var facebookView: UIView!
    @IBOutlet weak var captionTextView: UITextView!
    var photoUrlArr: [String] = []
    
    lazy var dataManager: PostUploadDataManager = PostUploadDataManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImg.kf.setImage(with: URL(string: Constant.userProfileImg!))
        previewImg.kf.setImage(with: URL(string: photoUrlArr[0]))
        profileImg.layer.cornerRadius = (profileImg.frame.height)/2
        profileImg.clipsToBounds = true
        facebookSwitch.onTintColor = UIColor(hex: 0x87CEEB)
        facebookSwitch.tintColor = UIColor(hex: 0x87CEEB)
        viewCustom(view: nvView)
        viewCustom(view: tagview)
        viewCustom(view: facebookView)
    }
    
    func viewCustom(view: UIView){
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.5
    }
    
    @IBAction func pressedToGoback(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressedToPosts(_ sender: Any) {
        let postsInput = PostsRequest(accountIdx: Constant.userIdx!, caption: captionTextView.text, postTagList: [], postPhotoList: photoUrlArr)

    
        dataManager.postPosts(postsInput, delegate: self)
    }
}

extension UploadViewController {
    func didSuccessSignIn() {
        print("posts 성공!")
////        let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TabVC")
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabVC") as! UITabBarController
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    func failedToRequest(message: String) {
        print(message)
    }
}
