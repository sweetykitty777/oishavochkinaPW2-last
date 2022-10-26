//
//  ViewController.swift
//  oishavochkinaPW2
//
//  Created by Olga on 10.10.2022.

import UIKit

class ViewController: UIViewController {
    private let commentLabel = UILabel()
    private let valueLabel = UILabel()
    private var value: Int = 0
    private let incrementButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    private func setupIncrementButton() {
        incrementButton.setTitle("Increment", for: .normal)
        incrementButton.setTitleColor(.black, for: .normal)
        incrementButton.layer.cornerRadius = 12
        incrementButton.titleLabel?.font = .systemFont(ofSize:
                                                        16.0, weight: .medium)
        incrementButton.backgroundColor = .white
        incrementButton.layer.applyShadow()
        self.view.addSubview(incrementButton)
        incrementButton.setHeight(48)
        incrementButton.pinTop(to: self.view.centerYAnchor)
        incrementButton.pinLeft(to: self.view, 24)
        incrementButton.pinRight(to: self.view, 24)
        incrementButton.addTarget(self, action:
                                    #selector(incrementButtonPressed), for: .touchUpInside)
    }
    private func setupValueLabel() {
        valueLabel.font = .systemFont(ofSize: 40.0,
                                      weight: .bold)
        valueLabel.textColor = .black
        valueLabel.text = "\(value)"
        self.view.addSubview(valueLabel)
        valueLabel.pinBottom(to: incrementButton.topAnchor, 16)
        valueLabel.pinCenter(to: self.view.centerXAnchor)
    }
    private func setupView() {
        view.backgroundColor = .systemGray6
        setupIncrementButton()
        setupValueLabel()
        setupCommentView()
        setupMenuButtons()
    }
    @objc
    private func incrementButtonPressed() {
        value += 1
        updateUI()
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        UIView.animate(withDuration: 1.0, delay: 0.0,
                       options: .curveEaseOut,
                       animations: {
            self.commentLabel.alpha = 0.2
        },
                       completion: nil
        )
        UIView.animate(withDuration: 1.0, delay: 0.0,
                       options: .curveEaseOut,
                       animations: {
            self.commentLabel.alpha = 1
        },
                       completion: nil
        )
        updateUI()
    }
    private func updateUI(){
        setupValueLabel()
        updateCommentLabel(value: value)
    }
    private func setupCommentView() -> UIView {
        let commentView = UIView()
        commentView.backgroundColor = .white
        commentView.layer.cornerRadius = 12
        view.addSubview(commentView)
        commentView.pinTop(to:
                            self.view.safeAreaLayoutGuide.topAnchor)
        commentView.pinLeft(to: self.view, 24)
        commentView.pinRight(to: self.view, 24)
        commentLabel.font = .systemFont(ofSize: 14.0,
                                        weight: .regular)
        commentLabel.textColor = .systemGray
        commentLabel.numberOfLines = 0
        commentLabel.textAlignment = .center
        commentView.addSubview(commentLabel)
        commentLabel.pinTop(to: commentView, 16)
        commentLabel.pinLeft(to: commentView, 16)
        commentLabel.pinBottom(to: commentView, 16)
        commentLabel.pinRight(to: commentView, 16)
        return commentView
    }
    @objc
    private func pressAnimation(sender:UIButton) {
        UIView.animate(withDuration: 0.09, animations: {
            sender.layer.applyShadowPressed()
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) {
            complition in
            UIView.animate(withDuration: 0.09, animations: {
                sender.layer.applyShadow()
                sender.transform = CGAffineTransform.identity
            })
        }
        
    }
    
    
    func updateCommentLabel(value: Int) {
        switch value {
        case 0...10:
            commentLabel.text = "1"
        case 10...20:
            commentLabel.text = "2"
        case 20...30:
            commentLabel.text = "3"
        case 30...40:
            commentLabel.text = "4"
        case 40...50:
            commentLabel.text = "! ! ! ! ! ! ! ! ! "
        case 50...60:
            commentLabel.text = "big boy"
        case 60...70:
            commentLabel.text = "70 70 70 moreeeee"
        case 70...80:
            commentLabel.text = "⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ "
        case 80...90:
            commentLabel.text = "80+\n go higher!"
        case 90...100:
            commentLabel.text = "100!! to the moon!!"
        default:
            break
        }
    }
    private func makeMenuButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 16.0,
                                              weight: .medium)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalTo:
                                        button.widthAnchor).isActive = true
        return button
    }
    private func setupMenuButtons() {
        let colorsButton = makeMenuButton(title: "🎨")
        let notesButton = makeMenuButton(title: "📝")
        let newsButton = makeMenuButton(title: "📰")
        let buttonsSV = UIStackView(arrangedSubviews:
                                        [colorsButton, notesButton, newsButton])
        buttonsSV.spacing = 12
        buttonsSV.axis = .horizontal
        buttonsSV.distribution = .fillEqually
        self.view.addSubview(buttonsSV)
        buttonsSV.pinLeft(to: self.view, 24)
        buttonsSV.pinRight(to: self.view, 24)
        //  buttonsSV.pin(to: self.view, [.left: 24, .right: 24])
        buttonsSV.pinBottom(to:
                                self.view.safeAreaLayoutGuide.bottomAnchor, 24)
    }
}

