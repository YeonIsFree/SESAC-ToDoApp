//
//  SubTableViewCell.swift
//  SESAC-ToDoApp
//
//  Created by Seryun Chun on 2024/02/14.
//

import UIKit

class SubTableViewCell: UITableViewCell {
    
    let cellTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    let cellSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "라랄랄"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()

     // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     // MARK: - Cell Configuration Method
    
    func configureCell(_ index: Int) {
        cellTitleLabel.text = TableViewSection(rawValue: index)?.title
    }
    
    private func render() {
        contentView.addSubview(cellTitleLabel)
        cellTitleLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView)
            make.leading.equalTo(contentView).inset(10)
            make.width.equalTo(120)
        }
        
        contentView.addSubview(cellSubTitleLabel)
        cellSubTitleLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView)
//            make.leading.equalTo(cellTitleLabel.snp.trailing)
            make.trailing.equalTo(contentView).inset(10)
        }
    }
    
}
