//
//  DetailFeedViewController.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/25.
//

import UIKit
import Kingfisher

class ProfileFeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var profilefeeddataManager: ProfileFeedDataManager = ProfileFeedDataManager()
    
    var ProfileFeedResultArr: [ProfileFeedResult] = []
    var successProfileFeed = false
    var photoImgArr = [[String]]()
    var userIndex = Constant.userIdx
    var cellIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Constant.userIdx!)
        
        profilefeeddataManager.getProfileFeed(userIndex: userIndex!,delegate: self)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ProfileFeedCell", bundle: .main), forCellReuseIdentifier: "ProfileFeedCell")
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 700
        tableView.separatorInset.right = 0
        tableView.separatorInset.left = -40
        
    }
    

}

extension ProfileFeedViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileFeedResultArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileFeedCell", for: indexPath) as! ProfileFeedCell
        cell.selectionStyle = .none
        if successProfileFeed{
            cell.accountNameLabel.text = "\(ProfileFeedResultArr[indexPath.row].postList!.accountName)"
            cell.profileImg.kf.setImage(with: URL(string: "\(ProfileFeedResultArr[indexPath.row].postList!.profilePhotoUrl)"))
            cell.accountNameBottomLabel.text = "\(ProfileFeedResultArr[indexPath.row].postList!.accountName)  \(ProfileFeedResultArr[indexPath.row].postList!.caption ?? "")"
            let text = cell.accountNameBottomLabel.text
            let attributeString = NSMutableAttributedString(string: text!)
            let font = UIFont.systemFont(ofSize: 15)
            attributeString.addAttribute(.font, value: font, range: (text! as NSString).range(of: "\(ProfileFeedResultArr[indexPath.row].postList!.caption ?? "")"))
            cell.accountNameBottomLabel.attributedText = attributeString
//            if cell.isLiked == 1{
//                cell.heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//                cell.heartButton.tintColor = .red
//            }else{
//                cell.heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
//                cell.heartButton.tintColor = .black
//            }
            cell.agoTimeLabel.text = ProfileFeedResultArr[indexPath.row].postList!.agoTime
            cell.commentLabel.text = ProfileFeedResultArr[indexPath.row].postList!.commentTotal! > 0 ? "댓글 \(ProfileFeedResultArr[indexPath.row].postList!.commentTotal ?? 0)개 모두 보기" : ""
            cell.likedCntLabel.text = "♥ \(ProfileFeedResultArr[indexPath.row].postList!.postLikeTotal ?? 0)명이 좋아합니다"
            cell.images = photoImgArr[indexPath.row]
            cell.addContentScrollView()
            if photoImgArr[indexPath.row].count != 1{
                cell.setPageControl()
            }
        }
        
        return cell
    }
    
    func scrollTo(section: Int, row: Int){
        DispatchQueue.main.async{
            let indexPath = IndexPath(row: row, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
    
}

extension ProfileFeedViewController{
    func didSuccessGetProfileFeed(result: [ProfileFeedResult]){

        print("ProfileFeed API 가져오기 성공")
        ProfileFeedResultArr = result
        for i in 0...ProfileFeedResultArr.count-1{
            photoImgArr.append([])
            for j in 0...(ProfileFeedResultArr[i].postPhotoUrlListObj?.urlList!.count)!-1{
                photoImgArr[i].append((ProfileFeedResultArr[i].postPhotoUrlListObj?.urlList![j].url)!)
            }
        }
        
        print(photoImgArr)
        
        successProfileFeed = true
        tableView.reloadData()
        scrollTo(section: 0, row: cellIndex)
    }
    
    func failedToRequestProfileFeed(message: String){
        print(message)
    }
}
