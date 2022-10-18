//
//  AppDelegate.swift
//  SeSACFirebaseExample
//
//  Created by 황은지 on 2022/10/05.
//

import UIKit
import FirebaseCore
import FirebaseMessaging
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let config = Realm.Configuration(schemaVersion: 3) { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 { } // DetailTodo, List 추가
            
            if oldSchemaVersion < 2 { } // EmbeddedObject 추가
            
            if oldSchemaVersion < 3 { } // DetailTodo에 deadline 추가
        }
        
        Realm.Configuration.defaultConfiguration = config
        
        //aboutRealmMigration()
        
        UIViewController.swizzleMethod()
        
        FirebaseApp.configure()
        
        // 알림 시스템에 앱 등록
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
          )
        } else {
          let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
        
        // 메세지 대리자 설정
        Messaging.messaging().delegate = self

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate {
    func aboutRealmMigration() {
        // deleteRealmIfMigrationNeeded: 마이그레이션이 필요한 경우 기존 렘 삭제
        // 주의: 이 때 Realm Browser (스튜디오) 가 열려 있으면 에러가 발생하기 떄문에, 닫고 다시 열기!
        // let config = Realm.Configuration(schemaVersion: 1, deleteRealmIfMigrationNeeded: true)
        
        let config = Realm.Configuration(schemaVersion: 6) { migration, oldSchemaVersion in
            
            // 컬럼/테이블의 단순 추가/삭제의 경우에는 별도의 코드가 필요 X
            if oldSchemaVersion < 1 { }
            
            if oldSchemaVersion < 2 { }
            
            if oldSchemaVersion < 3 { // 프로퍼티 이름 변경
                migration.renameProperty(onType: Todo.className(), from: "importance", to: "favorite")
            }
            
            if oldSchemaVersion < 4 { // userDescription 프로퍼티 추가 -> 기존 프로퍼티를 활용한 기본값 설정
                migration.enumerateObjects(ofType: Todo.className()) { oldObject, newObject in
                    guard let new = newObject else { return }
                    guard let old = oldObject else { return }
                    
                    new["userDescription"] = "안녕하세요. \(old["title"]!)의 즁요도는 \(old["favorite"]!)입니다."
                }
            }
            
            if oldSchemaVersion < 5 { // count 프로퍼티 추가 -> 기본값 100으로 설정
                migration.enumerateObjects(ofType: Todo.className()) { oldObject, newObject in
                    guard let new = newObject else { return }
                    new["count"] = 100
                }
            }
            
            if oldSchemaVersion < 6 { // favorite 프로퍼티의 타입 변경
                migration.enumerateObjects(ofType: Todo.className()) { oldObject, newObject in
                    guard let new = newObject else { return }
                    guard let old = oldObject else { return }
                    
                    new["favorite"] = old["favorite"]
                    // new와 old가 둘 다 옵셔널이거나, 둘 다 옵셔널이 아닐 경우 위의 코드 한줄로 대응 가능!
                    // 하지만 둘 중 하나만 옵셔널일 경우, nil 값에 대한 타입 변환을 따로 해주어야 한다.
                }
            }
        }
        Realm.Configuration.defaultConfiguration = config
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken
    }
    
    // 포그라운드 알림 수신: 로컬/푸시 동일
    // 카카오톡: 잭님과 채팅방, 푸시마다 설정, 화면마다 설정 등
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        // Setting 화면에 있다면 포그라운드 푸시 띄우지 마라!
        guard let viewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController else { return }
        
        if viewController is SettingViewController {
            completionHandler([])
        } else {
            // .banner, .list: iOS 14+
            completionHandler([.badge, .sound, .banner, .list])
        }
    }
    
    // 푸시 클릭: 호두과자 장바구니 담는 화면
    // 유저가 푸시를 클릭했을 때에만 수신 확인 가능
    // 특정 푸시를 클릭하면 특정 상세 화면으로 화면 전환
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("사용자가 푸시를 클릭했습니다")
        print(response.notification.request.content.body)
        print(response.notification.request.content.userInfo)
        
        let userInfo = response.notification.request.content.userInfo
        
        if userInfo[AnyHashable("sesac")] as? String == "project" {
            print("SESAC PROJECT")
        } else {
            print("NOTHING")
        }
        
        guard let viewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController else { return }
        
        print(viewController)
        
        if viewController is ViewController { // is as
            viewController.navigationController?.pushViewController(SettingViewController(), animated: true)
        } else if viewController is ProfileViewController {
            viewController.dismiss(animated: true)
        }
    }
}

extension AppDelegate: MessagingDelegate {
    
    // 토큰 갱신 모니터링: 토큰 정보가 언제 바뀔까?
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")

      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
}
