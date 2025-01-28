//
//  CustomTabBar.swift
//  customTabbar
//
//  Created by Bayram Yeleç on 27.01.2025.
//

protocol CustomTabBarDelegate: AnyObject {
    func didSelectTabBarItem(at index: Int)
}

import UIKit
import SnapKit

class CustomTabBar: UIView {
    
    weak var delegate: CustomTabBarDelegate?

    private var selectedIndex: Int = 0
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        return view
    }()
    
    private lazy var selectedView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple.withAlphaComponent(0.3)
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    private lazy var homeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "house"), for: .normal)
        button.tintColor = .systemPurple
        button.tag = 0
        button.addTarget(self, action: #selector(createButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = createButton(imageName: "heart", tag: 1)
        return button
    }()
    
    private lazy var searchButton: UIButton = {
        let button = createButton(imageName: "magnifyingglass", tag: 2)
        return button
    }()
    
    private lazy var profileButton: UIButton = {
        let button = createButton(imageName: "person", tag: 3)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension CustomTabBar {
    
    private func setupUI(){
        addSubview(containerView)
        containerView.addSubview(stackView)
        containerView.addSubview(selectedView)
        
        [homeButton, favoriteButton, searchButton, profileButton].forEach {
            stackView.addArrangedSubview($0)
        }
        setupConstraints()
        moveSelectedView(homeButton)
    }
    
    private func setupConstraints(){
        containerView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(60)
        }
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        [homeButton, favoriteButton, searchButton, profileButton].forEach { button in
            button.snp.makeConstraints { make in
                make.height.width.equalTo(40)
            }
        }
        selectedView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.center.equalTo(homeButton)
        }
    }
    
    private func createButton(imageName: String, tag: Int) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: imageName), for: .normal)
        button.tintColor = .gray
        button.tag = tag
        button.addTarget(self, action: #selector(createButtonAction), for: .touchUpInside)
        return button
    }
    
    @objc func createButtonAction(_ sender: UIButton){
        updateSelection(sender)
        moveSelectedView(sender)
        selectedIndex = sender.tag
        delegate?.didSelectTabBarItem(at: selectedIndex)
    }
    
    private func updateSelection(_ selectedButton: UIButton){
        [homeButton, favoriteButton, searchButton, profileButton].forEach { button in
            button.tintColor = button == selectedButton ? .systemPurple : .gray
        }
    }
    
    private func moveSelectedView(_ selectedButton: UIButton){
        UIView.animate(withDuration: 0.3) {
            self.selectedView.snp.remakeConstraints { make in
                make.height.equalTo(40)
                make.width.equalTo(60)
                make.center.equalTo(selectedButton)
            }
            self.layoutIfNeeded()
        }
    }
    
}
