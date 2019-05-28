//
//  SearchScreen.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 08/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class SearchScreen: UIViewController, UISearchBarDelegate {

    let searchBar:UISearchBar = UISearchBar()

    var results: SearchRresult?
    let cellId = "cell"
    var tableView: UITableView!
    var defaultLanguage = "en"
    let defaults = UserDefaults.standard

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Bold", size: 20)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor(hexString: "FEE433")

        return label
    }()



    @objc func handleDismissAction() {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        defaultLanguage = defaults.string(forKey: "DefaultLanguage") ?? "en"

        view.backgroundColor = UIColor(hexString: "323334")
        if defaultLanguage == "en" {
            navigationItem.title = "Search"
        } else {
            navigationItem.title = "Претражи"
        }
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(hexString: "FEE433"), NSAttributedString.Key.font: UIFont(name: "EYInterstate-Bold", size: 20)!]

        let dismissImage = #imageLiteral(resourceName: "dismiss")

        let dismissButton   = UIBarButtonItem(image: dismissImage,  style: .plain, target: self, action: #selector(handleDismissAction))

        navigationItem.rightBarButtonItems = [dismissButton]



        setupSearchBar()
        setupTableView()
        tableView.anchor(top: searchBar.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor)
    }


    func setupSearchBar() {

        //IF you want frame replace first line and comment "searchBar.sizeToFit()"
        //let searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 10, y: 10, width: headerView.frame.width-20, height: headerView.frame.height-20))
        searchBar.searchBarStyle = UISearchBar.Style.prominent

        if defaultLanguage == "en" {
            searchBar.placeholder = "Search..."
        } else {
            searchBar.placeholder = "Претражи..."
        }

        searchBar.sizeToFit()
        searchBar.barTintColor = UIColor(hexString: "323334")
        searchBar.isTranslucent = true
        searchBar.backgroundColor = UIColor(hexString: "323334")
        searchBar.delegate = self
        searchBar.textField?.backgroundColor = UIColor(hexString: "323334")
        searchBar.textField?.textColor = .white

        view.addSubview(searchBar)//Here change your view name


        searchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {

        fetchGenericData(urlString: "https://ey.nbgcreator.com/api/news/search?lang=\(defaultLanguage)&phrase=\(textSearched.lowercased())") { (data: SearchRresult?, error) in
            DispatchQueue.main.async {
                self.results = data
                self.tableView.reloadData()
            }
        }
    }

    func setupTableView() {
        tableView = UITableView(frame: self.view.frame, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SearchScreenCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = .clear//UIColor(hexString: "323334")
        self.view.addSubview(tableView)
        tableView.separatorColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0

    }

    func handleSearchResultTap(id: String, category: String, title: String) {
        switch category {
        case "Tax news":

            let screen = SingleTaxCalendarScreen()
            screen.taxCalTitlLabel.text = title
            screen.id = id
            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)

        case "Economic news":

            let screen = SingleNewsScreen()
            screen.id = id
            screen.singleNewsTitle = title

            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)

        case "EY events":

            let screen = SingleEventScreen()
            screen.pageTitle = title
            screen.id = id
            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)

        case "Consumer goods":

            let screen = NewsListScreen()
            screen.id = id
            screen.newsListTitle = title
            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)

        case "Financial services":

            let screen = NewsListScreen()
            screen.id = id
            screen.newsListTitle = title
            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)

        case "Pharmacy and health care":

            let screen = NewsListScreen()
            screen.id = id
            screen.newsListTitle = title
            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)

        case "Energy and mining":

            let screen = NewsListScreen()
            screen.id = id
            screen.newsListTitle = title
            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)

        case "Telecommunications, media and IT":

            let screen = NewsListScreen()
            screen.id = id
            screen.newsListTitle = title
            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)

        case "Other":

            let screen = NewsListScreen()
            screen.id = id
            screen.newsListTitle = title
            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)

        case "Tax newsletter":

            let screen = SingleTaxNewsScreen()

            screen.taxTitle = title
            screen.id = id

            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)

        case "Tax blog ":

            let screen = SingleNewsScreen()
            screen.id = id
            screen.singleNewsTitle = title

            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)

        case "Video content":

            let screen = SingleNewsScreen()
            screen.id = id
            screen.singleNewsTitle = title
            screen.isVideo = true

            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)

        default:
            print("Under Construction: " + category)
        }
    }

}

extension SearchScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results?.entity.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SearchScreenCell

        cell.titleLabel.text = results?.entity[indexPath.item].cateory

        cell.subtitleLabel.text = results?.entity[indexPath.item].title

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let id = results?.entity[indexPath.row].id, let category = results?.entity[indexPath.row].cateory, let title = results?.entity[indexPath.item].title {
            handleSearchResultTap(id: id, category: category, title: title)
        }
    }


}

extension UISearchBar {
    var textField: UITextField? {
        return subviews.first?.subviews.first(where: { $0.isKind(of: UITextField.self) }) as? UITextField
    }
}

