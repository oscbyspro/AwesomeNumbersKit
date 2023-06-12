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
// MARK: * ANK x Full Width x Comparisons
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public var isZero: Bool {
        self.low.isZero && self.high.isZero
    }
    
    @_transparent public var isLessThanZero: Bool {
        self.high.isLessThanZero
    }
    
    @inlinable public var isMoreThanZero: Bool {
        !(self.isLessThanZero || self.isZero)
    }
    
    @inlinable public func signum() -> Int {
        self.isLessThanZero ? -1 : self.isZero ? 0 : 1
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.low == rhs.low && lhs.high == rhs.high
    }
    
    @inlinable public static func <(lhs: Self, rhs: Self) -> Bool {
        lhs.compared(to: rhs) == -1
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public func hash(into hasher: inout Hasher) {
        hasher.combine(self.low )
        hasher.combine(self.high)
    }
    
    @inlinable public func compared(to other: Self) -> Int {
        self .withUnsafeWords { this  in
        other.withUnsafeWords { other in
            backwards: do {
                let lhsWord: Digit = this .tail
                let rhsWord: Digit = other.tail
                if  lhsWord != rhsWord { return lhsWord < rhsWord ? -1 : 1 }
            }
                    
            backwards: for index in this.indices.dropLast().reversed() {
                let lhsWord: UInt = this [index]
                let rhsWord: UInt = other[index]
                if  lhsWord != rhsWord { return lhsWord < rhsWord ? -1 : 1 }
            }

            return Int.zero
        }}
    }
}
