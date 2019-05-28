//
//  ContactScreen.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 14/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class ContactScreen: BaseViewController {
    
    let cellId = "tableCell"
    
    var collectionView: UICollectionView!
    
    var contactListData: ContactList?

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Bold", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    let contactUsView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "FEE433")
        return view
    }()
    
    let envelopeImageView: UIImageView = {
        let view = UIImageView()
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        view.contentMode = .center
        view.image = UIImage(named: "blackEnvelope")
        return view
    }()
    
    let contactUsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Bold", size: 17)
        label.textAlignment = .center
        return label
    }()
    
    let contactUsButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleContactUsScreen), for: .touchUpInside)
        return button
    }()
    
    @objc func handleContactUsScreen() {
        let screen = ContactUsScreen()

        let vc = UINavigationController(rootViewController: screen)
        present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if defaultLanguage == "sr" {
            contactUsLabel.text = "Контактирајте нас"
            titleLabel.text = "Контакти"
        } else {
            contactUsLabel.text = "Contact Us"
            titleLabel.text = "Contacts"
        }

        let url = "http://ey.nbgcreator.com/api/contacts?lang=\(defaultLanguage)"

        fetchGenericData(urlString: url) { (data: ContactList?, err) in
            if err != nil {
                DispatchQueue.main.async {
                    self.errorMessage.isHidden = false
                    self.removeSpinner()
                }
                return
            }
            self.contactListData = data
            DispatchQueue.main.async {

                self.setupViews()

                self.collectionView.reloadData()
                self.removeSpinner()
            }
        }

        setupCollectionView()
    }
    
    fileprivate func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ContactScreenCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = UIColor.white
    }

    
    func setupViews() {
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50), size: .init(width: 0, height: 70))
        
        view.addSubview(contactUsView)
        contactUsView.anchor(top: titleLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, size: .init(width: 0, height: view.frame.height / 6))
        
        view.addSubview(collectionView)
        collectionView.anchor(top: contactUsView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12))
 
        contactUsView.addSubview(contactUsButton)
        contactUsButton.fillSuperView()
        
        contactUsButton.addSubview(contactUsLabel)
        contactUsLabel.anchor(top: nil, leading: contactUsButton.leadingAnchor, bottom: contactUsButton.bottomAnchor, trailling: contactUsButton.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 24, right: 0), size: .init(width: 0, height: contactUsButton.frame.height / 2))
        
        contactUsButton.addSubview(envelopeImageView)
        envelopeImageView.anchor(top: contactUsButton.topAnchor, leading: contactUsButton.leadingAnchor, bottom: contactUsLabel.topAnchor, trailling: contactUsButton.trailingAnchor)
        
    }
    

}

extension ContactScreen: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 100)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contactListData?.entity.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ContactScreenCell
        
        cell.profileImageView.load(url: URL(string: (contactListData?.entity[indexPath.item].image)!)!)
        
        cell.nameLabel.text = contactListData?.entity[indexPath.item].name
        
        cell.descriptionLabel.text = contactListData?.entity[indexPath.item].title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let screen = ContactDetailsScreen()

        if let id = contactListData?.entity[indexPath.item].id {
            screen.id = id
        }
        
        let vc = UINavigationController(rootViewController: screen)
        present(vc, animated: true, completion: nil)
    }

}
