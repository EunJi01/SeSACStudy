//
//  ViewController.swift
//  SeSACFirebaseExample
//
//  Created by 황은지 on 2022/10/05.
//

import UIKit
import FirebaseAnalytics

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        Analytics.logEvent("testEvent", parameters: [
//          "name": "고래밥",
//          "full_text": "안녕하세요",
//        ])
//
//        Analytics.setDefaultEventParameters([
//          "level_name": "Caverns01",
//          "level_difficulty": 4
//        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewController viewWillAppear")
    }
    
    @IBAction func profileButtonTapped(_ sender: UIButton) {
        present(ProfileViewController(), animated: true)
    }
    
    @IBAction func settingButtonTapped(_ sender: UIButton) {
        navigationController?.pushViewController(SettingViewController(), animated: true)
    }
}

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ProfileViewController viewWillAppear")
    }
}

class SettingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("SettingViewController viewWillAppear")
    }
}

extension UIViewController {
    
    // 연산 프로퍼티를 활용해 더 간단하게 사용할 수 있음 (선택사항)
    var topViewController: UIViewController? {
        return self.topViewController(currentViewController: self)
    }
    
    // 최상위 뷰컨트롤러를 판단해주는 메서드
    func topViewController(currentViewController: UIViewController) -> UIViewController {
        if let tabBarController = currentViewController as? UITabBarController, let selectedViewController = tabBarController.selectedViewController {
            return self.topViewController(currentViewController: selectedViewController)
        } else if let navigationController = currentViewController as? UINavigationController, let visibleViewController = navigationController.visibleViewController {
            return self.topViewController(currentViewController: visibleViewController)
        } else if let presentedViewController = currentViewController.presentedViewController {
            return self.topViewController(currentViewController: presentedViewController)
        } else {
            return currentViewController
        }
    }
}


extension UIViewController {
    
    // AppDelegate에서 호출해, 모든 VC의 viewWillAppear를 변경
    // 타입 메서드 --> static도 사용 가능하며, class는 오버라이딩이 가능하다.
    class func swizzleMethod() {
        let origin = #selector(viewWillAppear)
        let change = #selector(changeViewWillAppear)
        
        guard let originMethod = class_getInstanceMethod(UIViewController.self, origin), let changeMethod = class_getInstanceMethod(UIViewController.self, change) else {
            print("함수를 찾을 수 없거나 오류 발생")
            return
        }
        
        method_exchangeImplementations(originMethod, changeMethod)
    }
    
    @objc func changeViewWillAppear() {
        print("Change ViewWillAppear SUCCEED")
    }
}
