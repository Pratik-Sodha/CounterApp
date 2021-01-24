//
//  InteractionIntent.swift
//  CounterApp
//
//  Created by APPLE on 24/01/21.
//

import Foundation
import RxSwift
import RxCocoa

class InteractionIntent {
    
    private let disposeBag = DisposeBag()
    private var view : InteractionController?
    private let stateRelay : BehaviorRelay<Counter>
    private let isRunning : BehaviorRelay<Bool>
    
    init() {
        stateRelay = BehaviorRelay(value: Counter())
        isRunning = BehaviorRelay(value: stateRelay.value.isAutoIncrement)
    }
    
    
    func bind(toView view : InteractionController?) {
        self.view = view
        
        stateRelay.subscribe { event in
            guard let element = event.element else { return }
            self.view?.update(withState: element)
        }.disposed(by: disposeBag)
        
        isRunning.asObservable()
            .flatMapLatest{ isRunning in
                isRunning ? Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.asyncInstance) : .empty()
            }.map{ second -> Int in
                self.onPlusClicked()
                return second
            }
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    //-----------------------------------------------------
    //MARK: -
    func onPlusClicked() {
        stateRelay.value.increment()
        stateRelay.accept(stateRelay.value)
    }
    
    func onMinusClicked() {
        stateRelay.value.decrement()
        stateRelay.accept(stateRelay.value)
    }
    
    func onRefreshClicked() {
        stateRelay.value.reset()
        stateRelay.accept(stateRelay.value)
    }
    
    func onToggelAutoIncrement() {
        stateRelay.value.toggelAutoIncrement()
        isRunning.accept(stateRelay.value.isAutoIncrement)
    }
}
