//
//  ProfileFeedCell.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/25.
//

import UIKit

class ProfileFeedCell: UITableViewCell {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var likedCntLabel: UILabel!
    @IBOutlet weak var accountNameBottomLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var agoTimeLabel: UILabel!
    
    var images: [String] = ["https://firebasestorage.googleapis.com/v0/b/instagram-95771.appspot.com/o/image%2F01CE52D2-EBDD-459C-A8E3-E69FF1638195?alt=media&token=e80d12b8-4dcf-4545-9155-ebe2ad23a241","https://firebasestorage.googleapis.com/v0/b/instagram-95771.appspot.com/o/image%2F01CE52D2-EBDD-459C-A8E3-E69FF1638195?alt=media&token=e80d12b8-4dcf-4545-9155-ebe2ad23a241"]
    var imageViews = [UIImageView]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        scrollView.delegate = self
        profileImg.layer.cornerRadius = profileImg.frame.height/2
        profileImg.clipsToBounds = true
        
        addContentScrollView()
//        setPageControl()
        
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
            imageView.frame = CGRect(x: xPos, y: 0, width: Device.width, height: Device.width)
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
    
    private func setPageControlSelectedPage(currentPage: Int){
        pageControl.currentPage = currentPage
    
    }
 
    
}

extension ProfileFeedCell: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x/scrollView.frame.size.width
        setPageControlSelectedPage(currentPage: Int(round(value)))
    }
}
