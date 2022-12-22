//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKFoundation

#warning("TODO")
//*============================================================================*
// MARK: * ANK x Full Width x Multiplication x Digit
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
}

#warning("REMOVE, maybe")
//*============================================================================*
// MARK: * ANK x Full Width x Unsigned x Multiplication x Digit
//*============================================================================*

extension ANKFullWidth where Self: UnsignedInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func multiplyFullWidth(by rhs: UInt) -> UInt {
        var last = UInt(repeating: self.isLessThanZero)
        return self.withUnsafeMutableWords { LHS in
            var carry  = UInt()
            for lhsIndex in LHS.indices {
                let upper = LHS[unchecked: lhsIndex].multiplyFullWidth(by:  rhs)
                let extra = LHS[unchecked: lhsIndex].addReportingOverflow(carry)
                carry = extra ? (upper + 1) : upper
            }
            
            let _ = last.multiplyFullWidth(by:  rhs)
            let _ = last.addReportingOverflow(carry)
            return  last
        }
    }
    
    @inlinable func multipliedFullWidth(by rhs: UInt) -> HL<UInt, Magnitude> {
        var lhs = self; let rhs = lhs.multiplyFullWidth(by: rhs); return (rhs, Magnitude(bitPattern: lhs))
    }
}
