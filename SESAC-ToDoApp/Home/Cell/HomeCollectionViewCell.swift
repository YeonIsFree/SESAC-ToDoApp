//
//  TodoCollectionViewCell.swift
//  SESAC-ToDoApp
//
//  Created by Seryun Chun on 2024/02/14.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.tintColor = .white
        return imageView
    }()
    
    let titleLable: UILabel = {
        let label = UILabel()
        label.text = "예정"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = .boldSystemFont(ofSize: 32)
        return label
    }()
    
     // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     // MARK: - Cell UI Configuration Method
    
    private func render() {
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.size.equalTo(32)
        }
        
        contentView.addSubview(titleLable)
        titleLable.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(10)
            make.leading.equalTo(iconImageView).offset(5)
            make.height.equalTo(14)
        }
        
        contentView.addSubview(countLabel)
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.top)
            make.trailing.equalTo(contentView).inset(8)
            make.height.equalTo(32)
        }
    }
    
    func configureCell(_ index: Int) {
        iconImageView.image = HomeList(rawValue: index)?.image
        titleLable.text = HomeList(rawValue: index)?.title
    }
}
