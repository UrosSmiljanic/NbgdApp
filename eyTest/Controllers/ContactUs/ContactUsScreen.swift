//
//  ContactUsScreen.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 11/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class ContactUsScreen: BaseViewController {

    let headerView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "contactHeader")
        view.backgroundColor = .black
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Bold", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.text = "Contact"

        return label
    }()

    let sendMailButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont(name: "EYInterstate-Bold", size: 20)

        button.addTarget(self, action: #selector(handleSendingMail), for: .touchUpInside)

        return button
    }()

    let nameTextField: TextField = {
        let textField = TextField()
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.font: UIFont(name: "EYInterstate-Regular", size: 15)!])
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.black.cgColor
        textField.adjustsFontSizeToFitWidth = true
        textField.backgroundColor = UIColor(hexString: "DFDFDF")

        return textField
    }()

    let surnameTextField: TextField = {
        let textField = TextField()
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(string: "Surname", attributes: [NSAttributedString.Key.font: UIFont(name: "EYInterstate-Regular", size: 15)!])
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.black.cgColor
        textField.adjustsFontSizeToFitWidth = true
        textField.backgroundColor = UIColor(hexString: "DFDFDF")

        return textField
    }()

    let mailTextField: TextField = {
        let textField = TextField()
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(string: "Mail", attributes: [NSAttributedString.Key.font: UIFont(name: "EYInterstate-Regular", size: 15)!])
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.black.cgColor
        textField.adjustsFontSizeToFitWidth = true
        textField.backgroundColor = UIColor(hexString: "DFDFDF")

        return textField
    }()

    let messageTextField: TextField = {
        let textField = TextField()
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(string: "Message", attributes: [NSAttributedString.Key.font: UIFont(name: "EYInterstate-Regular", size: 15)!])
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.black.cgColor
        textField.adjustsFontSizeToFitWidth = true
        textField.backgroundColor = UIColor(hexString: "DFDFDF")
        textField.contentVerticalAlignment = .top

        return textField
    }()

    fileprivate func setupViews() {
        view.addSubview(headerView)
        headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, size: .init(width: 0, height: 200))

        view.addSubview(titleLabel)
        titleLabel.anchor(top: headerView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, size: .init(width: 0, height: 60))

        view.addSubview(sendMailButton)
        sendMailButton.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 12), size: .init(width: view.frame.width - 24, height: 50))

        view.addSubview(nameTextField)
        nameTextField.anchor(top: titleLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: 35))

        view.addSubview(surnameTextField)
        surnameTextField.anchor(top: nameTextField.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: 35))

        view.addSubview(mailTextField)
        mailTextField.anchor(top: surnameTextField.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: 35))

        view.addSubview(messageTextField)
        messageTextField.anchor(top: mailTextField.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: sendMailButton.topAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 12))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if defaultLanguage == "sr" {
            titleLabel.text = "Kontakt"
            nameTextField.placeholder = "Име"
            surnameTextField.placeholder = "Презиме"
            mailTextField.placeholder = "Маил"
            messageTextField.placeholder = "Порука"

            sendMailButton.setTitle("Пошаљите поруку",for: .normal)
        } else {
            titleLabel.text = "Contact"
            nameTextField.placeholder = "Name"
            surnameTextField.placeholder = "Surname"
            mailTextField.placeholder = "Mail"
            messageTextField.placeholder = "Message"

            sendMailButton.setTitle("Send message",for: .normal)
        }

        hideKeyboardWhenTappedAround()

        removeSpinner()

        setupViews()
    }
    
    @objc func handleSendingMail() {
        if nameTextField.text == "" || surnameTextField.text == "" || mailTextField.text == "" || messageTextField.text == "" {
            print("error")
        } else {
            // sendMail(firstName: nameTextField.text!, lastName: surnameTextField.text!, email: mailTextField.text!, language: ln!, message: messageTextField.text!)
            var parameters = [String : Any]()
            parameters = [
                "first_name": nameTextField.text!,
                "last_name": surnameTextField.text!,
                "email": mailTextField.text!,
                "lang": defaultLanguage,
                "message": messageTextField.text!
            ]

            ApiService.callPost(url: URL(string: "http://ey.nbgcreator.com/api/contacts/")!, params: parameters, finish: finishPost)
        }

    }

    func finishPost (message:String, data:Data?) -> Void
    {
        do
        {
            if let jsonData = data
            {
                let parsedData = try JSONDecoder().decode(Response.self, from: jsonData)
//                print(parsedData)
                DispatchQueue.main.async {
                    if parsedData.status == 200 {
                        let alert = UIAlertController(title: "Success", message: parsedData.message, preferredStyle: .alert)

                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        // alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

                        self.present(alert, animated: true)
                    } else {
                        let alert = UIAlertController(title: "Error", message: parsedData.message, preferredStyle: .alert)

                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        // alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

                        self.present(alert, animated: true)
                    }
                }
            }
        }
        catch
        {
            print("Parse Error: \(error)")
        }
    }
}

