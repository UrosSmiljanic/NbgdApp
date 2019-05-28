//
//  ContactDetailsScreen.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 14/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class ContactDetailsScreen: BaseViewController {

    var id: String?
    var contactDetails: ContactDetails?
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    let headerView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "contactHeader")
        view.backgroundColor = .black
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let profileImageView: UIImageView = {
        let view = UIImageView()
        view.layer.borderColor = UIColor(hexString: "FEE433").cgColor
        view.layer.borderWidth = 5
        view.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        view.backgroundColor = .black
        view.contentMode = .scaleAspectFill
        view.roundedImage()
        return view
    }()
    
        let nameLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.textAlignment = .center
            label.font = .boldSystemFont(ofSize: 17)
            return label
        }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    let emailView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.groupTableViewBackground
        return view
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    let sendMailButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleSendingMail), for: .touchUpInside)
        button.backgroundColor = UIColor(hexString: "FEE433")
        button.setImage(#imageLiteral(resourceName: "blackEnvelope"), for: .normal)
        return button
    }()
    
    @objc func handleSendingMail() {
        let appURL = URL(string: contactDetails!.entity.email)!

        let email = contactDetails!.entity.email
        if let url = NSURL(string: "mailto:\(email)") {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
        }
        else {
            UIApplication.shared.openURL(appURL as URL)
        }
    }
    
    let phoneNumView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.groupTableViewBackground
        return view
    }()
    
    let phoneNumLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    let phoneButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleContactCalling), for: .touchUpInside)
        button.backgroundColor = UIColor(hexString: "FEE433")
        button.setImage(#imageLiteral(resourceName: "phone"), for: .normal)
        return button
    }()
    
    @objc func handleContactCalling() {
        phoneNumLabel.text?.makeACall()
    }
    
    let bioView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.groupTableViewBackground
        return view
    }()
    
    let bioLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    let openBioButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleOpeningBio), for: .touchUpInside)
        button.backgroundColor = UIColor(hexString: "FEE433")
        button.setImage(#imageLiteral(resourceName: "contact"), for: .normal)
        return button
    }()
    
    var bioIsOpen = false
    
    @objc func handleOpeningBio() {
        if bioIsOpen {
            bioIsOpen = false
            fullBioLabel.removeFromSuperview()
        } else {
            bioIsOpen = true
            scrollView.addSubview(fullBioLabel)
            fullBioLabel.anchor(top: bioView.bottomAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailling: scrollView.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12))
        }
        
        scrollView.resizeScrollViewContentSize()
    }
    
    let fullBioLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let id = id {
            let url = "http://ey.nbgcreator.com/api/contacts/single?lang=\(defaultLanguage)&id=\(id)"

            
            fetchGenericData(urlString: url) { (data: ContactDetails?, err) in
                if err != nil {
                    DispatchQueue.main.async {
                        self.errorMessage.isHidden = false
                        self.removeSpinner()
                    }
                    return
                }
                self.contactDetails = data
                DispatchQueue.main.async {
                    self.nameLabel.text = data!.entity.name
                    self.profileImageView.load(url: URL(string: data!.entity.image)!)
                    self.descriptionLabel.text = data!.entity.title
                    self.emailLabel.text = data!.entity.email

                    if self.defaultLanguage == "sr" {
                        self.bioLabel.text = "Биографија"
                    } else {
                        self.bioLabel.text = "Biography"
                    }

                    self.phoneNumLabel.text = data!.entity.phone
                    self.fullBioLabel.attributedText = formatHtmlString(htmlString: data!.entity.biography)
                    self.setupViews()
                    self.view.bringSubviewToFront(self.backButton)
                    self.removeSpinner()
                }
            }
        }
    }
    
    func setupViews() {
        
        
        view.addSubview(scrollView)
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor)
        backButton.bringSubviewToFront(scrollView)
        scrollView.addSubview(headerView)
        headerView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailling: scrollView.trailingAnchor, size: .init(width: screensize.width, height: screensize.height / 5))
        
        scrollView.addSubview(profileImageView)
        profileImageView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailling: nil, padding: .init(top: (screensize.height / 5) - 75, left: (screensize.width / 2) - 75, bottom: 0, right: 0), size: .init(width: 150, height: 150))
        
        scrollView.addSubview(nameLabel)
        nameLabel.anchor(top: profileImageView.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailling: scrollView.trailingAnchor, padding: .init(top: 24, left: 0, bottom: 0, right: 0))
        
        scrollView.addSubview(descriptionLabel)
        descriptionLabel.anchor(top: nameLabel.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailling: scrollView.trailingAnchor, padding: .init(top: 24, left: screensize.width / 5, bottom: 0, right: screensize.width / 5))
        
        scrollView.addSubview(emailView)
        emailView.anchor(top: descriptionLabel.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailling: scrollView.trailingAnchor, padding: .init(top: 24, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: 50))
        
        emailView.addSubview(emailLabel)
        emailLabel.anchor(top: emailView.topAnchor, leading: emailView.leadingAnchor, bottom: emailView.bottomAnchor, trailling: nil, padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        
        emailView.addSubview(sendMailButton)
        sendMailButton.anchor(top: emailView.topAnchor, leading: nil, bottom: emailView.bottomAnchor, trailling: emailView.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 5, right: 5), size: .init(width: 40 * 1.3, height: 0))
        
        scrollView.addSubview(phoneNumView)
        phoneNumView.anchor(top: emailView.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailling: scrollView.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: 50))
        
        phoneNumView.addSubview(phoneNumLabel)
        phoneNumLabel.anchor(top: phoneNumView.topAnchor, leading: phoneNumView.leadingAnchor, bottom: phoneNumView.bottomAnchor, trailling: nil, padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        
        phoneNumView.addSubview(phoneButton)
        phoneButton.anchor(top: phoneNumView.topAnchor, leading: nil, bottom: phoneNumView.bottomAnchor, trailling: phoneNumView.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 5, right: 5), size: .init(width: 40 * 1.3, height: 0))
        
        scrollView.addSubview(bioView)
        bioView.anchor(top: phoneNumView.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailling: scrollView.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: 50))
        
        bioView.addSubview(bioLabel)
        bioLabel.anchor(top: bioView.topAnchor, leading: bioView.leadingAnchor, bottom: bioView.bottomAnchor, trailling: nil, padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        
        bioView.addSubview(openBioButton)
        openBioButton.anchor(top: bioView.topAnchor, leading: nil, bottom: bioView.bottomAnchor, trailling: bioView.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 5, right: 5), size: .init(width: 40 * 1.3, height: 0))
        
    }
    
}
