//
// Copyright (c) 2020 Eureka, Inc.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

public struct BookSection: BookView {

  public let title: String
  public let content: BookView

  public init(
    title: String,
    @ComponentBuilder content: () -> BookView
  ) {
    self.title = title
    self.content = content()

  }

  public var body: BookView {
    BookGroup {
      BookSpacer(height: 8)
      BookText(title)
        .font(.systemFont(ofSize: 24, weight: .bold))
      BookSpacer(height: 16)
      content
      BookSpacer(height: 24)
    }
  }

}

public struct BookAlphabeticalNavigationLinkSection: BookView {

  public let title: String
  public let content: BookView

  public init(
    title: String,
    @AlphabeticalNavigationLinkBuilder content: () -> BookView
  ) {
    self.title = title
    self.content = content()
  }

  public var body: BookView {
    BookGroup {
      BookSpacer(height: 8)
      BookText(title)
        .font(.systemFont(ofSize: 24, weight: .bold))
      BookSpacer(height: 16)
      content
      BookSpacer(height: 24)
    }
  }

}
