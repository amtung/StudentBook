//
//  BaseCell.swift
//  C4QStudentBook
//
//  Created by Annie Tung on 11/18/16.
//  Copyright © 2016 Jason Wang. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) { // when we dequeue a cell at cellForItemAt, this will always be called
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupCell() {
        // what our cell will look like
    }
}
