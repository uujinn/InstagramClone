//
//  ProfileReusableView.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/20.
//

import UIKit

class ProfileReusableView: UICollectionReusableView {

    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var suggestButton: UIButton!
    @IBOutlet weak var postCntLabel: UIButton!
    @IBOutlet weak var FollowerCntLabel: UIButton!
    @IBOutlet weak var FollowingCntLabel: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var BIOLabel: UILabel!
    @IBOutlet weak var tabStackView: UIStackView!
    @IBOutlet weak var feedButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var tagButton: UIButton!
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
