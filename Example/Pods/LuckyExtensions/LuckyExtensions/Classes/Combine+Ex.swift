//
//  Combine+Ex.swift
//  LuckyExtensions
//
//  Created by junky on 2024/2/23.
//

import Foundation
import Combine

public extension Publisher {
    
    func sinkOnMainQueue(receiveCompletion: @escaping ((Subscribers.Completion<Self.Failure>) -> Void), receiveValue: @escaping ((Output) -> Void)) -> Cancellable {
        receive(on: DispatchQueue.main).sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)
    }
    
    func link(_ to: any Subject<Output, Failure>) -> AnyCancellable {
        sink(receiveCompletion: to.send(completion:), receiveValue: to.send(_:))
    }
}


public extension Publisher where Failure == Never {
    
    func sinkOnMain(receiveValue: @escaping ((Self.Output) -> Void)) -> AnyCancellable {
        receive(on: DispatchQueue.main).sink(receiveValue: receiveValue)
    }
    
    func link(_ to: any Subject<Self.Output, Self.Failure>) -> AnyCancellable {
        sink(receiveValue: to.send(_:))
    }
}



public extension Publishers {
    
    class UIControlSubscription<S: Subscriber, C: UIControl>: Subscription where S.Input == C, S.Failure == Never {
        
        private var subscriber: S?
        private var control: C
        private var events: C.Event
        
        init(subscriber: S?, control: C, events: C.Event) {
            self.subscriber = subscriber
            self.control = control
            self.events = events
            configControl()
        }
        
        deinit {
            print("UIControllSubscription -deinit")
        }
        
        func configControl() {
            self.control.addTarget(self, action: #selector(eventHandler), for: self.events)
        }
        
        @objc func eventHandler() {
            _ = self.subscriber?.receive(self.control)
        }
        
        public func request(_ demand: Subscribers.Demand) {
            
        }
        
        /// Step 3 ： 销毁
        public func cancel() {
            // 销毁订阅者
            subscriber = nil
        }
        
    }
    
    struct UIControlPublisher<C: UIControl>: Publisher {
        
        public typealias Output = UIControl
        public typealias Failure = Never
        
        private var control: C
        private var events: C.Event
        
        init(control: C, events: UIControl.Event) {
            self.control = control
            self.events = events
        }
        
        
        public func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, UIControl == S.Input {
            let subscription = UIControlSubscription(subscriber: subscriber, control: control, events: events)
            subscriber.receive(subscription: subscription)
        }
    }
    
    
}

public extension UIControl {
    
    func publisher(events: UIControl.Event) -> Publishers.UIControlPublisher<UIControl> {
        return Publishers.UIControlPublisher(control: self, events: events)
    }
}






@propertyWrapper
public struct CurrentValueSubjectProperty<T> {
    
    public var wrappedValue: T {
        set {
            value = newValue
        }
        get {
            value
        }
    }
    
    public var projectedValue: CurrentValueSubject<T, Never>
    
    private var value: T {
        didSet {
            projectedValue.send(value)
        }
    }
    
    public init(wrappedValue: T) {
        self.value = wrappedValue
        self.projectedValue = CurrentValueSubject<T, Never>(wrappedValue)
    }
    
}



@propertyWrapper
public struct PassthroughSubjectProperty<T> {
    
    public var wrappedValue: T {
        set {
            value = newValue
        }
        get {
            value
        }
    }

    public var projectedValue: PassthroughSubject<T, Never>
    
    var value: T {
        didSet {
            projectedValue.send(value)
        }
    }
    
    
    public init(wrappedValue: T) {
        self.value = wrappedValue
        self.projectedValue = PassthroughSubject<T, Never>()
    }
}



