//
//  Annotation.swift
//  TMDBProject
//
//  Created by 황은지 on 2022/08/11.
//

import Foundation
import MapKit

class Annotation {
    
    static let shared = Annotation()
    private init() {}
    
    func setCampusAnnotation(mapView: MKMapView) {
        let center = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
        
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 100, longitudinalMeters: 100)
        mapView.setRegion(region, animated: true)
        
        let anootation = MKPointAnnotation()
        anootation.coordinate = center
        anootation.title = "청년취업사관학교 영등포캠퍼스"
    }
}
