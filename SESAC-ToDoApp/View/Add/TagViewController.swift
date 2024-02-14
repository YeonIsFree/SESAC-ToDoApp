//
//  TagViewController.swift
//  SESAC-ToDoApp
//
//  Created by Seryun Chun on 2024/02/14.
//

import UIKit

class TagViewController: BaseViewController {
    
    var changedTag: ((String) -> Void)?
    
    let tagTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "태그를 입력하세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
     // MARK: - Life Cycle Method

    override func viewDidLoad() {
        super.viewDidLoad()
        render()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.post(name: TagViewController.tagDidChanged, object: nil, userInfo: ["todoTag": tagTextField.text!])
    }
    
     // MARK: - UI Configuration Method
    
    override func render() {
        view.addSubview(tagTextField)
        tagTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(60)
        }
    }
}

 // MARK: - Notification

extension TagViewController {
    static let tagDidChanged = Notification.Name(rawValue: "todoTag")
}
