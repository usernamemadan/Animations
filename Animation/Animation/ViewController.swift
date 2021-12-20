//
//  ViewController.swift
//  Animation
//
//  Created by Madan AR on 19/12/21.
//

import UIKit

class ViewController: UIViewController {

    var squareConstraint: NSLayoutConstraint!
    var rectangleHeightConstraint: NSLayoutConstraint!
    var rectangleWidthConstraint: NSLayoutConstraint!
    
    lazy var square: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange
        let tap = UITapGestureRecognizer(target: self, action: #selector(animateSquare))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var rectangle: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        let tap = UITapGestureRecognizer(target: self, action: #selector(animateRectangle))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var fadingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemTeal
        let tap = UITapGestureRecognizer(target: self, action: #selector(animateFading))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemYellow
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(shakeButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        configureSquare()
        configureRectangle()
        configureFadingView()
        configureButton()
    }

    func configureSquare() {
        view.addSubview(square)
        square.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 170).isActive = true
        square.widthAnchor.constraint(equalToConstant: 100).isActive = true
        square.heightAnchor.constraint(equalToConstant: 100).isActive = true
        squareConstraint = square.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10)
        squareConstraint.isActive = true
        
    }
    
    func configureRectangle() {
        view.addSubview(rectangle)
        rectangle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rectangleWidthConstraint = rectangle.widthAnchor.constraint(equalToConstant: 100)
        rectangleHeightConstraint = rectangle.heightAnchor.constraint(equalToConstant: 100)
        rectangleWidthConstraint.isActive = true
        rectangleHeightConstraint.isActive = true
        
    }
    
    func configureFadingView() {
        view.addSubview(fadingView)
        fadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        fadingView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        fadingView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func configureButton() {
        view.addSubview(button)
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func animateSquare() {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn) {
            self.squareConstraint.constant = 250
            self.square.transform = .init(rotationAngle: .pi/2 )
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.squareConstraint.constant = 10
        }
    }

    @objc func animateRectangle() {
        UIView.animate(withDuration: 3, delay: 0.05, options: .curveLinear) {
            self.rectangleWidthConstraint.constant = self.view.frame.width
            self.rectangleHeightConstraint.constant = self.view.frame.height
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.rectangleWidthConstraint.constant = 100
            self.rectangleHeightConstraint.constant = 100
           
        }
    }
    
    @objc func animateFading() {
        UIView.transition(with: fadingView, duration: 3, options: .transitionFlipFromRight) {
            self.fadingView.alpha = 0.1
        } completion: { _ in
            self.fadingView.alpha = 1
        }
    }
    
    @objc func shakeButton() {
        button.shake()
    }
    
    
    
}

extension UIButton {
    func shake(){
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.2
        shake.repeatCount = 4
        shake.autoreverses = true
        
        let formPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: formPoint)
        shake.fromValue = fromValue
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        shake.toValue = toValue
        layer.add(shake, forKey: nil)
    }
}

