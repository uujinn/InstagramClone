//
//  FollowerViewController.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/24.
//

import UIKit
import Kingfisher

class FollowerViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var dataManager: FollowerDataManager = FollowerDataManager()
    var followerList: [FollowerResult] = []
    var userIdx = 0
    var successFollowerList = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(userIdx)
        tableView.delegate = self
        tableView.dataSource = self

        dataManager.getFollowerList(accountIdx: userIdx, delegate: self)
        
    }
    


}

extension FollowerViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowerCell") as! FollowerCell
        
        cell.profileImg.layer.cornerRadius = cell.profileImg.bounds.height / 2
        cell.profileImg.clipsToBounds = true
        if successFollowerList{
            cell.profileImg.kf.setImage(with: URL(string: "\(followerList[indexPath.row].profilePhotoUrl)"))
            cell.accountNameLabel.text = followerList[indexPath.row].accountName
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}

extension FollowerViewController{
    func didSuccessSignIn(result: [FollowerResult]) {
        followerList = result
        print("팔로워 리스트 가져오기 성공")
        successFollowerList = true
        tableView.reloadData()
    }
    
    func failedToRequest(message: String) {
        print(message)
    }
}
