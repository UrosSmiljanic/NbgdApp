//
//  ResultsCircleCell.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 07/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class ResultsCircleCell: BaseCollectionViewCell {

    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    let percentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Regular", size: 12)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5

        return label
    }()

    let circularProgressBar = CAShapeLayer()

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

    override func setupViews() {
        super.setupViews()
        clipsToBounds = true
        addSubview(cellView)
        cellView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailling: trailingAnchor)



        addCircleProgressBar(progressBar: circularProgressBar, position: CGPoint(x: 60.0, y: 60.0), radius: 40, lineWidth: 15, fillColor: UIColor.clear.cgColor, strokeColor: UIColor(hexString: "FEE433").cgColor, trackColor: UIColor(hexString: "DFDFDF").cgColor, subViewOf: cellView)

        addSubview(percentLabel)
        percentLabel.fillSuperView()
    }
    
}
