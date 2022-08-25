//
//  FileManager+Extension.swift
//  SeSACWeek7Diary
//
//  Created by 황은지 on 2022/08/24.
//

import UIKit

extension UIViewController {
    func documentDirectoryPath() -> URL? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil } // Document 경로
        return documentDirectory
    }
    
    func loadImageFormDocument(fileName: String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil } // Document 경로
        let fileURL = documentDirectory.appendingPathComponent(fileName) // 세부 경로 - 이미지를 저장할 위치
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        } else {
            return UIImage(systemName: "star.fill")
        }
    }
    
    func removeImageFromDocument(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return } // Document 경로
        let fileURL = documentDirectory.appendingPathComponent(fileName) // 세부 경로 - 이미지를 저장할 위치
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
    }
    
    func saveImageToDocument(fileName: String, image: UIImage) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return } // Document 경로
        let fileURL = documentDirectory.appendingPathComponent(fileName) // 세부 경로 - 이미지를 저장할 위치
        guard let data = image.jpegData(compressionQuality: 0.5) else { return } // 압축 - 용량 줄이기
        
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("file save error", error)
        }
    }
    
    func fetchDocumentZipFile() {
        do {
            guard let path = documentDirectoryPath() else { return }
            
            let docs = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
            print("docs: \(docs)")
            
            let zip = docs.filter { $0.pathExtension == "zip" } // 확장자가 zip인 파일 가져오기
            print("zip: \(zip)")
            
            let result = zip.map { $0.lastPathComponent }
            print("result: \(result)")
            
        } catch {
            print("Error")
        }
    }
}
