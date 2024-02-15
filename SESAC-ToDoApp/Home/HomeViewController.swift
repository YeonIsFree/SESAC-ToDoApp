//
//  HomeViewController.swift
//  SESAC-ToDoApp
//
//  Created by Seryun Chun on 2024/02/14.
//

import UIKit
import SnapKit

enum HomeList: Int, CaseIterable {
    case today
    case todo
    case all
    case flag
    case done
    
    var title: String {
        switch self {
        case .today:
            return "오늘"
        case .todo:
            return "예정"
        case .all:
            return "전체"
        case .flag:
            return "깃발 표시"
        case .done:
            return "완료됨"
        }
    }
    
    var image: UIImage {
        switch self {
        case .today:
            return UIImage(systemName: "calendar.circle.fill")!
        case .todo:
            return UIImage(systemName: "calendar.circle")!
        case .all:
            return UIImage(systemName: "tray.circle.fill")!
        case .flag:
            return UIImage(systemName: "flag.circle")!
        case .done:
            return UIImage(systemName: "checkmark.circle.fill")!
        }
    }
}

class HomeViewController: BaseViewController {
    
    lazy var todoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureFlowLayout())
        return collectionView
    }()
    
    let toolBar = UIToolbar()
    
     // MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureToolBar()
        configureCollectionView()
    }
    
     // MARK: - UI Configuration Methods
    
    override func render() {
        view.addSubview(todoCollectionView)
        todoCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(toolBar)
        toolBar.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "전체"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
        
        let rightNavItem = UIBarButtonItem()
        rightNavItem.image = UIImage(systemName: "ellipsis.circle")
        navigationItem.rightBarButtonItem = rightNavItem
    }
    
    private func configureFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth = UIScreen.main.bounds.width
        let spacing: CGFloat = 13
        let cellWidth = (deviceWidth - spacing * 3 ) / 2
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth * 0.5)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .vertical
        return layout
    }
    
    private func configureCollectionView() {
        todoCollectionView.delegate = self
        todoCollectionView.dataSource = self
        todoCollectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
    }
    
    private func configureToolBar() {
        let leftBarButtonItem = UIBarButtonItem()
        let leftBarButtonImage = UIImage(systemName: "plus.circle.fill")
        leftBarButtonItem.image = leftBarButtonImage
        leftBarButtonItem.action = #selector(addButtonTapped)
        
        let space = UIBarButtonItem.flexibleSpace()
        
        let rightBarButtonItem = UIBarButtonItem()
        rightBarButtonItem.title = "목록 추가"
        
        toolBar.items = [leftBarButtonItem, space, rightBarButtonItem]
        toolBar.tintColor = .white
    }
    
    @objc func addButtonTapped() {
        let nav = UINavigationController(rootViewController: AddTodoViewController())
        present(nav, animated: true)
    }
}

 // MARK: - UICollectionView Delegate

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HomeList.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .darkGray
        cell.layer.cornerRadius = 10
        
        cell.configureCell(indexPath.item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // "전체" 셀을 누를 경우 화면 전환
        if indexPath.item == HomeList.all.rawValue {
            let vc = AllListViewController()
            vc.navigationItem.title = HomeList(rawValue: indexPath.item)?.title
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
