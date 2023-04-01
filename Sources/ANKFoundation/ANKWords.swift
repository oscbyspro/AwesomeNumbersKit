//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Words
//*============================================================================*

/// A collection of a binary integer's words.
public protocol ANKWords: RandomAccessCollection where Element == UInt, Index == Int { }

//*============================================================================*
// MARK: * ANK x Words x Swift
//*============================================================================*

extension Array<UInt>: ANKWords { }
extension ContiguousArray<UInt>: ANKWords { }
extension UnsafeBufferPointer<UInt>: ANKWords { }
extension UnsafeMutableBufferPointer<UInt>: ANKWords { }

extension ArraySlice: ANKWords where Element == UInt, Index == Int { }
extension Slice: ANKWords where Base: RandomAccessCollection, Element == UInt, Index == Int { }
