//
//  SocketIOManager.swift
//  SeSAC2Chat
//
//  Created by 황은지 on 2022/11/23.
//

import Foundation
import SocketIO

class SocketIOManager {
    static let shared = SocketIOManager()
    
    // 서버와 메시지를 주고 받기 위한 클래스
    var manager: SocketManager!
    var socket: SocketIOClient!
    
    private init() {
        manager = SocketManager(socketURL: URL(string: APIKey.socket)!, config: [
            .log(true),
            .extraHeaders(["auth": APIKey.header])
        ])
        
        socket = manager.defaultSocket // 세부 링크 셋팅 (현재는 디폴트) => http://api.sesac.co.kr:2022/
        
        // 연결
        socket.on(clientEvent: .connect) { data, ack in
            print("SOCKET IS CONNECTED", data, ack)
        }
        
        // 연결 해제
        socket.on(clientEvent: .disconnect) { data, ack in
            print("SOCKET IS DISCONNECTED", data, ack)
        }
        
        // 이벤트 수신
        socket.on("sesac") { dataArray, ack in
            //print("SESAC RECEIVED", dataArray, ack)
            
            let data = dataArray[0] as! NSDictionary
            let chat = data["text"] as! String
            let name = data["name"] as! String
            let userId = data["userId"] as! String
            let createdAt = data["createdAt"] as! String
            
            print("CHECK >>>", chat, name, createdAt)
            
            // 클로저, 딜리게이트, 노티피케이션 등... 데이터를 전달!
            NotificationCenter.default.post(name: Notification.Name("getMessage"), object: self, userInfo: [
                "chat": chat, "name": name, "createdAt": createdAt, "userId": userId
            ])
        }
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
}