extension CALayer{
    func applyShadow() {
        self.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.shadowOffset = CGSize(width: 0, height: 3)
        self.shadowOpacity = 1.0
        self.shadowRadius = 10.0
        self.masksToBounds = false
    }
    
    func applyShadowPressed() {
        self.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        self.shadowOffset = CGSize(width: 0, height: 3)
        self.shadowOpacity = 1.0
        self.shadowRadius = 5.0
        self.masksToBounds = false
    }
}
extension UIView {
    enum PinSide {
        case top, bottom, left, right
    }
    
    func pin(to superview: UIView, _ sides: [PinSide]) {
        for side in sides {
            switch side {
            case .top:
                pinTop(to: superview)
            case .bottom:
                pinBottom(to: superview)
            case .left:
                pinLeft(to: superview)
            case .right:
                pinRight(to: superview)
            }
        }
    }
    @discardableResult
    func pinCenter(
        to xAnchor: NSLayoutXAxisAnchor,
        _ const: Double = 0
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = centerXAnchor.constraint(
            equalTo: xAnchor,
            constant: CGFloat(const)
        )
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func pinLeft(to superview: UIView, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = leadingAnchor.constraint(
            equalTo: superview.leadingAnchor,
            constant: CGFloat(const)
        )
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func pinLeft(to side: NSLayoutXAxisAnchor, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = leadingAnchor.constraint(
            equalTo: side,
            constant: CGFloat(const)
        )
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func pinRight(to superview: UIView, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = trailingAnchor.constraint(
            equalTo: superview.trailingAnchor,
            constant: CGFloat(const * -1)
        )
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func pinRight(to side: NSLayoutXAxisAnchor, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = trailingAnchor.constraint(
            equalTo: side,
            constant: CGFloat(const * -1)
        )
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func pinTop(to superview: UIView, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = topAnchor.constraint(
            equalTo: superview.topAnchor,
            constant: CGFloat(const)
        )
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func pinTop(to side: NSLayoutYAxisAnchor, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = topAnchor.constraint(
            equalTo: side,
            constant: CGFloat(const)
        )
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func pinBottom(to superview: UIView, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = bottomAnchor.constraint(
            equalTo: superview.bottomAnchor,
            constant: CGFloat(const * -1)
        )
        constraint.isActive = true
        
        return constraint
    }
    func pinBottom(
        to anchor: NSLayoutYAxisAnchor,
        _ const: Double = 0
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = bottomAnchor.constraint(
            equalTo: anchor,
            constant: -CGFloat(const)
        )
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func pinButton(to side: NSLayoutYAxisAnchor, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = bottomAnchor.constraint(
            equalTo: side,
            constant: CGFloat(const * -1)
        )
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func pinCenterX(to superview: UIView, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = centerXAnchor.constraint(
            equalTo: superview.centerXAnchor,
            constant: CGFloat(const)
        )
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func pinCenterX(to center: NSLayoutXAxisAnchor, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = centerXAnchor.constraint(
            equalTo: center,
            constant: CGFloat(const)
        )
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func pinCenterY(to superview: UIView, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = centerYAnchor.constraint(
            equalTo: superview.centerYAnchor,
            constant: CGFloat(const)
        )
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func pinCenterY(to center: NSLayoutYAxisAnchor, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = centerYAnchor.constraint(
            equalTo: center,
            constant: CGFloat(const)
        )
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func pinWidth(to superview: UIView, _ mult: Double = 1) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = widthAnchor.constraint(
            equalTo: superview.widthAnchor,
            constant: CGFloat(mult)
        )
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func pinWidth(to size: NSLayoutDimension, _ mult: Double = 1) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = widthAnchor.constraint(
            equalTo: size,
            constant: CGFloat(mult)
        )
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func pinHeight(to superview: UIView, _ mult: Double = 1) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = centerYAnchor.constraint(
            equalTo: superview.centerYAnchor,
            constant: CGFloat(mult)
        )
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func pinHeight(to size: NSLayoutDimension, _ mult: Double = 1) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = heightAnchor.constraint(
            equalTo: size,
            constant: CGFloat(mult)
        )
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func setHeight(_ const: Int) -> NSLayoutConstraint {
        let constraint = heightAnchor.constraint(equalToConstant: CGFloat(const))
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func setWidth(_ const: Int) -> NSLayoutConstraint {
        let constraint = widthAnchor.constraint(equalToConstant: CGFloat(const))
        constraint.isActive = true
        return constraint
    }
    
    func pinCenter(to superview: UIView) {
        pinCenterX(to: superview)
        pinCenterY(to: superview)
    }
}
