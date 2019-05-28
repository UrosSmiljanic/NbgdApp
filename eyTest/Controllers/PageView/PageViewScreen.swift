//
//  PageViewScreen.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 08/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit
import WebKit

class PageViewScreen: BaseViewController {

    var id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = "http://ey.nbgcreator.com/api/pages/?lang=\(defaultLanguage)&id="

        fetchGenericData(urlString: url + id) { (data: PageView?, error) in
            if error != nil {
                DispatchQueue.main.async {
                    self.errorMessage.isHidden = false
                    self.removeSpinner()
                }
                return
            }

            DispatchQueue.main.async {

                if var pageView = data?.entity?.content {

                    let width = self.screensize.width * 2.3


                    if self.id == "10" {
                        let firstHeight = width / 3.16
                        let secondHeight = width / 2.64
                        let thirdHeight = width / 2.97
                        pageView = pageView.replacingOccurrences(of: "1200", with: "\(width)")
                        pageView = pageView.replacingOccurrences(of: "379", with: "\(firstHeight)")
                        pageView = pageView.replacingOccurrences(of: "453", with: "\(secondHeight)")
                        pageView = pageView.replacingOccurrences(of: "403", with: "\(thirdHeight)")
                    } else {
                        let firstHeight = width / 4.411
                        let secondHeight = width / 2.64
                        let thirdHeight = width / 2.97
                        pageView = pageView.replacingOccurrences(of: "1200", with: "\(width)")
                        pageView = pageView.replacingOccurrences(of: "227", with: "\(firstHeight)")
                        pageView = pageView.replacingOccurrences(of: "452", with: "\(secondHeight)")
                        pageView = pageView.replacingOccurrences(of: "402", with: "\(thirdHeight)")
                    }



                    self.webView.loadHTMLString(pageView, baseURL: nil)


                }

                if let image = data?.entity?.header {
                    self.thumbailImage.load(url: URL(string: image)!)
                }


self.setupViews()
                self.removeSpinner()
            }
        }
    }
    

    let thumbailImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()

    let webView: WKWebView = {
        let view = WKWebView()
        return view
    }()

    func setupViews() {
        view.addSubview(thumbailImage)
        thumbailImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, size: .init(width: 0, height: 250))

        view.addSubview(webView)
        webView.anchor(top: thumbailImage.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor)
    }

}
