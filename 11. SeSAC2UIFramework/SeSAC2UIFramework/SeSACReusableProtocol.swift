//
//  SeSACReusableProtocol.swift
//  SeSAC2UIFramework
//
//  Created by 황은지 on 2022/08/16.
//

import UIKit

//Reusable
public protocol ReusableViewProtocol {
    static var reuseIdentifier: String { get }
}

extension UIViewController: ReusableViewProtocol {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableViewProtocol {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}
extension UITableViewCell: ReusableViewProtocol {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}
