//
//  ViewController.swift
//  SESAC-ToDoApp
//
//  Created by Seryun Chun on 2024/02/14.
//

import UIKit

class BaseViewController: UIViewController {
    
     // MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        render()
    }
    
    func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    func render() { }
    
}

