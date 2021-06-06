//
//  ViewController.swift
//  TextureDemo
//
//  Created by CainLuo on 2021/6/6.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    @IBAction private func pushController(_ sender: Any) {
        let vc = PhotoListController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction private func pushCollectionController(_ sender: Any) {
        let vc = PhotoCollectionController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

