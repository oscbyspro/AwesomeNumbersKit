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
// MARK: * ANK x Full Width x Subtraction x Negation
//*============================================================================*

extension ANKFullWidth where Self: SignedInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static prefix func -(x: Self) -> Self {
        let pvo: PVO<Self> = x.negatedReportingOverflow()
        precondition(!pvo.overflow); return pvo.partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// - Returns `true` when `Self.isSigned == true` and `self == min`.
    @inlinable public mutating func negateReportingOverflow() -> Bool {
        let wasLessThanZero = self.isLessThanZero
        self.formTwosComplement() // ~self &+ 1
        return wasLessThanZero && self.isLessThanZero
    }
    
    /// - Returns `true` when `Self.isSigned == true` and `self == min`.
    @inlinable public func negatedReportingOverflow() -> PVO<Self> {
        var partialValue = self
        let overflow: Bool = partialValue.negateReportingOverflow()
        return PVO(partialValue, overflow)
    }
}
