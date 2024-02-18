//
//  DateViewController.swift
//  SESAC-ToDoApp
//
//  Created by Seryun Chun on 2024/02/14.
//

import UIKit

class DateViewController: BaseViewController, PassDataDelegate {
    
    var changedValue: ((String) -> Void)?
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.date = .now
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
     // MARK: - Life Cycle Method

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let date = DateFormatter.convertDateToString("\(datePicker.date)")
        
        print(datePicker.date)
        
        changedValue?(date)
       
        NotificationCenter.default.post(name: DateViewController.dateDidChanged, object: nil, userInfo: ["todoDate": date])
    }
    
     // MARK: - UI Configuration Method
    
    override func render() {
        view.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
    }
}

 // MARK: - Notification

extension DateViewController {
    static let dateDidChanged = NSNotification.Name("todoDate")
}
