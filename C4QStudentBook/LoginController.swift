//
//  LoginController.swift
//  C4QStudentBook
//
//  Created by Annie Tung on 11/18/16.
//  Copyright © 2016 Jason Wang. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = { // gives you access to main VC, only will be accessed once and won't be re-instantiated
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false // if we are using auto layout
        cv.backgroundColor = .white
        cv.isPagingEnabled = true
        cv.bounces = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    lazy var pageController: UIPageControl = {
        let pc = UIPageControl()
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = .orange
        pc.numberOfPages = self.tourData.count +  1
        return pc
    }()
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupTourData()
        setupPageController()
        setupNextSkipButton()
        setupKeyboardNotification()
    }
    
    // MARK: - Variables
    var tourData = [Tour]()
    var pageControllerBottomAnchor: NSLayoutConstraint? // so we can access from other functions
    var nextButtonBottomAnchor: NSLayoutConstraint?
    var skipButtonBottomAnchor: NSLayoutConstraint?
    
    // MARK: - Buttons
    lazy var nextButton: UIButton = {
        let nb = UIButton(type: .system) // shows lightlight
        nb.translatesAutoresizingMaskIntoConstraints = false
        nb.setTitle("Next", for: .normal)
        nb.backgroundColor = UIColor(red: 0.3725, green: 0.8784, blue: 0.0588, alpha: 1)
        nb.setTitleColor(.white, for: .normal)
        nb.layer.cornerRadius = 15
        nb.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return nb
    }()
    
    let skipButton: UIButton = {
        let sb = UIButton(type: .system)
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.setTitle("Skip", for: .normal)
        sb.backgroundColor = .lightGray
        sb.setTitleColor(.white, for: .normal)
        sb.layer.cornerRadius = 15
        sb.alpha = 0.5
        return sb
    }()
    
    // MARK: - Method
    func handleNext() {
        if pageController.currentPage == tourData.count {
            return
        }
        let nextPage = pageController.currentPage + 1 // 1 = 0 + 1 Int is a struct
        let nextIndexPath = IndexPath(item: nextPage, section: 0) // we only have one section
        collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true) // at which index path we are scrolling into, centerHorizontally will snap the cell into the center
        pageController.currentPage = nextPage
    }
    
    // HANDLESKIP 2 buttons of code
    
    func setupKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    lazy var yValue: CGFloat = {
        return self.view.frame.origin.y
    }()
    
    func keyboardShow() {
        print("keyboardShow")
        view.frame = CGRect(x: view.frame.origin.x, y: yValue - 20, width: view.frame.size.width, height: view.frame.size.height)
    }
    func keyboardHide() {
        print("keyboardHide")
        view.frame = CGRect(x: view.frame.origin.x, y: yValue, width: view.frame.size.width, height: view.frame.size.height)
    }
    
    func setupNextSkipButton() {
        view.addSubview(nextButton)
        view.addSubview(skipButton)
        let buttonWidth = (view.bounds.size.width / 2) - 10
        nextButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nextButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        nextButtonBottomAnchor = nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        nextButtonBottomAnchor?.isActive = true
        
        skipButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        skipButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        skipButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        skipButtonBottomAnchor = skipButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        skipButtonBottomAnchor?.isActive = true
    }
    
    func setupPageController() {
        collectionView.addSubview(pageController)
        pageControllerBottomAnchor = pageController.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        pageControllerBottomAnchor?.isActive = true
        pageController.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        pageController.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 8).isActive = true
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(TourCell.self, forCellWithReuseIdentifier: TourCell.identifier)
        collectionView.register(LoginCell.self, forCellWithReuseIdentifier: LoginCell.identifier)
        
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupTourData() {
        let tourPageOne = Tour(imageStr: "c4q4", titleString: "ABOUT US", descriptionString: "We foster the Queens tech ecosystem to increase economic opportunity and transform the world's most diverse community into a leading hub for innovation and entrepreneurship.")
        let tourPageTwo = Tour(imageStr: "c4q3", titleString: "Our Mission", descriptionString: "Coalition for Queens (C4Q) increases economic opportunity through technology and transforms the world's most diverse community into a leading hub for innovation and entrepreneurship.")
        let tourPageThree = Tour(imageStr: "c4q2", titleString: "What is Access Code?", descriptionString: "Access Code is a 10-month software development program that trains talented adults from underserved populations to become industry ready programmers and helps get them tech jobs at leading companies.")
        tourData = [tourPageOne, tourPageTwo, tourPageThree]
        
    }
    
    // MARK: - Collection View Cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tourData.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == tourData.count {
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: LoginCell.identifier, for: indexPath) as! LoginCell
            return loginCell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TourCell.identifier, for: indexPath) as! TourCell
        cell.tour = tourData[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // currentPage = xValue of where your screen starts at 375 / view.frame.width 375
        print(targetContentOffset.pointee.x) // which point we are at
        let currentPage = Int(targetContentOffset.pointee.x / view.frame.width) // total length
        pageController.currentPage = currentPage
        //var alphaLvl: CGFloat = 1
        if currentPage == tourData.count { // currentPage is index so we are at the last page
            pageControllerBottomAnchor?.constant = 40
            nextButtonBottomAnchor?.constant = 90
            skipButtonBottomAnchor?.constant = 90
            //alphaLvl = 0
        } else {
            pageControllerBottomAnchor?.constant = 0
            nextButtonBottomAnchor?.constant = -40
            skipButtonBottomAnchor?.constant = -40
        }
        //        UIView.animate(withDuration: 0.5) {
        //            self.view.layoutIfNeeded()
        //        }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true) // keypad dismisses
    }
    
    
    
    
    
}
