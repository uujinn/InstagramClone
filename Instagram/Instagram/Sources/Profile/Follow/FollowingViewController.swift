//
//  FollowingViewController.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/24.
//

import UIKit

class FollowingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    lazy var dataManager: FollowingDataManager = FollowingDataManager()
    var followingList: [FollowingResult] = []
    var userIdx = 0
    var successFollowingList = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(userIdx)
        tableView.delegate = self
        tableView.dataSource = self

        dataManager.getFollowingList(accountIdx: userIdx, delegate: self)
        
    }
    


}

extension FollowingViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowingCell") as! FollowingCell
        cell.profileImg.layer.cornerRadius = cell.profileImg.bounds.height / 2
        cell.profileImg.clipsToBounds = true
        if successFollowingList{
            cell.profileImg.kf.setImage(with: URL(string: "\(followingList[indexPath.row].profilePhotoUrl)"))
            cell.accountNameLabel.text = followingList[indexPath.row].accountName
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

extension FollowingViewController{
    func didSuccessSignIn(result: [FollowingResult]) {
        followingList = result
        print("팔로잉 리스트 가져오기 성공")
        successFollowingList = true
        tableView.reloadData()
    }
    
    func failedToRequest(message: String) {
        print(message)
    }
}

