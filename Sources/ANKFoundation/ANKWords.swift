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

/// A collection of `UInt` words, with indices from `0` to `count`.
public protocol ANKWords: RandomAccessCollection where Element == UInt, Index == Int { }

//*============================================================================*
// MARK: * ANK x Words x Swift
//*============================================================================*

extension Array<UInt>: ANKWords { }
extension ContiguousArray<UInt>: ANKWords { }
extension UnsafeBufferPointer<UInt>: ANKWords { }
extension UnsafeMutableBufferPointer<UInt>: ANKWords { }
