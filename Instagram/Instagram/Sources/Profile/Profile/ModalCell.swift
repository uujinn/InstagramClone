//
//  ModalCell.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/21.
//

import UIKit

class ModalCell: UITableViewCell {

    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

