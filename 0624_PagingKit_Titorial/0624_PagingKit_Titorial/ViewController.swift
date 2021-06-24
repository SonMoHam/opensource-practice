//
//  ViewController.swift
//  0624_PagingKit_Titorial
//
//  Created by 손대홍 on 2021/06/24.
//

import UIKit
import PagingKit

class ViewController: UIViewController {
        var menuViewController: PagingMenuViewController!
        var contentViewController: PagingContentViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        menuViewController.register(nib: UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")
        menuViewController.registerFocusView(nib: UINib(nibName: "FocusView", bundle: nil))
        
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PagingMenuViewController {
            menuViewController = vc
        } else if let vc = segue.destination as? PagingContentViewController {
            contentViewController = vc
        }
    }

}

