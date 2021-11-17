//
//  CommentsCell.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/26.
//

import UIKit

protocol CommentsCellDelegate: AnyObject{
    func didSelectedHeart(commentsIndex: Int, totalLiked: Int)
}

class CommentsCell: UITableViewCell {

    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var commentsAgoTime: UILabel!
    @IBOutlet weak var commentsContent: UILabel!
    @IBOutlet weak var likesCnt: UILabel!
    @IBOutlet weak var commentsProfileImg: UIImageView!
    
    var commentsIndex: Int = 0
    var totalLiked: Int = 0
    var status: Int = 0
    var postIdx: Int = 0
    lazy var commentslikedatamanager: PostCommentsLikeDataManager = PostCommentsLikeDataManager()
    
    var delegate: CommentsCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        commentsProfileImg.layer.cornerRadius = commentsProfileImg.bounds.height / 2
        commentsProfileImg.clipsToBounds = true
        heartButton.addTarget(self, action: #selector(didSelectedHeart), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @objc func didSelectedHeart(_ sender: UIButton){
        delegate?.didSelectedHeart(commentsIndex: commentsIndex, totalLiked: totalLiked)
        if heartButton.imageView?.image == UIImage(systemName: "heart.fill"){
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
            heartButton.tintColor = .black
        }else if heartButton.imageView?.image == UIImage(systemName: "heart"){
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            heartButton.tintColor = .red
        }
    }
    
//    @IBAction func pressedHeartButton(_ sender: Any) {
//        if heartButton.imageView?.image == UIImage(systemName: "heart.fill"){
//            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
//            heartButton.tintColor = .black
//        }else if heartButton.imageView?.image == UIImage(systemName: "heart"){
//            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//            heartButton.tintColor = .red
//        }
//    }
}
