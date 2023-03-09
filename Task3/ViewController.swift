//
//  ViewController.swift
//  Task3
//
//  Created by Александр Лимарев on 07.03.2023.
//

import UIKit

class ViewController: UIViewController {
    var squareView: UIView!
    var slider: UISlider!
    let squareSize: CGFloat = 100
    let animationDuration: TimeInterval = 0.3
    let maxScale: CGFloat = 1.5
    let maxRotation: CGFloat = .pi / 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        setupSquareView()
        setupSlider()
    }
    
    func setupSquareView() {
        let topInset = view.safeAreaInsets.top + 100.0
        squareView = UIView(frame: CGRect(x: view.layoutMargins.left, y: topInset, width: squareSize, height: squareSize))
        squareView.backgroundColor = .blue
        squareView.layer.cornerRadius = 10.0
        view.addSubview(squareView)
    }
    
    
    func setupSlider() {
        slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderReleased), for: .touchUpInside)
        view.addSubview(slider)
        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            slider.topAnchor.constraint(equalTo: squareView.bottomAnchor, constant: 40)
        ])
    }
    
    
    @objc func sliderChanged(_ sender: UISlider) {
        let x = sender.value * Float(view.bounds.width - view.layoutMargins.left - view.layoutMargins.right - squareSize) - 20
        let scale = 1 + CGFloat(sender.value) * (maxScale - 1)
        let rotation = CGFloat(sender.value) * maxRotation
        UIView.animate(withDuration: animationDuration) {
            self.squareView.transform = CGAffineTransform(translationX: CGFloat(x), y: 0)
                .scaledBy(x: scale, y: scale)
                .rotated(by: rotation)
        }
    }
    
    @objc func sliderReleased(_ sender: UISlider) {
        sender.setValue(1, animated: true)
        sliderChanged(sender)
    }
}
