//
//  PollsResultsScreen.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 07/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class PollsResultsScreen: BaseViewController {

    var testArray: Array<Double>?

    var id = ""
    

    var results: PollsResults?
    var collectionView: UICollectionView!
    let cellId = "collectionCell"
    let tableCellId = "tableCell"
    var alphabet = Array("АБЦДЕФГХИЈКЛМНОПQРСТУВWXYЗ")
    var tableView: UITableView!

    var date: String?
    var pageTitle: String?

    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "FEE433")
        return view
    }()

    let headerText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Bold", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5

        return label
    }()

    let publishDateHolder: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor(hexString: "FEE433").cgColor
        view.layer.borderWidth = 5
        view.layer.cornerRadius = 7
        view.clipsToBounds = true
        return view
    }()

    let calThumbail: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "calendar")
        view.contentMode = .scaleAspectFill
        return view
    }()

    let publishDate: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Regular", size: 15)
        label.textAlignment = .left

        return label
    }()

    let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-LighBold", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        if defaultLanguage == "sr" {
            alphabet = Array("АБЦДЕФГХИЈКЛМНОПQРСТУВWXYЗ")

        } else {
            alphabet = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        }

        let url = "http://ey.nbgcreator.com/api/polls/results/?lang=\(defaultLanguage)&id="

        fetchGenericData(urlString: url + id) { (data: PollsResults?, error) in

            if error != nil {
                self.showErrorMessage()
                return
            }
            self.results = data
            DispatchQueue.main.async {

                if let total = data?.entity?.total {
                    if self.defaultLanguage == "sr" {
                        self.headerText.text = "Резултати анкете \n Укупно је учествовало \(String(total)) корисника"
                    } else {
                        self.headerText.text = "Poll results \n A total of \(String(total)) users participated"
                    }
                }

                self.setupCollectionView()
                self.setupViews()
                self.setupTableView()


                self.tableView.reloadData()
                self.collectionView.reloadData()

                //    handleTap(progressBar: circularProgressBar, value: 45.00 / 100)

                self.view.bringSubviewToFront(self.backButton)
                self.removeSpinner()
            }
        }


        publishDate.text = date

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil, userInfo: nil)
    }
    
    func setupViews() {
        view.addSubview(headerView)
        headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, size: .init(width: 0, height: 100))

        headerView.addSubview(headerText)
        headerText.anchor(top: headerView.topAnchor, leading: headerView.leadingAnchor, bottom: nil, trailling: headerView.trailingAnchor, padding: .init(top: 24, left: 12, bottom: 0, right: 12))

        view.addSubview(publishDateHolder)
        publishDateHolder.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: nil, padding: .init(top: 75, left: (screensize.width / 2) - 125, bottom: 0, right: 0), size: .init(width: 250, height: 50))

        publishDateHolder.addSubview(calThumbail)
        calThumbail.anchor(top: publishDateHolder.topAnchor, leading: publishDateHolder.leadingAnchor, bottom: publishDateHolder.bottomAnchor, trailling: nil, padding: .init(top: 5, left: 24, bottom: 5, right: 0))

        publishDateHolder.addSubview(publishDate)
        publishDate.anchor(top: publishDateHolder.topAnchor, leading: calThumbail.trailingAnchor, bottom: publishDateHolder.bottomAnchor, trailling: nil, padding: .init(top: 12, left: 5, bottom: 12, right: 0))

        view.addSubview(collectionView)
        collectionView.anchor(top: publishDateHolder.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: 150))
    }

    func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ResultsCircleCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = UIColor.white
    }

    func setupTableView() {
        tableView = UITableView(frame: self.view.frame, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PollAnswersCell.self, forCellReuseIdentifier: tableCellId)
        tableView.backgroundColor = UIColor.white
        tableView.separatorColor = .clear
        self.view.addSubview(tableView)


        tableView.anchor(top: collectionView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 12, right: 12))
    }

    func handleTap(progressBar: CAShapeLayer, value: Double) {

        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")

        basicAnimation.toValue = value

        basicAnimation.duration = 2

        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false


        progressBar.add(basicAnimation, forKey: "urSoBasic")

        //        basicAnimation.toValue = centerScore
        //        secondCircularProgressBar.add(basicAnimation, forKey: "urSoBasic")
        //
        //        basicAnimation.toValue = rightScore
        //        thirdCircularProgressBar.add(basicAnimation, forKey: "urSoBasic")

    }

    func addCircleProgressBar(progressBar: CAShapeLayer, position: CGPoint, radius: CGFloat, lineWidth: CGFloat, fillColor: CGColor, strokeColor: CGColor, trackColor: CGColor, subViewOf: UIView) {


        let trackLayer = CAShapeLayer()
        let leftTracktCircularPath = UIBezierPath(arcCenter: .zero, radius: radius , startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        trackLayer.path = leftTracktCircularPath.cgPath

        trackLayer.strokeColor = trackColor
        trackLayer.lineWidth = lineWidth
        trackLayer.strokeEnd = 100
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.position = position

        subViewOf.layer.addSublayer(trackLayer)

        let circularPath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        progressBar.path = circularPath.cgPath

        progressBar.strokeColor = strokeColor
        progressBar.lineWidth = lineWidth
        progressBar.strokeEnd = 0
        progressBar.fillColor = fillColor
        progressBar.lineCap = CAShapeLayerLineCap.round
        progressBar.position = position
        progressBar.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)

        subViewOf.layer.addSublayer(progressBar)
    }

}

extension PollsResultsScreen: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results?.entity?.options?.count ?? 0
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ResultsCircleCell

        handleTap(progressBar: cell.circularProgressBar, value: results!.entity!.options![indexPath.item].percentage! / 100)

        cell.percentLabel.text = String(alphabet[indexPath.item]) + ": " + String(results!.entity!.options![indexPath.item].percentage!) + "%"

        return cell
    }


}

extension PollsResultsScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results?.entity?.options?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellId, for: indexPath) as! PollAnswersCell

        cell.alphabetImage.isHidden = true

        cell.answerLabel.anchor(top: cell.cellView.topAnchor, leading: cell.cellView.leadingAnchor, bottom: cell.cellView.bottomAnchor, trailling: cell.cellView.trailingAnchor, padding: .init(top: 8, left: 8, bottom: 8, right: 8))


        if let percentage = results?.entity?.options?[indexPath.item].percentage {
            if defaultLanguage == "sr" {
                cell.answerLabel.text = "Одговор под \(String(alphabet[indexPath.item])) изабрало је \(String(percentage))%"
            } else {

                cell.answerLabel.text = "Answer \(String(alphabet[indexPath.item])) is choosed by \(String(percentage))%"
            }
        }

        cell.isUserInteractionEnabled = false

        return cell
    }


}
