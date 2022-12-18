//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import AwesomeNumbersKit

//*============================================================================*
// MARK: * OBE x Division x Unsigned x Small
//*============================================================================*

extension OBEFullWidth where High: UnsignedInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func formQuotientReportingRemainder(dividingBy rhs: UInt) -> UInt {
        self.withUnsafeMutableWords { LHS in
            precondition(!rhs.isZero)
            
            var remainder = UInt()
            var lhsIndex  = LHS.endIndex
            
            backwards: while lhsIndex != LHS.startIndex {
                LHS.formIndex(before: &lhsIndex)
                (LHS[lhsIndex], remainder) = rhs.dividingFullWidth((remainder, LHS[lhsIndex]))
            }
            
            return remainder
        }
    }
    
    @inlinable func quotientAndRemainder(dividingBy divisor: UInt) -> QR<Self, UInt> {
        var lhs = self; let rhs = lhs.formQuotientReportingRemainder(dividingBy: divisor); return QR(lhs, rhs)
    }
}
