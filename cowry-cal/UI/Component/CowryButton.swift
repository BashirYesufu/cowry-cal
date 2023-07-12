//
//  CowryButton.swift
//  cowry-cal
//
//  Created by Bash on 12/07/2023.
//

import UIKit

class CowryButton: UIView {
    
    @IBInspectable
    var title: String = ""

    @IBInspectable
    var isEnabled: Bool = true

    @IBInspectable
    var color: UIColor = R.color.cowryGreen()!

    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }

    lazy var label: UILabel = {
        let label = UILabel()
        label.text = title
        label.font = R.font.montserratAlternatesMedium(size: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private func setupViews(){
        self.addSubview(label)
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.backgroundColor = color
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.isUserInteractionEnabled = isEnabled
        self.layer.cornerRadius = 15
    }
}
