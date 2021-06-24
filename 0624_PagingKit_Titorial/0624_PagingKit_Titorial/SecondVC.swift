//
//  SecondVC.swift
//  0624_PagingKit_Titorial
//
//  Created by 손대홍 on 2021/06/24.
//

import Foundation
import UIKit

class SecondVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(type(of: self)) - \(#function)")
        titleLabel.text = "\(type(of: self))"
    }
}
