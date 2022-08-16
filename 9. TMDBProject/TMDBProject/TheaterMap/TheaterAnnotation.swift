//
//  TheaterAnnotation.swift
//  TMDBProject
//
//  Created by 황은지 on 2022/08/11.
//

import Foundation
import MapKit

class Annotation: MKPointAnnotation {
    
    static let shared = Annotation()
    private override init() {}
    
    enum Theater: String {
        case lottecinema = "롯데시네마"
        case megabox = "메가박스"
        case cgv = "CGV"
        case all = "전체보기"
        
//        func setTheaterAnnotation(theater: Theater) {
//            switch theater {
//            case .lottecinema:
//
//            case .megabox:
//
//            case .cgv:
//
//            case .all:
//
//            }
//        }
        
        func setTheaterAnnotation() {
            let center = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)

            let anootation = MKPointAnnotation()
            anootation.coordinate = center
            anootation.title = ""
        }
    }
    
    func setCampusAnnotation(mapView: MKMapView) {
        let center = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
        
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 100, longitudinalMeters: 100)
        mapView.setRegion(region, animated: true)
        
        let anootation = MKPointAnnotation()
        anootation.coordinate = center
        anootation.title = "청년취업사관학교 영등포캠퍼스"
    }
    
    func showAlert(title: String, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let theater = UIAlertAction(title: title, style: .default, handler: handler)
        alert.addAction(theater)
    }
}
