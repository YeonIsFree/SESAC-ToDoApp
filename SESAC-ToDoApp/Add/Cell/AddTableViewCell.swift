//
//  AddTableViewCell.swift
//  SESAC-ToDoApp
//
//  Created by Seryun Chun on 2024/02/14.
//

import UIKit

class AddTableViewCell: UITableViewCell {
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "제목"
        return textField
    }()
    
    let memoTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "메모"
        return textField
    }()

     // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     // MARK: - UI Configuration Method
    
    private func render() {
        contentView.addSubview(titleTextField)
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.horizontalEdges.equalTo(contentView).inset(10)
            make.height.equalTo(40)
        }
        
        contentView.addSubview(memoTextField)
        memoTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom)
            make.horizontalEdges.equalTo(contentView).inset(10)
            make.bottom.equalTo(contentView)
        }
    }
}
