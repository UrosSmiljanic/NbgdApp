//
//  IntroPagesCell.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 12/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class IntroPagesCell: BaseCollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var industriesToSelect: Industries?
    var selectedIndustries: Array = [String]()

    private let cellId = "cell"
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return industriesToSelect?.entity?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! IndustriesToChoose
        if let title = industriesToSelect?.entity?[indexPath.item].name {
            cell.industryTitle.text = title
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 10) / 2, height: 60)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell:IndustriesToChoose = collectionView.cellForItem(at: indexPath)! as! IndustriesToChoose

        selectedCell.checkMark.isHidden = false

        selectedCell.cellView.backgroundColor = UIColor(hexString: "#FEE433")

        selectedIndustries.append((industriesToSelect?.entity?[indexPath.item].id)!)

    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cellToDeselect:IndustriesToChoose = collectionView.cellForItem(at: indexPath)! as! IndustriesToChoose

        cellToDeselect.cellView.backgroundColor = UIColor(hexString: "#DFDFDF")
        cellToDeselect.checkMark.isHidden = true

        if let id = industriesToSelect?.entity?[indexPath.item].id {
            self.selectedIndustries = selectedIndustries.filter {$0 != id}
        }
    }


    let itemListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.allowsMultipleSelection = true

        return collectionView
    }()

    
    let thumbailView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "EYInterstate-Bold", size: 20)
        return label
    }()
    
    let introTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.textAlignment = .left
        return textView
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 3
        label.text = "By selecting the industry, you filter the news and articles that you will receive about the selected industry."
        return label
    }()
    
    let settingsTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "EYInterstate-Bold", size: 20)
        label.text = "Choose industry"
        return label
    }()
    
    let chooseAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(hexString: "DFDFDF")
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "EYInterstate-Bold", size: 16)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.setTitle("Choose all industries", for: .normal)
        
        return button
    }()


    
    let introNavigation: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()

    func setIndustries(industries: Industries) {
        industriesToSelect = industries
    }

    var isIndustrySelected = false

    func selectAllIndustries() {

        chooseAllButton.backgroundColor = UIColor(hexString: "FEE433")

        for i in 0..<itemListCollectionView.numberOfSections {
            for j in 0..<itemListCollectionView.numberOfItems(inSection: i) {
                itemListCollectionView.selectItem(at: IndexPath(row: j, section: i), animated: false, scrollPosition: [])
                let selectedCell:IndustriesToChoose = itemListCollectionView.cellForItem(at: IndexPath(row: j, section: i))! as! IndustriesToChoose

                if isIndustrySelected {
                    selectedCell.checkMark.isHidden = true

                    selectedCell.cellView.backgroundColor = UIColor(hexString: "DFDFDF")

                    self.selectedIndustries.removeAll()
                    chooseAllButton.backgroundColor = UIColor(hexString: "DFDFDF")

                } else {
                    selectedCell.checkMark.isHidden = false

                    selectedCell.cellView.backgroundColor = UIColor(hexString: "#FEE433")

                    if let id = industriesToSelect?.entity?[IndexPath(row: j, section: i).row].id {
                        self.selectedIndustries.append(id)
                    }
                }

            }
        }

        isIndustrySelected = !isIndustrySelected

    }

    override func setupViews() {
        super.setupViews()

        addSubview(introNavigation)
        introNavigation.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailling: contentView.trailingAnchor, padding: .init(top: 3, left: 0, bottom: 0, right: 0))
        introNavigation.layer.zPosition = 1

        addSubview(thumbailView)
        thumbailView.anchor(top: introNavigation.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailling: contentView.trailingAnchor, padding: .init(top: 80, left: 20, bottom: 0, right: 20),size: .init(width: 0, height: 130))
        
        addSubview(titleLabel)
        titleLabel.anchor(top: thumbailView.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailling: contentView.trailingAnchor, padding: .init(top: 50, left: 0, bottom: 0, right: 0))
        
        addSubview(introTextView)
        introTextView.anchor(top: titleLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailling: contentView.trailingAnchor, padding: .init(top: 50, left: 12, bottom: 12, right: 12))
        
    }

   
    
    func setupSettingsView() {
        thumbailView.removeFromSuperview()
        titleLabel.removeFromSuperview()
        introTextView.removeFromSuperview()

        addSubview(infoLabel)
        infoLabel.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailling: contentView.trailingAnchor, padding: .init(top: 80, left: 12, bottom: 0, right: 12))
        
        addSubview(titleLabel)
        titleLabel.anchor(top: infoLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailling: contentView.trailingAnchor, padding: .init(top: 50, left: 12, bottom: 0, right: 12))
        
        addSubview(chooseAllButton)
        chooseAllButton.anchor(top: titleLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailling: contentView.trailingAnchor, padding: .init(top: 50, left: 12, bottom: 0, right: 12), size: .init(width: contentView.frame.width - 24, height: 50))


        addSubview(itemListCollectionView)
        itemListCollectionView.anchor(top: chooseAllButton.bottomAnchor, leading: chooseAllButton.leadingAnchor, bottom: bottomAnchor, trailling: chooseAllButton.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 12, right: 0))

        itemListCollectionView.dataSource = self
        itemListCollectionView.delegate = self
        itemListCollectionView.backgroundColor = .white
        itemListCollectionView.register(IndustriesToChoose.self, forCellWithReuseIdentifier: cellId)


    }
    
    
}
