//
//  HomeViewController.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/17.
//

import UIKit
import Kingfisher

class HomeViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var storydataManager: StoryDataManger = StoryDataManger()
    lazy var postdataManger: PostDataManger = PostDataManger()
    lazy var likesdataManager: LikesDataManager = LikesDataManager()
    
    var postResultArr: [PostResult] = []
    var storyResultArr = StoryResult()
    
    var successPost = false
    var successStory = false
    
    var photoImgArr = [[String]]()
    var pageCnt = 1
    var fetchingMore = false
    var isPaging = false
    override func viewDidLoad() {
        super.viewDidLoad()
        print("accoundIDx: \(Constant.userIdx)")
        self.navigationController?.navigationBar.isHidden = true
        
        storydataManager.getStory(delegate: self)
        postdataManger.getPost(page: pageCnt, delegate: self)
        print("\(pageCnt) 데이터 불러오기")
        
//        print("viewDidLoad")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FeedCell", bundle: .main), forCellReuseIdentifier: "FeedCell")
        
        tableView.register(UINib(nibName: "IndicatorCell", bundle: .main), forCellReuseIdentifier: "IndicatorCell")
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 700
        tableView.separatorInset.right = 0
        tableView.separatorInset.left = -40

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "StoryCell", bundle: .main), forCellWithReuseIdentifier: "StoryCell")

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = layout
        self.collectionView.isPagingEnabled = true
    
//        tableView.reloadData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        hidesBottomBarWhenPushed = false
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return postResultArr.count
        }
        else if section == 1 {
            return 1
        }
        
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
            cell.selectionStyle = .none
            if successPost{
                cell.index = postResultArr[indexPath.row].postList!.accountIdx
                cell.isLiked = postResultArr[indexPath.row].postList!.isPostLiked
                cell.postIndex = postResultArr[indexPath.row].postList!.postIdx
                cell.totalLiked = postResultArr[indexPath.row].postList!.postLikeTotal
                cell.delegate = self
                cell.accountLabelBtn.setTitle("\(postResultArr[indexPath.row].postList!.accountName)", for: .normal)
                cell.profileImg.kf.setImage(with: URL(string: "\(postResultArr[indexPath.row].postList!.profilePhotoUrl)"))
                cell.accountNameBottom.text = "\(postResultArr[indexPath.row].postList!.accountName)  \(postResultArr[indexPath.row].postList!.caption ?? "")"
                let text = cell.accountNameBottom.text
                let attributeString = NSMutableAttributedString(string: text!)
                let font = UIFont.systemFont(ofSize: 15)
                attributeString.addAttribute(.font, value: font, range: (text! as NSString).range(of: "\(postResultArr[indexPath.row].postList!.caption ?? "")"))
                cell.accountNameBottom.attributedText = attributeString
                if cell.isLiked == 1{
                    cell.heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                    cell.heartButton.tintColor = .red
                }else{
                    cell.heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
                    cell.heartButton.tintColor = .black
                }
    //            cell.captionLabel.text = postResultArr[indexPath.row].postList!.caption
                cell.agoTimeLabel.text = postResultArr[indexPath.row].postList!.agoTime
                cell.commentCnt.text = postResultArr[indexPath.row].postList!.commentTotal > 0 ? "댓글 \(postResultArr[indexPath.row].postList!.commentTotal)개 모두 보기" : ""
                cell.likeCntLabel.text = "♥ \(postResultArr[indexPath.row].postList!.postLikeTotal)명이 좋아합니다"
                
                cell.images = photoImgArr[indexPath.row]
    //            print("photoImagArr[\(indexPath.row)] \(photoImgArr[indexPath.row])")
                cell.addContentScrollView()
                if photoImgArr[indexPath.row].count != 1{
//                    print("\(indexPath.row): \(photoImgArr[indexPath.row])")
                    cell.setPageControl()
                }else{
                    cell.unsetPageControl()
                }
            }

            
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "IndicatorCell", for: indexPath) as? IndicatorCell else {
                return UITableViewCell()
            }
                
            cell.start()
                
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
        guard let vc = self.storyboard?.instantiateViewController(identifier: "CommentsVC") as? CommentsViewController else { return }

        vc.postIdx = postResultArr[indexPath.row].postList!.postIdx
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            if tableView.contentOffset.y > (tableView.contentSize.height - tableView.bounds.size.height) {
                print("끝에 도달")
                isPaging = true
                if !fetchingMore {
                    fetchingMore = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: { [self] in
                        self.pageCnt += 1
                        print("\(pageCnt) 데이터 불러오기")
                        self.postdataManger.getPost(page: self.pageCnt, delegate: self)
                        self.fetchingMore = false
                        self.isPaging = false
                        self.tableView.reloadData()
                    })
                }
            }
        }
    
}

