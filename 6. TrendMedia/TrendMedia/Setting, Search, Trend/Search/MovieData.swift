//
//  MovieData.swift
//  TrendMedia
//
//  Created by 황은지 on 2022/07/19.
//

import Foundation

enum Movie: Int, CaseIterable {
    case harryPotter1
    case harryPotter2
    case harryPotter3
    
    var title: String {
        switch self {
        case .harryPotter1: return "해리 포터와 마법사의 돌"
        case .harryPotter2: return "해리 포터와 비밀의 방"
        case .harryPotter3: return "해리 포터와 아즈카반의 죄수"
        }
    }
    
    var date: String {
        switch self {
        case .harryPotter1: return "2001년 11월 14일"
        case .harryPotter2: return "2002년 11월 15일"
        case .harryPotter3: return "2004년 5월 31일"
        }
    }
    
    var plot: String {
        switch self {
        case .harryPotter1:
            return "1981년 11월 1일, 프리빗가 4번지의 평범한 것을 극히 중요하게 여기는 버넌 더즐리는 아내 피튜니아 더즐리와 어린 아들 더들리 더즐리의 배웅을 받으며 직장인 그러닝스로 일하러 나가는데, 그의 주변에는 망토를 두른 사람들이 돌아다니거나 포터 부부와 그들의 아들 해리에 대한 대화가 오간다거나 부엉이들이 그의 집 주위에서 날아다니는 등 이상한 일들이 일어난다."
        case .harryPotter2:
            return "여름 방학 시즌이 되어 프리빗가 4번지로 돌아오게 된 해리 포터는 방학 기간 동안 버넌한테 모든 마법 도구들을 압수당하고 헤드위그도 밖에 못 내보내는데다 친구들 어느 누구에게도 연락 한 통 받지 못하며 심지어는 생일 축하도 못 받는 우울한 여름을 보내고 있었다. 해리의 생일날, 집요정 도비가 나타나 위험이 도사리고 있으니 호그와트로 돌아가선 안 된다고 경고한다."
        case .harryPotter3:
            return "해리가 휑했던 작년과는 다르게 저녁 친구들이 보내온 생일 축하 메세지와 선물을 받는 장면으로 시작한다. 위즐리 가족은 복권에 당첨되어 이집트 여행을, 헤르미온느는 부모님과 함께 프랑스 여행을 가 있었다. 그리고 호그와트로부터는 \"호그스미드 방문을 위해 보호자의 사인(허락)을 받아오라\"는 통지서를 받는다."
        }
    }
}
