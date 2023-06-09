//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKFoundation

//*============================================================================*
// MARK: * ANK x Full Width x Comparisons
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public var isFull: Bool {
        self.low.isFull && self.high.isFull
    }
    
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
        self .withUnsafeWords { LHS in
        other.withUnsafeWords { RHS in
            var index = LHS.lastIndex
            
            backwards: do {
                let lhsWord  = Digit(bitPattern: LHS[index])
                let rhsWord  = Digit(bitPattern: RHS[index])
                if  lhsWord != rhsWord { return  lhsWord < rhsWord ? -1 : 1 }
            }
            
            backwards: while !index.isZero {
                LHS.formIndex(before: &index)
                let lhsWord  = LHS[index]
                let rhsWord  = RHS[index]
                if  lhsWord != rhsWord { return  lhsWord < rhsWord ? -1 : 1 }
            }
            
            return Int.zero
        }}
    }
}
