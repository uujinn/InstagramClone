//
//  UpperTabViewController.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/24.
//

import UIKit
import Tabman
import Pageboy

class UpperTabViewController: TabmanViewController {

    private var viewControllers: Array<UIViewController> = []
    var userIdx = 0
    var follower = 0
    var following = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = UIStoryboard.init(name: "MyPageStoryboard", bundle:nil).instantiateViewController(withIdentifier: "FollowerVC") as! FollowerViewController
        let vc2 = UIStoryboard.init(name: "MyPageStoryboard", bundle:nil).instantiateViewController(withIdentifier: "FollowingVC") as! FollowingViewController
        vc1.userIdx = userIdx
        vc2.userIdx = userIdx
        viewControllers.append(vc1)
        viewControllers.append(vc2)
        
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        let systembar = bar.systemBar()
        systembar.backgroundStyle = .clear
        bar.layout.transitionStyle = .snap
        bar.buttons.customize { (button) in
            button.tintColor = .gray
            button.selectedTintColor = .black
        }
        bar.indicator.weight = .light
        bar.indicator.tintColor = .black
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
        bar.layout.contentMode = .fit
        bar.backgroundColor = .white
        addBar(systembar, dataSource: self, at: .top)

    }
    

}

extension UpperTabViewController: PageboyViewControllerDataSource, TMBarDataSource{
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let item = TMBarItem(title: "")
        switch index{
        case 0:
            item.title = "\(follower)  팔로워"
        case 1:
            item.title = "\(following)  팔로잉"
        default:
            item.title = "page \(index)"
        }
        
        return item
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
}
