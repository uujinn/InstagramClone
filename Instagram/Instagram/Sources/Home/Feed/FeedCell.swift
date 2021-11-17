//
//  FeedCell.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/18.
//

import UIKit
import ScrollingPageControl
import Kingfisher

protocol FeedCellDelegate: AnyObject{
    func didSelectedMyPageButton(index: Int)
    func didSelectedHeart(isLiked: Int, postIndex: Int, totalLiked: Int)
    func bookmarkPressed()
}

class FeedCell: UITableViewCell {

    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var accountLabelBtn: UIButton!
    @IBOutlet weak var accountNameBottom: UILabel!
//    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentCnt: UILabel!
    @IBOutlet weak var agoTimeLabel: UILabel!
    @IBOutlet weak var likeCntLabel: UILabel!
    @IBOutlet weak var cntLabel: UILabel!
    
    var images: [String] = []
    var imageViews = [UIImageView]()
    
    var index: Int = 0
    var isLiked: Int = 0
    var postIndex: Int = 0
    var totalLiked: Int = 0
    var delegate: FeedCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        scrollView.delegate = self
        profileImg.layer.cornerRadius = profileImg.frame.height/2
        profileImg.clipsToBounds = true
        addContentScrollView()
        setPageControl()
        accountLabelBtn.addTarget(self, action: #selector(didSelectedMyPageButton), for: .touchUpInside)
        heartButton.addTarget(self, action: #selector(didSelectedHeart), for: .touchUpInside)
        bookmarkButton.addTarget(self, action: #selector(bookmarkPressed), for: .touchUpInside)
//        print("awakeFromNib - \(images)")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func addContentScrollView() {
        for i in 0..<images.count {
            let imageView = UIImageView()
            let xPos = Device.width * CGFloat(i)
            imageView.layer.masksToBounds = true
            imageView.contentMode = UIView.ContentMode.scaleAspectFill
//            print(Device.width)
//            print(xPos)
//            print(topView.bounds.width)
            imageView.frame = CGRect(x: xPos, y: 0, width: Device.width, height: scrollView.bounds.height)
//            print(imageView.bounds.width)
            imageView.kf.setImage(with: URL(string: "\(images[i])"))
            scrollView.addSubview(imageView)
            scrollView.contentSize.width = imageView.frame.width * CGFloat(i + 1)
        }
    }
    
    func setPageControl(){
        pageControl.numberOfPages = images.count
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = UIColor(hex: 0x007BFF)
    }
    
    func unsetPageControl(){
        pageControl.pageIndicatorTintColor = .white
        pageControl.currentPageIndicatorTintColor = .white
    }
    
    private func setPageControlSelectedPage(currentPage: Int){
        pageControl.currentPage = currentPage
    
    }
    
 
    @objc func didSelectedMyPageButton(_ sender: UIButton){
        delegate?.didSelectedMyPageButton(index: index)
    }
    
    @objc func didSelectedHeart(_ sender: UIButton){
        delegate?.didSelectedHeart(isLiked: isLiked, postIndex: postIndex, totalLiked: totalLiked)
//        if isLiked == 1{
//            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//        }else{
//            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
//        }
        if heartButton.imageView?.image == UIImage(systemName: "heart.fill"){
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
            heartButton.tintColor = .black
            cntLabel.text = "♥ \(totalLiked-1)명이 좋아합니다"
        }else if heartButton.imageView?.image == UIImage(systemName: "heart"){
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            heartButton.tintColor = .red
            cntLabel.text = "♥ \(totalLiked+1)명이 좋아합니다"
        }
        
    }
    
    @objc func bookmarkPressed(_ sender: UIButton) {
        delegate?.bookmarkPressed()
        if bookmarkButton.imageView?.image == UIImage(systemName: "bookmark.fill"){
            bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            bookmarkButton.tintColor = .black

        }else if bookmarkButton.imageView?.image == UIImage(systemName: "bookmark"){
            bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            bookmarkButton.tintColor = .black

        }
    }
}

extension FeedCell: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x/scrollView.frame.size.width
        setPageControlSelectedPage(currentPage: Int(round(value)))
    }
}
