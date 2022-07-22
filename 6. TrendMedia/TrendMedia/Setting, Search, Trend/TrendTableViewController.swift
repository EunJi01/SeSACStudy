//
//  TrendTableViewController.swift
//  TrendMedia
//
//  Created by 황은지 on 2022/07/21.
//

import UIKit

class TrendTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func movieButtonTapped(_ sender: UIButton) {
        
        // 화면전환 : 1. 스토리보드 파일 2. 스토리보드 내 뷰컨트롤러 3. 화면 전환
        // 영화버튼 클릭 > BuketlistTableViewController Present
        // 1.
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        // 2.
        let vc = sb.instantiateViewController(withIdentifier: BucketlistTableViewController.identifire) as! BucketlistTableViewController
        
        // 데이터 넘기기
        vc.textFieldPlaceholder = "영화를 입력해주세요"
        
        // 3.
        self.present(vc, animated: true)
        
    }
    @IBAction func dramaButtonTapped(_ sender: UIButton) {
        
        // 1.
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        // 2.
        let vc = sb.instantiateViewController(withIdentifier: BucketlistTableViewController.identifire) as! BucketlistTableViewController
        // 2.5. present시 화면 전환 방식 설정(옵션)
        vc.modalPresentationStyle = .fullScreen
        
        // 데이터 넘기기
        vc.textFieldPlaceholder = "드라마를 입력해주세요"
        
        // 3.
        self.present(vc, animated: true)
    }
    
    @IBAction func bokkButtonTapped(_ sender: UIButton) {
        
        // 1.
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        // 2.
        let vc = sb.instantiateViewController(withIdentifier: BucketlistTableViewController.identifire) as! BucketlistTableViewController
        // 2.5 네비게이션 컨트롤러 임베드
        let nav = UINavigationController(rootViewController: vc)
        // 2.5 present시 화면 전환 방식 설정(옵션)
        nav.modalPresentationStyle = .fullScreen
        
        // 데이터 넘기기
        vc.textFieldPlaceholder = "도서를 입력해주세요"
        
        // 3.
        self.present(nav, animated: true)
        
    }
}
