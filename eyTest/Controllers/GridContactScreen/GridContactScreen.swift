//
//  GridContactScreen.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 21/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class GridContactScreen: BaseViewController {

    var id = ""
    var pageTitle = ""
    var gridContactData: GridContact?
    let cellId = "myCell"

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

        titleLabel.text = pageTitle

        if defaultLanguage == "sr" {
            contactUsLabel.text = "Контактирајте нас"
            //titleLabel.text = "Контакти"
        } else {
            contactUsLabel.text = "Contact Us"
            // titleLabel.text = "Contacts"
        }

        let url = "http://ey.nbgcreator.com/api/menu/submenu?lang=\(defaultLanguage)&id=\(id)"

        fetchGenericData(urlString: url) { (data: GridContact?, err) in
            if err != nil {
                DispatchQueue.main.async {
                    self.errorMessage.isHidden = false
                    self.removeSpinner()
                }
                return
            }
            self.gridContactData = data
            DispatchQueue.main.async {
                self.setupViews()
                self.setupCollectionView()
                self.collectionView.reloadData()
                self.removeSpinner()
            }
        }

        

    }

    fileprivate func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HomeScreenCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = UIColor.white

        collectionView.register(FooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")

        view.addSubview(collectionView)

        collectionView.anchor(top: contactUsView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 12))
    }

    func setupViews() {

        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50), size: .init(width: 0, height: 70))

        view.addSubview(contactUsView)
        contactUsView.anchor(top: titleLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, size: .init(width: 0, height: view.frame.height / 6))

        contactUsView.addSubview(contactUsButton)
        contactUsButton.fillSuperView()

        contactUsButton.addSubview(contactUsLabel)
        contactUsLabel.anchor(top: nil, leading: contactUsButton.leadingAnchor, bottom: contactUsButton.bottomAnchor, trailling: contactUsButton.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 24, right: 0), size: .init(width: 0, height: contactUsButton.frame.height / 2))

        contactUsButton.addSubview(envelopeImageView)
        envelopeImageView.anchor(top: contactUsButton.topAnchor, leading: contactUsButton.leadingAnchor, bottom: contactUsLabel.topAnchor, trailling: contactUsButton.trailingAnchor)

    }
}

extension GridContactScreen: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    //    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    //        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath) as! FooterView
    //        footer.backgroundColor = UIColor.darkGray
    //        return footer
    //    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {

        // return CGSize(collectionView.frame.width, 20)
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height - (((collectionView.frame.width - 10) / 2) * 3) - 40)
        //        return .init(width: collectionView.frame.width, height: 72)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = (collectionView.frame.width - 10) / 2

        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gridContactData?.entity?.list?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeScreenCell

        cell.thumbailImageView.load(url: URL(string: (gridContactData?.entity?.list?[indexPath.item].image)!)!)

        cell.titleLabel.text = gridContactData?.entity?.list?[indexPath.item].title

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let screen = ExpandableListScreen()
        screen.pageTitle = gridContactData?.entity?.list?[indexPath.item].title
        screen.isFaqList = false
        screen.id = (gridContactData?.entity?.list?[indexPath.item].objectID)!
        let vc = UINavigationController(rootViewController: screen)
        present(vc, animated: true, completion: nil)
    }
}