extension HomeViewController: FeedCellDelegate{
    func bookmarkPressed() {
        self.presentAlert(title: "해당 게시글을 북마크하였습니다.")
    }
    
    func didSelectedMyPageButton(index: Int) {
        let storyboard = UIStoryboard(name: "MyPageStoryboard", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "ProfileVC") as? ProfileViewController else { return }

        vc.accountIdx = index
        
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func didSelectedHeart(isLiked: Int, postIndex: Int, totalLiked: Int) {
        let likesInput = LikesRequest(postIdx: postIndex, accountIdx: Constant.userIdx!)
        likesdataManager.postLikes(parameters: likesInput, delegate: self)
        print("하트상태: \(isLiked)")
    }
    
    
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if successStory{
            print(storyResultArr.elseStory!.count)
            
            return storyResultArr.elseStory!.count + 1
            
        }
        else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCell", for: indexPath) as! StoryCell
        
        switch indexPath.row{
        case 0:
            cell.storyImg.kf.setImage(with: URL(string: "\(storyResultArr.myStory?.profilePhotoUrl ?? "")"))
            cell.userName.text = storyResultArr.myStory?.accountName
            
            cell.viewstoryImg.image = UIImage(named: "viewstory")
        
        default:
            cell.storyImg.kf.setImage(with: URL(string: "\(storyResultArr.elseStory![indexPath.row - 1].profilePhotoUrl ?? "")"))
            cell.userName.text = storyResultArr.elseStory![indexPath.row - 1].accountName
            cell.button.alpha = 0
            if storyResultArr.elseStory![indexPath.row - 1].storyList![0].isViewd == 0{
                cell.viewstoryImg.image = UIImage(named: "yetviewstory")
            }else{
                cell.viewstoryImg.image = UIImage(named: "viewstory")
            }
            
        }
        
        return cell

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 90)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("story 선택: \(indexPath.row)")
        guard let vc = self.storyboard?.instantiateViewController(identifier: "StoryVC") as? StoryViewController else { return }
        self.present(vc, animated: true, completion: nil)
    }

}

extension HomeViewController {
    func didSuccessSignIn(result: [PostResult]) {
        var newIndex = 0
        let indexList = [5,4,3,2,1]
        print("Posts API 가져오기 성공")
//        print(result)
        postResultArr += result
//        print("cnt: \(postResultArr.count)")
        for i in 0...4{
            photoImgArr.append([])
            newIndex = 5 * pageCnt - (indexList[i]) // 0,1,2,3,4,5,6,,,
            for j in 0...(postResultArr[newIndex].postPhotoUrlListObj?.urlList!.count)! - 1{
                photoImgArr[newIndex].append((postResultArr[newIndex].postPhotoUrlListObj?.urlList![j].url)!)
                
            }
        }
        
        successPost = true
        tableView.reloadData()

    }

    func failedToRequest(message: String) {
        print(message)
    }
}

extension HomeViewController {
    func storydidSuccessSignIn(result: StoryResult) {

        print("story API 가져오기 성공")
        storyResultArr = result
//        print(storyResultArr)
        successStory = true
        collectionView.reloadData()


    }

    func storyfailedToRequest(message: String) {
        print(message)
    }
}

extension HomeViewController{
    func didSuccessLikes(){
        print("좋아요 post 성공")
//        tableView.reloadData()
    }
    
    func failedToLikes(message: String){
        print(message)
    }
}
