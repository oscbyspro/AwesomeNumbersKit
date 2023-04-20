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
// MARK: * ANK x Full Width x Addition x Digit
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_disfavoredOverload @inlinable public mutating func addReportingOverflow(_ amount: Digit) -> Bool {
        self.withUnsafeMutableWords { SELF in
            let amountIsLessThanZero: Bool = amount.isLessThanZero
            var carry: Bool = SELF.first.addReportingOverflow(UInt(bitPattern: amount))
            //=----------------------------------=
            if  carry == amountIsLessThanZero { return false }
            let extra =  UInt(bitPattern: amountIsLessThanZero ? -1 : 1)
            //=----------------------------------=
            for index in 1 ..< SELF.lastIndex {
                carry =  SELF[index].addReportingOverflow(extra)
                if carry == amountIsLessThanZero { return false }
            }
            //=----------------------------------=
            let pvo: PVO<Digit> = Digit(bitPattern: SELF.last).addingReportingOverflow(Digit(bitPattern: extra))
            SELF.last = UInt(bitPattern: pvo.partialValue)
            return pvo.overflow as Bool
        }
    }
    
    @_disfavoredOverload @inlinable public func addingReportingOverflow(_ amount: Digit) -> PVO<Self> {
        var partialValue = self
        let overflow: Bool = partialValue.addReportingOverflow(amount)
        return PVO(partialValue, overflow)
    }
}
