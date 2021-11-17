//
//  ProfileHeaderViewController.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/19.
//

import UIKit
import Kingfisher

class ProfileViewController: BaseViewController {
        
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    lazy var dataManager: ProfileDataManager = ProfileDataManager()
    var dataReload = false
    
    var feedPreviewArr: [FeedPreviewList] = []
//    var storyCntArr: [StoryCnt] = []
    var profileDataSet: ProfileData?
    
    var accountIdx: Int = Constant.userIdx!
    
    let headerView = ProfileReusableView()
    
    
    var addButton: UIBarButtonItem!
    let defaultProfileImg = "http://poomasi.pushweb.kr/common/img/default_profile.png"
    override func viewWillAppear(_ animated: Bool) {

        dataManager.getProfile(accountIdx: accountIdx ,delegate: self)
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self

        
        // 로그인한 사용자의 mypage
        if accountIdx == Constant.userIdx{
            let barbuttonIcon = UIBarButtonItem.init(image: UIImage(systemName: "line.3.horizontal"),style: .plain, target: self, action: #selector(addButtonAction(_:)))
                barbuttonIcon.tintColor = UIColor.black
            self.navigationItem.rightBarButtonItem = barbuttonIcon
            let uploadbuttonIcon = UIBarButtonItem.init(image: UIImage(systemName: "plus.app"),style: .plain, target: self, action: #selector(addUploadButtonAction(_:)))
                uploadbuttonIcon.tintColor = UIColor.black
            self.navigationItem.rightBarButtonItems = [barbuttonIcon, uploadbuttonIcon]
            
        }else{
            
        }
        
        if #available(iOS 15, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.backgroundColor = .white
            self.tabBarController?.tabBar.standardAppearance = tabBarAppearance
            self.tabBarController?.tabBar.scrollEdgeAppearance = tabBarAppearance
        } else {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.backgroundColor = .white
            self.tabBarController?.tabBar.standardAppearance = tabBarAppearance
            self.tabBarController?.tabBar.scrollEdgeAppearance = tabBarAppearance
        }
    }

    @objc func addButtonAction(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "MyPageStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PanModalVC") as! PanModalViewController
        self.presentPanModal(vc)
     }
    
    @objc func addUploadButtonAction(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "MyPageStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UploadPanModalVC") as! UploadPanModalViewController
        self.presentPanModal(vc)
    }
    
}

extension ProfileViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if !dataReload{
            return 0
        }
        
        return feedPreviewArr.count
