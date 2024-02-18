//
//  ListTableViewCell.swift
//  SESAC-ToDoApp
//
//  Created by Seryun Chun on 2024/02/15.
//

import UIKit

class AllListTableViewCell: UITableViewCell {
    
    let repository = TodoTableRepository()
    
    var todo: TodoTable?
    
     // MARK: - UI Properties
    
    let checkButton: UIButton = {
       let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    let memoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    let tagLabel: UILabel = {
        let label = UILabel()
        label.text = "#테스트, #테스트"
        label.textColor = .systemBlue
        return label
    }()
    
    lazy var dateTagStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateLabel, tagLabel])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var cellStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, memoLabel, dateTagStackView])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    let priorityLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        render()
        
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     // MARK: - UI Configuration Methods
    
    func configureTodoCell(_ todo: TodoTable) {
        titleLabel.text = todo.todoTitle
        memoLabel.text = todo.todoMemo
        dateLabel.text = todo.date
        priorityLabel.text = todo.priority
    }
    
     // MARK: - 버튼 왜 에러나지ㅠㅠㅠㅠㅠㅠㅜㅜㅜㅜㅜㅜㅜㅜ
    @objc
    private func checkButtonTapped(sender: UIButton) {
        print("눌림")
        if let todo {
            repository.updateTodoStatus(todo)
           
        }
    }
    
    private func render() {
        contentView.addSubview(checkButton)
        checkButton.snp.makeConstraints { make in
            make.size.equalTo(25)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        
        contentView.addSubview(cellStackView)
        cellStackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(checkButton.snp.trailing).offset(20)
        }
        
        contentView.addSubview(priorityLabel)
        priorityLabel.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(cellStackView.snp.trailing)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(20)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        checkButton.clipsToBounds = true
        checkButton.layer.cornerRadius = checkButton.bounds.width / 2
    }
}
