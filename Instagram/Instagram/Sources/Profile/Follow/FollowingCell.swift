//
//  FollowingCell.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/25.
//

import UIKit
import Kingfisher

class FollowingCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var accountNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
