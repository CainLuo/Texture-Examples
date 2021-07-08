//
//  LayoutsViewModel.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/7.
//

import Foundation
import RxSwift
import RxCocoa
import AsyncDisplayKit

protocol LayoutsViewModelInputs {
    var viewWillAppear: AnyObserver<Void> { get }
}

protocol LayoutsViewModelOutputs {
    var sections: Driver<[LayoutsSectionModel]> { get }
}

protocol LayoutsViewModelTypes {
    var inputs: LayoutsViewModelInputs { get }
    var outputs: LayoutsViewModelOutputs { get }
}

class LayoutsViewModel: LayoutsViewModelInputs, LayoutsViewModelOutputs, LayoutsViewModelTypes {
    
    init() {
        let sections = viewWillAppearSubject.map(filterSections)

        // inputs
        self.viewWillAppear = viewWillAppearSubject.asObserver()
        
        // outputs
        self.sections = sections.asDriverOnErrorJustComplete()
    }
    
    // MARK: subjects
    let viewWillAppearSubject = PublishSubject<Void>()
    
    // MARK: inputs
    let viewWillAppear: AnyObserver<Void>

    // MARK: outputs
    let sections: Driver<[LayoutsSectionModel]>

    var inputs: LayoutsViewModelInputs { self }
    var outputs: LayoutsViewModelOutputs { self }
}

private func filterSections() -> [LayoutsSectionModel] {
    [
        LayoutsSectionModel(title: "ASStackLayoutSpec", type: .original, items: originalItems()),
        LayoutsSectionModel(title: "TextureSwiftSupportLayoutSpec", type: .textureSwiftSupport, items: textureSwiftSupportItems())
    ]
}

private func originalItems() -> [LayoutsItemModel] {
    [
        LayoutsItemModel(title: "ASWrapperLayoutSpec", type: .wrapper),
        LayoutsItemModel(title: "ASStackLayoutSpec", type: .stack),
        LayoutsItemModel(title: "ASInsetLayoutSpec", type: .inset),
        LayoutsItemModel(title: "ASOverlayLayoutSpec", type: .overlay),
        LayoutsItemModel(title: "ASBackgroundLayoutSpec", type: .background),
        LayoutsItemModel(title: "ASCenterLayoutSpec", type: .center),
        LayoutsItemModel(title: "ASRatioLayoutSpec", type: .ratio),
        LayoutsItemModel(title: "ASRelativeLayoutSpec", type: .relative),
        LayoutsItemModel(title: "ASAbsoluteLayoutSpec", type: .absolute),
        LayoutsItemModel(title: "ASCornerLayoutSpec", type: .corner)
    ]
}

private func textureSwiftSupportItems() -> [LayoutsItemModel] {
    [
        LayoutsItemModel(title: "WrapperLayout", type: .wrapper),
        LayoutsItemModel(title: "StackLayout", type: .stack),
        LayoutsItemModel(title: "InsetLayout", type: .inset),
        LayoutsItemModel(title: "OverlayLayout", type: .overlay),
        LayoutsItemModel(title: "BackgroundLayout", type: .background),
        LayoutsItemModel(title: "CenterLayout", type: .center),
        LayoutsItemModel(title: "RatioLayout", type: .ratio),
        LayoutsItemModel(title: "RelativeLayout", type: .relative),
        LayoutsItemModel(title: "AbsoluteLayout", type: .absolute),
        LayoutsItemModel(title: "ASCornerLayoutSpec", type: .corner)
    ]
}