//        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedPreviewCell", for: indexPath) as! FeedPreviewCell
        cell.previewImg.kf.setImage(with: URL(string: "\(feedPreviewArr[feedPreviewArr.count - indexPath.row - 1].url ?? defaultProfileImg)"))
        if feedPreviewArr[feedPreviewArr.count - indexPath.row - 1].photoCnt <= 1{
            cell.bundleImg.image = nil
        }else{
            cell.bundleImg.image = UIImage(systemName: "square.fill.on.square.fill")
        }
        
            
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        switch kind {
            case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "reusableView", for: indexPath) as? ProfileReusableView
            // custom headerview objects
            headerView?.profileImg.layer.cornerRadius = (headerView?.profileImg.frame.height)!/2
            headerView?.profileImg.clipsToBounds = true
            headerView?.suggestButton.customButton()
            headerView?.suggestButton.layer.borderColor = UIColor.lightGray.cgColor
            headerView?.suggestButton.layer.borderWidth = 1
            headerView?.followButton.customButton()
            headerView?.messageButton.customButton()
            headerView?.messageButton.layer.borderColor = UIColor.lightGray.cgColor
            headerView?.messageButton.layer.borderWidth = 1
            headerView?.followButton.layer.borderColor = UIColor.lightGray.cgColor
            headerView?.followButton.layer.borderWidth = 1
            
            headerView?.followButton.addTarget(self, action: #selector(cellButtonClick), for: .touchUpInside)
            


            if accountIdx == Constant.userIdx{
                view.setNeedsLayout()
                let profileEditButton = UIButton()
                profileEditButton.translatesAutoresizingMaskIntoConstraints = false
                headerView?.addSubview(profileEditButton)
                profileEditButton.snp.makeConstraints({
                    make in
                    make.height.equalTo(30)
                    make.left.equalToSuperview().offset(20)
                    make.right.equalToSuperview().offset(-50)
                    make.bottom.equalToSuperview().offset(-55)
                })
                
                let editAttributedText = NSMutableAttributedString(string: "프로필 편집", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)])
                profileEditButton.setAttributedTitle(editAttributedText, for: .normal)
                profileEditButton.setTitleColor(.black, for: .normal)
                profileEditButton.layer.cornerRadius = 5
                profileEditButton.layer.borderColor = UIColor.systemGray2.cgColor
                profileEditButton.layer.borderWidth = 1
                
                headerView?.messageButton.alpha = 0
                headerView?.followButton.alpha = 0
                profileEditButton.addTarget(self, action: #selector(pressedToEditProfile), for: .touchUpInside)
            }

            if dataReload{

                self.navigationItem.title = "\(profileDataSet!.accountName)"
                navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),NSAttributedString.Key.foregroundColor: UIColor.black]
                headerView?.profileImg.kf.setImage(with: URL(string: "\(profileDataSet!.profilePhotoUrl ?? defaultProfileImg)"))
                Constant.userProfileImg = profileDataSet!.profilePhotoUrl ?? defaultProfileImg
                headerView?.nameLabel.text = profileDataSet!.name
                headerView?.BIOLabel.text = profileDataSet!.bio
                headerView?.postCntLabel.setTitle("\(profileDataSet!.postCnt)", for: .normal)
                headerView?.FollowerCntLabel.setTitle("\(profileDataSet!.FollowerCnt)", for: .normal)
                headerView?.FollowingCntLabel.setTitle("\(profileDataSet!.FollowingCnt)", for: .normal)

            }
            
            headerView?.FollowerCntLabel.addTarget(self, action: #selector(pressedToFollowList), for: .touchUpInside)
            headerView?.FollowingCntLabel.addTarget(self, action: #selector(pressedToFollowList), for: .touchUpInside)
            headerView?.feedButton.addTarget(self, action: #selector(pressedToFeed), for: .touchUpInside)
            headerView?.playButton.addTarget(self, action: #selector(pressedToTag), for: .touchUpInside)
            headerView?.tagButton.addTarget(self, action: #selector(pressedToTag), for: .touchUpInside)
            
            return headerView!
            
            
            default:
                assert(false, "false")
            
        }
    }
    
    @objc func cellButtonClick(_ sender: UIButton) {
        print("following/follow 버튼 clicked")
    }
    
    @objc func pressedToEditProfile(_ sender: UIButton){
        print("프로필 편집 버튼 clicked")
        guard let vc = self.storyboard?.instantiateViewController(identifier: "ProfileEditVC") as? ProfileEditViewController else { return }
//        vc.cellIndex = indexPath.row
//        vc.userIdx = profileDataSet!.accountIdx
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func pressedToFeed(_ sender: UIButton){
        dataManager.getProfile(accountIdx: accountIdx ,delegate: self)
        collectionView.reloadData()
    }
    
    @objc func pressedToTag(_ sender: UIButton){
        dataReload = false
        collectionView.reloadData()
    }
    
    @objc func pressedToFollowList(){
        let vc = UpperTabViewController()
        vc.userIdx = profileDataSet!.accountIdx
        vc.follower = profileDataSet!.FollowerCnt
        vc.following = profileDataSet!.FollowingCnt
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        guard let vc = self.storyboard?.instantiateViewController(identifier: "ProfileFeedVC") as? ProfileFeedViewController else { return }
        vc.cellIndex = indexPath.row
//        vc.userIdx = profileDataSet!.accountIdx
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{

        let width: CGFloat = collectionView.frame.width
        let height: CGFloat = 310

        return CGSize(width: width, height: height)
//        let P = ProfileReusableView()
//
//        P.translatesAutoresizingMaskIntoConstraints = false
//        let size = P.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        
//        return size
    }
    
    private func setupFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.minimumLineSpacing = 1

        let width = (collectionView.frame.size.width - 4 * flowLayout.minimumInteritemSpacing)/3
        flowLayout.itemSize = CGSize(width: width * 1 , height: width * 1)
        self.collectionView.collectionViewLayout = flowLayout
    }
    
    // 위 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width: CGFloat = (view.bounds.width - 4 * 1 )/3

        let size = CGSize(width: width, height: width)
        return size
    }

    

}

extension ProfileViewController {
    func didSuccessSignIn(result: Result) {
 
        feedPreviewArr = result.feedPreviewList!
//        storyCntArr = result.storyCnt!
        
        Constant.userProfileImg = result.profileData?.profilePhotoUrl // 흠..
        
        profileDataSet = result.profileData
        
        dataReload = true
        collectionView.reloadData()
    }
    
    func failedToRequest(message: String) {
        print(message)
    }
}

