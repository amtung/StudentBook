//
//  TourCell.swift
//  C4QStudentBook
//
//  Created by Annie Tung on 11/18/16.
//  Copyright © 2016 Jason Wang. All rights reserved.
//

import UIKit

class TourCell: BaseCell {
    
    static let identifier = "tourCellID"
    
    // add imageview & textview
    
    // making the image Object
    let imageView: UIImageView = {
        let image = UIImage(named: "c4q_logo")
        let iv = UIImageView(image: image)
        iv.contentMode = .scaleAspectFill // fill the whole view
        iv.clipsToBounds = true // so the image doesn't take all the bounds of the image view
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }() // () executes above block of code
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "Jason is awesome!!!"
        tv.isSelectable = false
        tv.isEditable = false
        tv.backgroundColor = .white
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    var tour: Tour? {
        didSet {
            guard let tourData = tour else { return }
            setup(tour: tourData) // holds the information on tour and displaying on the cell instead of the collectionView
        }
    }
    
    override func setupCell() {
        super.setupCell()
        
        addSubview(imageView) // add the UI!
        addSubview(textView)
        
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: CGFloat(0.6)).isActive = true
        
        textView.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        textView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: CGFloat(0.25)).isActive = true
    }
    
    private func setup(tour: Tour) {
        imageView.image = UIImage(named: tour.imageString)
        
        let attributedString = NSMutableAttributedString(string: tour.title, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium)])
        let descriptionAttribute = NSMutableAttributedString(string: "\n\n" + tour.description, attributes: [NSForegroundColorAttributeName:UIColor.lightGray, NSFontAttributeName:UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)])
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let textLength = attributedString.string.characters.count
        let range = NSRange(location: 0, length: textLength)
        
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: range)
        
        attributedString.append(descriptionAttribute)
        textView.attributedText = attributedString
    }
    
    
    
    
}
