//
//  MainTabBarController.swift
//  customTabbar
//
//  Created by Bayram Yeleç on 27.01.2025.
//

import UIKit
import SnapKit

class MainTabBarController: UIViewController, CustomTabBarDelegate {
    
    private let VC1 = UINavigationController(rootViewController: vc1())
    private let VC2 = UINavigationController(rootViewController: vc2())
    private let VC3 = UINavigationController(rootViewController: vc3())
    private let VC4 = UINavigationController(rootViewController: vc4())
    
    private var currentVC: UIViewController?
    
    private let customTabbar = CustomTabBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(customTabbar)
        customTabbar.delegate = self
        customTabbar.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
            make.height.equalTo(60)
        }
        showVC(vc: VC1)
    }
    
    func didSelectTabBarItem(at index: Int) {
        switch index {
        case 0: showVC(vc: VC1)
        case 1: showVC(vc: VC2)
        case 2: showVC(vc: VC3)
        case 3: showVC(vc: VC4)
        default:
            break
        }
    }
    
    private func showVC(vc: UIViewController) {
        currentVC?.view.removeFromSuperview()
        currentVC?.removeFromParent()
        
        addChild(vc)
        view.insertSubview(vc.view, belowSubview: customTabbar)
        vc.view.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        vc.didMove(toParent: self)
        currentVC = vc
    }
    
}
