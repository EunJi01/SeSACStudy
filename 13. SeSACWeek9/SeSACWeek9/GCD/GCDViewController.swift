//
//  GCDViewController.swift
//  SeSACWeek9
//
//  Created by 황은지 on 2022/09/02.
//

import UIKit

class GCDViewController: UIViewController {
    
    let url1 = URL(string: "https://apod.nasa.gov/apod/image/2201/OrionStarFree3_Harbison_5000.jpg")!
    let url2 = URL(string: "https://apod.nasa.gov/apod/image/2112/M3Leonard_Bartlett_3843.jpg")!
    let url3 = URL(string: "https://apod.nasa.gov/apod/image/2112/LeonardMeteor_Poole_2250.jpg")!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func serialSync(_ sender: UIButton) { // 사용 X
        // MARK: 1. DispatchQueue에 블럭을 보내놓고, 끝날때까지 대기했다가 다음 코드 진행 (자기자신에게 분배)
//        DispatchQueue.main.sync // 일반적으로 사용할 일이 없는 코드
//      // 끝날때까지 기다리는데, 자기 자신에게 분배했기 때문에 끝나지 않아서 교착상태 (무한대기) 발생 = DeadLock
        
        print("START", terminator: " ")
        
        for i in 1...100 {
            print(i, terminator: " ")
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        print("END")
        // 결과 : START -> 1...200 -> END
    }
    
    @IBAction func serialAsync(_ sender: UIButton) { // 사용예시 : 레이아웃
        // MARK: 2. DispatchQueue에 블럭을 보내놓고, 바로 아래 코드로 넘어가 순서대로 작업 (자기자신에게 분배)
        print("START", terminator: " ")
        
//        DispatchQueue.main.async {
//            for i in 1...100 {
//                print(i, terminator: " ")
//            }
//        }
        
        for i in 1...100 { // 위와 같은 결과이지만, 반복문이 순서대로 실행되기 때문에 100개의 Task가 넘어간다
            DispatchQueue.main.async {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        print("END")
        // 결과 : START -> 101...200 -> 1...100 -> END
    }
    
    @IBAction func globalSync(_ sender: UIButton) { // 사용 X
        // MARK: 3. DispatchQueue에 블럭을 보내놓고, 끝날때까지 대기했다가 다음 코드 진행 (타 스레드로 분배)
        // 어차피 보내놓은 작업이 끝날 때까지 기다리기 때문에, 코드 순서대로 진행되며 시간도 동일하게 소요된다
        // 심지어, 애플에서 다시 main에게 분배하기 때문에 전혀 의미가 없는 코드이다
        print("START", terminator: " ")
        
        DispatchQueue.global().sync {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }

        for i in 101...200 {
            print(i, terminator: " ")
        }
        print("END")
        // 결과 : START -> 1...200 -> END
    }
    
    @IBAction func globalAsync(_ sender: UIButton) {
        // MARK: 4. DispatchQueue에 블럭을 보내놓고, 바로 아래 코드로 넘어가 순서대로 작업 (타 스레드로 분배)
        print("START \(Thread.isMainThread)", terminator: " ") // true
        
//        DispatchQueue.global().async {
//            for i in 1...100 {
//                print(i, terminator: " ")
//            }
//        }
        
        for i in 1...100 { // 위와 같은 결과이지만, 반복문이 순서대로 실행되기 때문에 100개의 Task가 넘어간다
            DispatchQueue.global().async {
                print(i, terminator: " ")
            }
        }

        for i in 101...200 {
            print(i, terminator: " ")
        }
        print("END \(Thread.isMainThread)") // true
        // 결과 : START -> 뒤죽박죽...
    }
    
    @IBAction func qos(_ sender: UIButton) { // MARK: 중요한 작업이라면 qos를 통해 작업의 우선순위 설정
        let customQueue = DispatchQueue(label: "concurrentSeSAC", qos: .userInteractive, attributes: .concurrent)
        // customQueue를 만들어 label을 명시할 수 있다 -> 코드를 읽지 않고도 우선순위를 알 수 있음
        
        customQueue.async {
            print("START")
        }
        
        DispatchQueue.global(qos: .background).async { // background -> 가장 낮은 순위
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }

        DispatchQueue.global(qos: .userInteractive).async { // userInteractive -> 가장 높은 순위
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }

        DispatchQueue.global(qos: .utility).async {
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
        // 결과 : 101...200 -> 201...300 -> 1...100
        
//        for i in 1...100 {
//            DispatchQueue.global(qos: .background).async {
//                print(i, terminator: " ")
//            }
//        }
//
//        for i in 101...200 {
//            DispatchQueue.global(qos: .userInteractive).async {
//                print(i, terminator: " ")
//            }
//        }
//
//        for i in 201...300 {
//            DispatchQueue.global(qos: .utility).async {
//                print(i, terminator: " ")
//            }
//        }
        // 결과 : 뒤죽박죽...
    }
    
    @IBAction func dispatchGroup(_ sender: UIButton) {
        let group = DispatchGroup()
        // MARK: 그룹으로 묶어서 해당 그룹 내의 모든 작업이 끝나는 신호를 받을 수 있음
        
        DispatchQueue.global().async(group: group) {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
        
        group.notify(queue: .main) { // execute 클로저 내부에 넣으면 그룹이 다 끝난 후 실행
            print("END") // tableView.reload
        }
    }
    
    func request(url: URL, completionHandler: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completionHandler(UIImage(systemName: "star"))
                return
            }

            let image = UIImage(data: data)
            completionHandler(image)
                                      
        }.resume()
    }
    
    @IBAction func dispatchGroupNASA(_ sender: UIButton) {
        // MARK: group을 이용해, 여러 스레드에서 네트워크 통신하고 한번에 뷰 갱신하기 (실패)
//        request(url: url1) { image in
//            print("1")
//            self.request(url: self.url2) { image in
//                print("2")
//                self.request(url: self.url3) { image in
//                    print("3")
//                    print("끝, 갱신!")
//                }
//            }
//        } // 1. 순서대로 실행되지만 코드가 복잡하고 시간이 오래 걸린다
        
        let group = DispatchGroup()
        // 2. 내부에 있는 request 가 비동기 함수이기 때문에, 의도한 순서대로 실행되지 않는다 -> enter/leave를 통한 구현 필요
        
        DispatchQueue.global().async(group: group) {
            self.request(url: self.url1) { image in
                print("1")
            } // 이 클로저 입장에서는, 다른 스레드에 일을 넘겼기 때문에 본인 일은 끝났다고 판단한다
        }
        
        DispatchQueue.global().async(group: group) {
            self.request(url: self.url2) { image in
                print("2")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            self.request(url: self.url3) { image in
                print("3")
            }
        }
        
        group.notify(queue: .main) {
            print("끝, 완료!")
        }
    }
    
    @IBAction func enterLeave(_ sender: UIButton) {
        // MARK: group과 enter/leave를 이용해, 여러 스레드에서 네트워크 통신하고 한번에 뷰 갱신하기 (성공!)
        let group = DispatchGroup()
        var imageList: [UIImage] = []
        
        group.enter() // 시작할게!
        request(url: url1) { image in
            print("1")
            imageList.append(image!)
            group.leave() // 나 끝났어!
        }
        
        group.enter()
        request(url: url2) { image in
            print("2")
            imageList.append(image!)
            group.leave()
        }
        
        group.enter()
        request(url: url3) { image in
            print("3")
            imageList.append(image!)
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.image1.image = imageList[0]
            self.image2.image = imageList[1]
            self.image3.image = imageList[2]
            print("끝, 완료!")
        }
    }
    
    @IBAction func raceCondition(_ sender: UIButton) {
        // 하나의 변수를 여러 스레드가 변경할 경우, notify에 출력되는 결과는?
        
        let group = DispatchGroup()
        var nickname = "SeSAC" // 공유자원
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "고래밥"
            print("first: \(nickname)")
        }
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "칙촉"
            print("second: \(nickname)")
        }
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "올라프"
            print("third: \(nickname)")
        }
        
        group.notify(queue: .main) {
            print("result: \(nickname)") // ??? 랜덤
        }
    }
}
