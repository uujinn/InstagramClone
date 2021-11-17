//
//  SceneDelegate.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/16.
//

import UIKit
import FBSDKCoreKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)

        print(UserDefaults.standard.string(forKey: "AccessToken"))
        // 자동 로그인 ID: jeeedi PW: 1234
        if UserDefaults.standard.string(forKey: "AccessToken") != nil{
            let storyboard = UIStoryboard(name: "Main",bundle: nil)
            var vc = UITabBarController()
            vc = storyboard.instantiateViewController(withIdentifier: "TabVC") as! UITabBarController
            
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }else{
            let storyboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
            var vc = UINavigationController()
            vc = storyboard.instantiateViewController(withIdentifier: "LoginNC") as! UINavigationController
            
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }


 
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }

        ApplicationDelegate.shared.application(
            UIApplication.shared,
            open: url,
            sourceApplication: nil,
            annotation: [UIApplication.OpenURLOptionsKey.annotation]
        )
    }


    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

