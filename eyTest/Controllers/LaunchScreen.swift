//
//  ViewController.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 12/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit
import SwiftVideoBackground

class LaunchScreen: UIViewController {
    
     var timer = Timer()
    let defaults = UserDefaults.standard
    
    let splashScreen: UIView = {
        let view = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let date = Date()
        let calendar = Calendar.current

        defaults.set(calendar.component(.year, from: date), forKey: "currentYear")
        defaults.set(calendar.component(.month, from: date), forKey: "currentMonth")
        defaults.set(calendar.component(.day, from: date), forKey: "currentDay")
        defaults.synchronize()
        
        setupViews()
        
        try? VideoBackground.shared.play(view: splashScreen, videoName: "splashScreen", videoType: "mp4")
        
        timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(handleNextViewController), userInfo: nil, repeats: true)
    }
    
    private func setupViews() {
        view.addSubview(splashScreen)
        splashScreen.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor)
    }
    
    @objc func handleNextViewController() {
        timer.invalidate()

        if defaults.bool(forKey: "introCompleted") {
            let screen = HomeScreen()

            let vc = UINavigationController(rootViewController: screen)

            present(vc, animated: true, completion: nil)
        } else {
            let vc = ChooseLanguageScreen()
            show(vc, sender: self)
        }


    }
    
}

