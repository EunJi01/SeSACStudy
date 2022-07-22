//
//  SceneDelegate.swift
//  TrendMedia
//
//  Created by 황은지 on 2022/07/18.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        //UserDefaults.standard.set(true , forKey: "First") // true이면 FirstSceneViewController를 띄우고, flase이면 SearchMovieTableViewController
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        if UserDefaults.standard.bool(forKey: "First") {
            
            let sb = UIStoryboard(name: "Trend", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: "FirstSceneViewController") as? FirstSceneViewController else {
                return
            }
            
            // 루트 뷰 컨트러로 vc를 채택(Info보다 나중에 실행되기 때문에 우선됨)
            window?.rootViewController = vc
            
        } else {
            
            let sb = UIStoryboard(name: "Setting", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: "SearchMovieTableViewController") as? SearchMovieTableViewController else {
                return
            }
            
            // 루트 뷰 컨트러로 vc를 채택(Info보다 나중에 실행되기 때문에 우선됨)
            //window?.rootViewController = vc
            
            // 네비게이션 뷰 컨트롤러를 띄우는 법 (탭바는 어려워서 나중에^^;)
            window?.rootViewController = UINavigationController(rootViewController: vc)
            
        }
        
        // 실제로 windeo에 vc를 보여주는 코드
        window?.makeKeyAndVisible()
        
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

