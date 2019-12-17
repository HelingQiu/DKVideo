//
//  LaunchViewController.swift
//  DKVideo
//
//  Created by 朱德坤 on 2019/12/6.
//  Copyright © 2019 DKJone. All rights reserved.
//

import WebKit
import RxSwift
class LaunchViewController: ViewController {
    override func makeUI() {
        view.backgroundColor = .black
        let barView = UIView()
        barView.backgroundColor = .black
        let webview = WKWebView()
        webview.backgroundColor = .black
        view.addSubview(webview)
        webview.snp.makeConstraints {
            $0.edges.equalTo(UIEdgeInsets(top: -50, left: 0, bottom: -50, right: 0))
        }
        view.addSubview(barView)
        barView.snp.makeConstraints { (make) in
            make.top.right.left.equalToSuperview()
            make.height.equalTo(safeAreaTopHeight + 44)
        }
        if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
           var htmlStr = (try? String(contentsOf: url)) ?? ""
           htmlStr = htmlStr.replacingOccurrences(of: "screenWidth", with: "\(screenWidth)")
            htmlStr =  htmlStr.replacingOccurrences(of: "screenHeight", with: "\(screenHeight)")
            webview.loadHTMLString(htmlStr, baseURL: nil)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 7) { [weak self] in
            self?.switchToHome()
        }
    }
    override func bindViewModel() {
        view.rx.tap().delay(.seconds(1), scheduler: MainScheduler.asyncInstance).bind { [unowned self]_ in
            self.switchToHome()
        }.disposed(by: rx.disposeBag)
    }

    func switchToHome(){
        keyWindow.rootViewController = HomeTabbarVC()
    }
}