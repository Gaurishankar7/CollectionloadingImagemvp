//
//  Cell.swift
//  TestM
//
//  Created by GS on 03/08/20.
//  Copyright © 2020 Gaurishankar Vibhute. All rights reserved.
//

import UIKit

class Cell: UICollectionViewCell {

    static var identifier: String = "Cell"

    var imageView: UIImageView?
    var label: UILabel?


    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView = UIImageView(frame: self.bounds)
        imageView?.backgroundColor = UIColor.white
        imageView?.image = UIImage(named: "loading.png")
        contentView.addSubview(imageView!)
        label = UILabel(frame: CGRect(x: 10, y: (imageView?.frame.maxX)! + 20, width: self.bounds.width - 20, height: 20))
        label?.text = "Hello"
        label?.textColor = UIColor.black
        label?.backgroundColor = .white
        contentView.addSubview(label!)
         self.reset()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    

    func reset() {
        label?.textAlignment = .center
    }
}
