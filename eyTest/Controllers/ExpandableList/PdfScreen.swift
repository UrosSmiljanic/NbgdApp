//
//  PdfScreen.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 06/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit
import PDFKit
import WebKit

class PdfScreen: BaseViewController {

    var pdfLink = ""

    let webView: WKWebView = {
        let view = WKWebView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(webView)
        webView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 12))
        let url: URL! = URL(string: pdfLink)

        webView.load(URLRequest(url: url))
        view.bringSubviewToFront(self.backButton)
        removeSpinner()
    }
}
