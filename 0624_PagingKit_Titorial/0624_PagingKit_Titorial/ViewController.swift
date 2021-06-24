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
    
    static var viewController: (UIColor) -> UIViewController = { (color) in
        let vc = UIViewController()
        vc.view.backgroundColor = color
        return vc
    }
    
    //    var dataSource = [
    //        (menuTitle: "test1", vc: viewController(.red)),
    //        (menuTitle: "test2", vc: viewController(.blue)),
    //        (menuTitle: "test3", vc: viewController(.yellow))
    //    ]
    var dataSource = [(menu: String, content: UIViewController)]() {
        didSet{
            menuViewController.reloadData()
            contentViewController.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        menuViewController.register(nib: UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")
        menuViewController.registerFocusView(nib: UINib(nibName: "FocusView", bundle: nil))
        
        menuViewController.cellAlignment = .center
        
        menuViewController.reloadData()
        contentViewController.reloadData()
        
        dataSource = makeDataSource()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PagingMenuViewController {
            menuViewController = vc
            menuViewController.dataSource = self // <- set menu data source
            menuViewController.delegate = self // <- set menu delegate
        } else if let vc = segue.destination as? PagingContentViewController {
            contentViewController = vc
            contentViewController.dataSource = self // <- set content data source
            contentViewController.delegate = self // <- set content delegate
        }
    }
    
    fileprivate func makeDataSource() -> [(menu: String, content: UIViewController)] {
        let myMenuArray = ["first", "second", "third"]
        
        return myMenuArray.map {
            let title = $0
            switch title {
            case "first":
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "FirstVC") as! FirstVC
                return (menu:title, content: vc)
            case "second":
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SecondVC") as! SecondVC
                return (menu:title, content: vc)
            case "third":
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ThirdVC") as! ThirdVC
                return (menu:title, content: vc)
            default:
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "FirstVC") as! FirstVC
                return (menu:title, content: vc)
            }
        }
    }
    
}

// 메뉴 데이터 소스
extension ViewController: PagingMenuViewControllerDataSource {
    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        return dataSource.count
    }
    
    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        return 100
    }
    
    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: index) as! MenuCell
        cell.titleLabel.text = dataSource[index].menu
        return cell
    }
}

// 메뉴 컨트롤 델리겟
extension ViewController: PagingMenuViewControllerDelegate {
    func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {
        contentViewController.scroll(to: page, animated: true)
    }
}

// 컨텐츠 데이터 소스
extension ViewController: PagingContentViewControllerDataSource {
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        return dataSource.count
    }
    
    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        return dataSource[index].content
    }
}

// 컨텐츠 컨트롤 델리겟
extension ViewController: PagingContentViewControllerDelegate {
    func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
        // 내용 스크롤 할 때, 메뉴도 함께 스크롤
        menuViewController.scroll(index: index, percent: percent, animated: false)
    }
}
