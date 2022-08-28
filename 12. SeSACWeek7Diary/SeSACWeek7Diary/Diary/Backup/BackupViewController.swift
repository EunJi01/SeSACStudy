//
//  BackupViewController.swift
//  SeSACWeek7Diary
//
//  Created by 황은지 on 2022/08/24.
//

import UIKit
import Zip
import SeSAC2UIFramework

class BackupViewController: BaseViewController {
    
    let mainView = BackupView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        //            // 지금으로부터 2초 뒤에 실행되는 코드
        //        }
    }
    
    override func configure() {
        mainView.backupTableView.delegate = self
        mainView.backupTableView.dataSource = self
        mainView.backupButton.addTarget(self, action: #selector(backupButtonTapped), for: .touchUpInside)
        mainView.restoreButton.addTarget(self, action: #selector(restoreButtonTapped), for: .touchUpInside)
    }
    
    @objc func backupButtonTapped() {
        var urlPaths = [URL]()
        
        // 백업1. 도큐먼트 위치에 백업 파일 확인
        guard let path = documentDirectoryPath() else { // 1-1. 백업 위치를 URL 형태로 받아오기 /~~/~~/~~/Document/
            showAlertMessage(title: "도큐먼트 위치에 오류가 있습니다")
            return
        }
        
        let realmFile = path.appendingPathComponent("default.realm") // 1-2. 경로 추가 /~~/~~/~~/Document/defualt.realm
        
        guard FileManager.default.fileExists(atPath: realmFile.path) else { // 1-3. 해당 경로가 유효한 경로인지 확인
            showAlertMessage(title: "백업할 파일이 없습니다")
            return
        }
        
        urlPaths.append(URL(string: realmFile.path)!) // 1-4. 빈 배열 (urlPaths) 에 경로 담기
        
        // 백업2. 백업 파일을 압축: URL
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "SeSACDiary_1")
            print("Archive Location: \(zipFilePath)")
            showActivityViewController()
        } catch {
            showAlertMessage(title: "압축을 실패했습니다")
        }
    }
    
    // 백업3. ActivityViewController
    func showActivityViewController() {
        // 도큐먼트 위치에 백업 파일 확인
        guard let path = documentDirectoryPath() else { // 3-1. 백업 위치를 URL 형태로 받아오기
            showAlertMessage(title: "도큐먼트 위치에 오류가 있습니다")
            return
        }
        
        let backupFileURL = path.appendingPathComponent("SeSACDiary_1.zip") // 3-2. 경로 추가
        
        let vc = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: [])
        self.present(vc, animated: true) // 설정한 경로로 UIActivityViewController 띄우기
    }
    
    @objc func restoreButtonTapped() {
        // 복원1. 파일 앱을 활용한 복구 - documentPicker present
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false // 복수 선택 방지
        self.present(documentPicker, animated: true)
    }
}

// 복원2. 파일 앱을 활용한 복구 - 실질적인 기능을 하는 코드
extension BackupViewController: UIDocumentPickerDelegate {
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else { // 현재 배열에 요소가 한개이기 때문에 언제나 첫번째 요소를 가져오기
            showAlertMessage(title: "선택하신 파일에 오류가 있습니다")
            return
        }
        
        guard let path = documentDirectoryPath() else {
            showAlertMessage(title: "도큐먼트 위치에 오류가 있습니다")
            return
        }
        
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent) // 마지막 경로만 가져오기
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) { // 경로에 복구할 파일이 이미 있는지 확인
            
            let fileURL = path.appendingPathComponent("SeSACDiary_1.zip")
            
            do { // fileURL에 있는 파일을 path에 압축 해제할 건데, 덮어 씌울거고 패스워드는 없음
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)") // 현재 진행 상황 (로딩) 알려줌
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)") // 복구가 완료된 다음 실행되는 클로저
                })
            } catch {
                showAlertMessage(title: "압축 해제에 실패했습니다")
            }
            
        } else { // 경로에 파일이 없다면?
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL) // 파일 앱의 zip -> 도큐먼트 폴더에 복사
                
                let fileURL = path.appendingPathComponent("SeSACDiary_1.zip")
                
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)") // 현재 진행 상황 (로딩) 알려줌
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)") // 복구가 완료된 다음 실행되는 클로저
                    self.showAlertMessage(title: "복구가 완료되었습니다")
                })
            } catch {
                showAlertMessage(title: "압축 해제에 실패했습니다")
            }
        }
    }
}

extension BackupViewController: UITableViewDelegate, UITableViewDataSource {
    func zipList() -> [String] {
        var zipList: [String] = []
        do {
            guard let path = documentDirectoryPath() else { return zipList }
            let docs = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
            let zip = docs.filter { $0.pathExtension == "zip" }
            zip.forEach {
                zipList.append($0.lastPathComponent)
            }
        } catch {
            print("Error")
        }
        return zipList
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return zipList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BackupTableViewCell.reuseIdentifier) as? BackupTableViewCell else { return UITableViewCell() }
        
        cell.fileNameLabel.text = zipList()[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showAlertRestore { _ in
            guard let path = self.documentDirectoryPath() else { return }
            let fileURL = path.appendingPathComponent(self.zipList()[indexPath.row])
            
            do { // fileURL에 있는 파일을 path에 압축 해제할 건데, 덮어 씌울거고 패스워드는 없음
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)") // 현재 진행 상황 (로딩) 알려줌
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)") // 복구가 완료된 다음 실행되는 클로저
                })
            } catch {
                self.showAlertMessage(title: "압축 해제에 실패했습니다")
            }
        }
    }
    
    func showAlertRestore(completionHandler: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: "선택한 파일로 복구하시겠습니까?", message: "*주의* 기존 데이터는 사라집니다", preferredStyle: .alert)
        let ok = UIAlertAction(title: "결정", style: .default, handler: completionHandler)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
}
