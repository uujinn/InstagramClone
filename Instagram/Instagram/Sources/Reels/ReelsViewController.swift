//
//  ReelsViewController.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/28.
//

import UIKit

class ReelsViewController: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        img.layer.borderColor = UIColor.white.cgColor
        img.layer.borderWidth = 1
        img.layer.cornerRadius = 5
        
        profileImg.layer.cornerRadius = profileImg.bounds.height / 2
        profileImg.clipsToBounds = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
