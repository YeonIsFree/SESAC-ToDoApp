//
//  PriorityViewController.swift
//  SESAC-ToDoApp
//
//  Created by Seryun Chun on 2024/02/14.
//

import UIKit

class PriorityViewController: BaseViewController, PassDataDelegate {
    
    var changedValue: ((String) -> Void)?
    
    lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["덜 중요", "중요", "매우 중요"])
        control.addTarget(self, action: #selector(segConTapped), for: .valueChanged)
        return control
    }()
    
     // MARK: - Life Cycle Method

    override func viewDidLoad() {
        super.viewDidLoad()
        render()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 클로저로 이전 화면에 값 전달
        let idx = segmentedControl.selectedSegmentIndex
        if let priority = segmentedControl.titleForSegment(at: idx) {
            changedValue?(priority)
            
            // 값이 변경되었다고 Noti
            NotificationCenter.default.post(name: PriorityViewController.priorityDidChanged, object: nil, userInfo: ["todoPriority": priority])
        }
    }
    
     // MARK: - UI Configuration Method
    
    @objc func segConTapped() {
        navigationController?.popViewController(animated: true)
    }
 
    override func render() {
        view.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(100)
        }
    }
}

 // MARK: - Notification

extension PriorityViewController {
    static let priorityDidChanged = NSNotification.Name("todoPriority")
}
