//
//  UploadPanModalViewController.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/24.
//

import UIKit
import PanModal
import YPImagePicker
import FirebaseStorage

class UploadPanModalViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let arr = ["게시물","스토리","스토리 하이라이트","릴스", "라이브 방송"]
    let imgarr = ["square.grid.3x3", "timelapse", "heart", "play.tv", "dot.radiowaves.left.and.right"]
    
    let storage = Storage.storage()
    
    var imgArr = [UIImage]()
    var urlArr = [String]()
    
    lazy var photoUrl: String = ""
    
    private var picker: YPImagePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorInset.right = 0
        tableView.separatorInset.left = 65

        imgArr = []
        urlArr = []
        print("viewDidLoad")
        initUploadModule()
    }
    
}

extension UploadPanModalViewController: UITableViewDelegate, UITableViewDataSource, PanModalPresentable{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UploadModalCell") as! UploadModalCell
        
        cell.contentLabel.text = arr[indexPath.row]
        cell.iconImg.image = UIImage(systemName: "\(imgarr[indexPath.row])")
        
        return cell
    }
    
    func initUploadModule() {

        var config = YPImagePickerConfiguration()
        config.library.mediaType = .photo
        config.usesFrontCamera = true
        config.showsPhotoFilters = true
        config.showsCrop = .rectangle(ratio: 1)
        config.shouldSaveNewPicturesToAlbum = false
        config.albumName = ""
        config.screens = [.library, .photo]
        config.startOnScreen = .library
        config.wordings.libraryTitle = "library"
        config.hidesStatusBar = false
        config.library.maxNumberOfItems = 10
        config.library.numberOfItemsInRow = 3
        config.library.spacingBetweenItems = 2
        config.isScrollToChangeModesEnabled = false
        config.library.onlySquare = true
        // Build a picker with your configuration
        picker = YPImagePicker(configuration: config)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
  
        print(indexPath.row)

        if indexPath.row == 0{
            print("게시물 올리기")
            picker?.navigationController?.navigationBar.backgroundColor = .white
            picker?.navigationBar.backgroundColor = .white
//            UINavigationBar.appearance().setBackgroundImage(coloredImage, for: .default)
            picker?.didFinishPicking { [self, weak picker] items, cancelled in
//                let coloredImage = UIImage(ciImage: .white)
//                UINavigationBar.appearance().setBackgroundImage(coloredImage, for: UIBarMetrics.default)
                
                if cancelled {
                    print("Picker was canceled")
                    picker?.dismiss(animated: true, completion: nil)
                }
                else{
                    for item in items{
                        switch item {
                        case .photo(let photo):
    //                        print(photo)
                            print("1: photo")
                            uploadToFirebase(photo: photo.image)
                        case .video(let video):
                            print(video)
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(5)){
                        picker?.dismiss(animated: true, completion: nil)
                        print("1: dismiss")
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UploadVC") as! UploadViewController
                        vc.modalPresentationStyle = .fullScreen
                        vc.photoUrlArr = urlArr
                        self.present(vc, animated: true, completion: nil)
                    }
                }
            }
            self.modalPresentationStyle = .fullScreen
            present(picker!, animated: true, completion: nil)
            
            
        }
        
        
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    var panScrollable: UIScrollView? {
        nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(450)
    }

    var longFormHeight: PanModalHeight {
        return .contentHeight(450)
    }
    
    
    private func uploadToFirebase(photo: UIImage? = nil) {
        DispatchQueue.global().sync{
            guard let mainPhoto = photo!.jpegData(compressionQuality: 0.3) else { return }
            let filename = NSUUID().uuidString
            let ref = storage.reference(withPath: "/image/\(filename)")

            ref.putData(mainPhoto, metadata: nil) { (metaData, error) in
                if let error = error {
                    print(error.localizedDescription)
                }

                ref.downloadURL { [self] (url, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    }

                    guard let photoUrl = url?.absoluteString else { return }
                    self.photoUrl = photoUrl
                    print(photoUrl)
                    urlArr.append(photoUrl)
                    print(urlArr)
                }
            }
        }
    }
}



