//
//  IndicatorCell.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/26.
//

import UIKit

class IndicatorCell: UITableViewCell {

    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func start(){
        indicatorView.startAnimating()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
