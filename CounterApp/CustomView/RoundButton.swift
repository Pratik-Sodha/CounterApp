//
//  RoundButton.swift
//  CounterApp
//
//  Created by APPLE on 24/01/21.
//

import UIKit

class RoundButton: UIButton {

    //-----------------------------------------------------
    //MARK: - Init
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = UIColor.supportiveThemeColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height / 2
    }
}
