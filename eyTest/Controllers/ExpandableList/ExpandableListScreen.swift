//
//  ExpandableListScreen.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 05/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

struct ExpandableNames {
    var isExpanded: Bool
    let answer: [String]
    let question: String
    let id: String
}

class ExpandableListScreen: BaseViewController {

    let cellId = "tableCell"
    var pageTitle: String?
    var pdfLink: String?
   


    var isFaqList = false
    var id = ""

    var twoDimensionalArray = [ExpandableNames]()

    var tableView = UITableView()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Bold", size: 20)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    let openPdfButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "pdf"), for: .normal)
        button.addTarget(self, action: #selector(handleOpenningPdf), for: .touchUpInside)
        button.isHidden = true
        return button
    }()

    @objc func handleOpenningPdf() {
        let screen = PdfScreen()

        screen.pdfLink = pdfLink!

        let vc = UINavigationController(rootViewController: screen)
        present(vc, animated: true, completion: nil)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        var url = "http://ey.nbgcreator.com/api/faq?lang=\(defaultLanguage)"

        if isFaqList {
           // url = url
        } else {
            url = url + "&id=" + id
        }

        fetchGenericData(urlString: url) { (data: Expandable?, error) in
            if error != nil {
                self.errorMessage.isHidden = false
                self.removeSpinner()
                return
            }
//            self.expandableData = data

            DispatchQueue.main.async {

                for i in 0..<(data?.entity?.list?.count)! {
                    self.twoDimensionalArray.append(ExpandableNames(isExpanded: false, answer: [(data?.entity?.list?[i].answer)!], question: (data?.entity?.list?[i].question)!, id: (data?.entity?.list?[i].id)!))
                }

                if let link = data?.entity?.file {
                    self.pdfLink = link
                    self.openPdfButton.isHidden = false
                }

                self.titleLabel.text = self.pageTitle
                self.setupViews()

                self.setupTableView()
                self.tableView.reloadData()
                self.removeSpinner()
            }
        }

    }

    func setupViews() {

        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: backButton.trailingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 50), size: .init(width: 0, height: 70))

        view.addSubview(openPdfButton)
        openPdfButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: titleLabel.trailingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 12))

    }

    func setupTableView() {
        tableView = UITableView(frame: self.view.frame, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.separatorColor = .clear
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 40


        tableView.anchor(top: titleLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 20, left: 10, bottom: 20, right: 10))
    }

}

extension ExpandableListScreen: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }()

        return footerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }


    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let plusMinusImage: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFill
            view.clipsToBounds = true
            view.image = #imageLiteral(resourceName: "plus")
            return view
        }()

        let button = UIButton(type: .system)
       // button.setTitle(twoDimensionalArray[section].question, for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(hexString: "DFDFDF").cgColor

        button.addTarget(self, action: #selector(handleExpandClose(button:plusMinusImage:)), for: .touchUpInside)

        button.tag = section


        let questionLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "EYInterstate-LightBold", size: 17)
            label.numberOfLines = 0
            label.textAlignment = .left
            label.lineBreakMode = .byWordWrapping
            //label.adjustsFontSizeToFitWidth = true

            return label
        }()


        button.addSubview(questionLabel)
        questionLabel.anchor(top: button.topAnchor, leading: button.leadingAnchor, bottom: button.bottomAnchor, trailling: nil, padding: .init(top: 12, left: 12, bottom: 12, right: 0), size: .init(width: screensize.width * 0.6, height: 0))

        questionLabel.text = twoDimensionalArray[section].question



        button.addSubview(plusMinusImage)
        plusMinusImage.anchor(top: questionLabel.centerYAnchor, leading: nil, bottom: nil, trailling: button.trailingAnchor, padding: .init(top: -15, left: 0, bottom: 0, right: 12), size: .init(width: 30, height: 30))

        return button
    }

    @objc func handleExpandClose(button: UIButton, plusMinusImage: UIImageView) {

        let section = button.tag



        var indexPaths = [IndexPath]()

        for row in twoDimensionalArray[section].answer.indices {

            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }

        let isExpanded = twoDimensionalArray[section].isExpanded

        twoDimensionalArray[section].isExpanded = !isExpanded

        let plusMinusImage: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFill
            view.clipsToBounds = true
            view.image = #imageLiteral(resourceName: "plus")
            return view
        }()

        button.addSubview(plusMinusImage)
        plusMinusImage.anchor(top: button.centerYAnchor, leading: nil, bottom: nil, trailling: button.trailingAnchor, padding: .init(top: -15, left: 0, bottom: 0, right: 12), size: .init(width: 30, height: 30))

        plusMinusImage.image = !isExpanded ? #imageLiteral(resourceName: "minus") : #imageLiteral(resourceName: "plus")

        if isExpanded {
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }

    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionalArray.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !twoDimensionalArray[section].isExpanded {
            return 0
        }
        return twoDimensionalArray[section].answer.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        let name = twoDimensionalArray[indexPath.section].answer[indexPath.row]

        cell.textLabel?.attributedText =  formatHtmlString(htmlString: name)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.isUserInteractionEnabled = false
       // cell.textLabel?.text = "\(name)"

        return cell
    }

}
