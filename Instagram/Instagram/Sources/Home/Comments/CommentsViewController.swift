//
//  CommentsViewController.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/26.
//

import UIKit
import Kingfisher

class CommentsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var myProfileImg: UIImageView!
    @IBOutlet weak var feedProfileImg: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var agoTimeLabel: UILabel!
    @IBOutlet weak var commentField: UITextField!
    
//    var status = 0
    var postIdx = 0
    var accountIdx = Constant.userIdx
    var commentList: [CommentsList] = []
    var postData: CommentsPostData = CommentsPostData(accountIdx: 0, accountName: "", profilePhotoUrl: "", postIdx: 0, caption: "", agoTime: "")
    lazy var commentsdatamanager: CommentsDataManager = CommentsDataManager()
    
    lazy var postcommentsdatamanager: PostCommentsDataManager = PostCommentsDataManager()
    lazy var commentslikedatamanager: PostCommentsLikeDataManager = PostCommentsLikeDataManager()
    
    var getCommentsSuccess: Bool = false
    var blank: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("postIdx: \(postIdx)")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "CommentsCell", bundle: nil), forCellReuseIdentifier: "CommentsCell")

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        tableView.tableHeaderView = headerView
        headerView.backgroundColor = .white
        myProfileImg.layer.cornerRadius = myProfileImg.bounds.height / 2
        myProfileImg.clipsToBounds = true
        myProfileImg.kf.setImage(with: URL(string: Constant.userProfileImg!))
        feedProfileImg.layer.cornerRadius = feedProfileImg.bounds.height / 2
        
        commentsdatamanager.getComments(postIdx: postIdx, delegate: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if let headerView = tableView.tableHeaderView {
            let newSize = headerView.systemLayoutSizeFitting(CGSize(width: self.view.bounds.width, height: 0))
            if newSize.height != headerView.frame.size.height {
                headerView.frame.size.height = newSize.height
                tableView.tableHeaderView = headerView
            }
        }
    }

    @IBAction func uploadComment(_ sender: Any) {
        let commentInput = PostCommentsRequest(postIdx: postIdx, accountIdx: Constant.userIdx!, content: commentField.text!)
        postcommentsdatamanager.postComments(commentInput, delegate: self)
        tableView.reloadData()
    }
    
}


extension CommentsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as? CommentsCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        if getCommentsSuccess{
//            cell.totalLiked =
            cell.commentsIndex = commentList[indexPath.row].commentIdx!
            cell.commentsProfileImg.kf.setImage(with: URL(string: commentList[indexPath.row].profilePhotoUrl!))
            cell.commentsAgoTime.text = commentList[indexPath.row].agoTime
            cell.commentsContent.text = "\(commentList[indexPath.row].accountName ?? "") \(commentList[indexPath.row].content ?? "")"
            cell.postIdx = commentList[indexPath.row].postIdx!
//            let text = cell.accountNameBottom.text
//            let attributeString = NSMutableAttributedString(string: text!)
//            let font = UIFont.systemFont(ofSize: 15)
//            attributeString.addAttribute(.font, value: font, range: (text! as NSString).range(of: "\(postResultArr[indexPath.row].postList!.caption ?? "")"))
//            cell.accountNameBottom.attributedText = attributeString
//
            let text = cell.commentsContent.text
            let attributeString = NSMutableAttributedString(string: text!)
            let font = UIFont.systemFont(ofSize: 15)
            attributeString.addAttribute(.font, value: font, range: (text! as NSString).range(of: "\(commentList[indexPath.row].content ?? "")"))
            cell.commentsContent.attributedText = attributeString
            
            cell.likesCnt.text = commentList[indexPath.row].likeCnt! > 0 ? "좋아요 \(commentList[indexPath.row].likeCnt ?? postIdx)개" : ""
            cell.status = commentList[indexPath.row].isLiked!
            if cell.status == 1{
                cell.heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                cell.heartButton.tintColor = .red
            }else{
                cell.heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
                cell.heartButton.tintColor = .black
            }
        }
        

        return cell
    }
    
    
}

extension CommentsViewController {
    func getCommentsdidSuccess(result: CommentsResult){
//        print(result)
        commentList = result.commentList!
        commentList = commentList.reversed()
        postData = result.postData!
        print(commentList)
        feedProfileImg.kf.setImage(with: URL(string: postData.profilePhotoUrl))
        contentLabel.text = "\(postData.accountName)  \(postData.caption)"
        
        let text = contentLabel.text
        let attributeString = NSMutableAttributedString(string: text!)
        let font = UIFont.systemFont(ofSize: 15)
        attributeString.addAttribute(.font, value: font, range: (text! as NSString).range(of: "\(postData.caption)"))
        contentLabel.attributedText = attributeString
        
        agoTimeLabel.text = "\(postData.agoTime)"
        getCommentsSuccess = true
        tableView.reloadData()
    }
    
    func getCommentsfailedToRequest(message: String){
        print(message)
    }
}

extension CommentsViewController: CommentsCellDelegate{
    func didSelectedHeart(commentsIndex: Int, totalLiked: Int) {
        let CommentslikesInput = CommentsLikeRequest(commentIdx: commentsIndex, postIdx: postIdx)
        print("post 보냄")
        commentslikedatamanager.postCommentsLikes(CommentslikesInput, delegate: self)
    }
}

extension CommentsViewController {
    func postsCommentsdidSuccess(){
//        print("댓글 post 성공")
        commentsdatamanager.getComments(postIdx: postIdx, delegate: self)
        commentField.text = ""
//        tableView.reloadData()
    }
    
    func postsCommentsfailedToRequest(message: String){
        print(message)
    }
}

extension CommentsViewController{
    func postsCommentslikedidSuccess(){
//        self.status = status
        commentsdatamanager.getComments(postIdx: postIdx, delegate: self)
        print("post comment like 성공")
    }
    
    func postsCommentslikefailedToRequest(message: String){
        print(message)
    }
}
