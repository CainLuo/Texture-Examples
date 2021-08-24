//
//  NSObject+ListDiffable.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/8/24.
//

import Foundation
import IGListKit

// MARK: - ListDiffable
extension NSObject: ListDiffable {
  public func diffIdentifier() -> NSObjectProtocol {
    return self
  }

  public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    return isEqual(object)
  }
}
