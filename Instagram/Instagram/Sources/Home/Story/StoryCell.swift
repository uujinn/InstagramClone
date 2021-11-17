//
//  StoryCell.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/18.
//

import UIKit

class StoryCell: UICollectionViewCell {

    @IBOutlet weak var viewstoryImg: UIImageView!
    @IBOutlet weak var storyImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var button: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        button.layer.cornerRadius = button.bounds.height / 2
        button.clipsToBounds = true
        
        storyImg.clipsToBounds = true
        storyImg.layer.cornerRadius = 29
    }
}
