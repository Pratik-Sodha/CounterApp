//
//  InteractionController.swift
//  CounterApp
//
//  Created by APPLE on 24/01/21.
//

import UIKit
import RxSwift
import RxCocoa

class InteractionController: UIViewController {

    //-----------------------------------------------------
    //MARK: - IBOutlets
    @IBOutlet weak var lblCounter : UILabel!
    
    @IBOutlet weak var btnPlus    : RoundButton!
    @IBOutlet weak var btnRefresh : RoundButton!
    @IBOutlet weak var btnMinus   : RoundButton!
    
    @IBOutlet weak var btnAutoIncrement : UISwitch!
    
    //-----------------------------------------------------
    //MARK: - Properties
    private let disposeBag = DisposeBag()
    private let intent = InteractionIntent()
    
    //-----------------------------------------------------
    //MARK: - Custom Methods
    
    private func setup() {
        bindButtons()
        intent.bind(toView: self)
    }
    
    private func bindButtons() {
        btnPlus.rx.tap.bind {
            self.intent.onPlusClicked()
        }.disposed(by: disposeBag)
        
        btnMinus.rx.tap.bind {
            self.intent.onMinusClicked()
        }.disposed(by: disposeBag)
        
        btnRefresh.rx.tap.bind {
            self.intent.onRefreshClicked()
        }.disposed(by: disposeBag)
        
        btnAutoIncrement.rx.controlEvent([.valueChanged]).subscribe{ inOn in
            self.intent.onToggelAutoIncrement()
        }.disposed(by: disposeBag)
    }
    
    func update(withState state: InteractionState) {
        
        switch state {
        case is Counter:
            let counter = state as! Counter
            lblCounter.text = "\(counter.value)"
            btnAutoIncrement.isOn = counter.isAutoIncrement
        default:
            debugPrint("Need to handle case")
            break
        }

    }

    //-----------------------------------------------------
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    

}
