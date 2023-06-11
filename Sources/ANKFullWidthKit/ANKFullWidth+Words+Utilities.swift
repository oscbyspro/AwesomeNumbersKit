//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKCoreKit

//*============================================================================*
// MARK: * NBK x Full Width x Words x Utilities
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    /// Returns this value's last index, in min two's complement form.
    ///
    /// ```swift
    /// Int256( 1).minLastIndexReportingIsZeroOrMinusOne() // (minLastIndex: 0, isZeroOrMinusOne: false)
    /// Int256( 0).minLastIndexReportingIsZeroOrMinusOne() // (minLastIndex: 0, isZeroOrMinusOne: true )
    /// Int256(-1).minLastIndexReportingIsZeroOrMinusOne() // (minLastIndex: 0, isZeroOrMinusOne: true )
    /// ```
    ///
    /// - Note: Using `isLessThanZero` is an efficient way to differentiate between `0` and `-1`.
    ///
    @inlinable public func minLastIndexReportingIsZeroOrMinusOne() -> (minLastIndex: Int, isZeroOrMinusOne: Bool) {
        let sign:  UInt = UInt(repeating: self.isLessThanZero)
        let index: Int? = self.withUnsafeWords({ SELF in SELF.lastIndex(where:{ word in word != sign }) })
        return index.map({( $0, false )}) ?? (0, true)
    }
    
    /// Returns this value's word count, in min two's complement form.
    ///
    /// ```swift
    /// Int256( 1).minWordCountReportingIsZeroOrMinusOne() // (minWordCount: 1, isZeroOrMinusOne: false)
    /// Int256( 0).minWordCountReportingIsZeroOrMinusOne() // (minWordCount: 1, isZeroOrMinusOne: true )
    /// Int256(-1).minWordCountReportingIsZeroOrMinusOne() // (minWordCount: 1, isZeroOrMinusOne: true )
    /// ```
    ///
    /// - Note: Using `isLessThanZero` is an efficient way to differentiate between `0` and `-1`.
    ///
    @inlinable public func minWordCountReportingIsZeroOrMinusOne() -> (minWordCount: Int, isZeroOrMinusOne: Bool) {
        let info = self.minLastIndexReportingIsZeroOrMinusOne()
        return (info.minLastIndex &+ 1, info.isZeroOrMinusOne)
    }
}
