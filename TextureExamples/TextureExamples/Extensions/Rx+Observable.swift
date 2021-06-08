//
//  Rx+Observable.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/6/8.
//

import RxSwift
import RxCocoa

protocol OptionalType {
    associatedtype Wrapped

    var value: Wrapped? { get }
}

extension Optional: OptionalType {
    var value: Wrapped? {
        self
    }
}

extension Observable where Element: OptionalType {
    func filterNil() -> Observable<Element.Wrapped> {
        flatMap { (element) -> Observable<Element.Wrapped> in
            if let value: Element.Wrapped = element.value {
                return .just(value)
            } else {
                return .empty()
            }
        }
    }

    func filterNilKeepOptional() -> Observable<Element> {
        self.filter { (element) -> Bool in
            element.value != nil
        }
    }

    func replaceNil(with nilValue: Element.Wrapped) -> Observable<Element.Wrapped> {
        flatMap { (element) -> Observable<Element.Wrapped> in
            if let value: Element.Wrapped = element.value {
                return .just(value)
            } else {
                return .just(nilValue)
            }
        }
    }
}

extension Single where Element: OptionalType {
    func filterNil() -> Single<Element.Wrapped> {
        self.asObservable().flatMap { (element) -> Observable<Element.Wrapped> in
            if let value: Element.Wrapped = element.value {
                return .just(value)
            } else {
                return .empty()
            }
        }.asSingle()
    }
}

extension ObservableType {

    func catchErrorJustComplete() -> Observable<Element> {
        catchError { _ in
            Observable.empty()
        }
    }

    func asDriverOnErrorJustComplete() -> Driver<Element> {
        asDriver { _ in
            Driver.empty()
        }
    }

    func mapToVoid() -> Observable<Void> {
        map { _ in }
    }
}

