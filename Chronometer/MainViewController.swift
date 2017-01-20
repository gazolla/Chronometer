//
//  MainViewController.swift
//  Chronometer
//
//  Created by Gazolla on 20/01/17.
//  Copyright © 2017 Gazolla. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let chrono = Chronometer()
    
    lazy var chronoLabel:UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 80)
        l.textColor = UIColor.black
        l.backgroundColor = UIColor.clear
        l.text = "00:00:00"
        return l
    }()
    
    lazy var btn:UIButton = {
        let b = UIButton()
        b.backgroundColor = UIColor.blue
        b.layer.cornerRadius = 5
        b.setTitle("start", for: UIControlState())
        b.titleLabel!.font =  UIFont(name: "HelveticaNeue-CondensedBlack" , size: 35)
        b.addTarget(target, action: #selector(MainViewController.btnTapped(_:)), for: UIControlEvents.touchUpInside)
        b.heightAnchor.constraint(equalToConstant: 80).isActive = true
        b.widthAnchor.constraint(equalToConstant: 240).isActive = true
        return b
    }()
    
    lazy var stack:UIStackView = {
        let s = UIStackView(frame: self.view.bounds)
        s.axis = .vertical
        s.alignment = .center
        s.distribution = .fillProportionally
        s.spacing = 10
        s.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        s.addArrangedSubview(UIView())
        s.addArrangedSubview(self.chronoLabel)
        s.addArrangedSubview(self.btn)
        s.addArrangedSubview(UIView())
        return s
    }()
    
    func btnTapped(_ sender:UIButton){
        if chrono.isRunning {
            btn.setTitle("start", for: UIControlState())
            chrono.stop()
        } else {
            btn.setTitle("stop", for: UIControlState())
            chrono.start()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.stack)
        chrono.update = { (time:Time) in
            DispatchQueue.main.async {
                self.chronoLabel.text = "\(time)"
            }
        }
    }
}
