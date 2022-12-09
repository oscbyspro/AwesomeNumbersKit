//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Complements
//*============================================================================*

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func formTwosComplement() {
        self.withUnsafeMutableTwosComplementWords { SELF in
            var carry =  true
            for index in Self.indices {
                (SELF[index], carry) = (~SELF[index]).addingReportingOverflow(UInt(carry))
            }
        }
    }
    
    @inlinable public func twosComplement() -> Self {
        var x = self; x.formTwosComplement(); return x
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Complements x Signed
//*============================================================================*

extension OBESignedFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public var magnitude: Magnitude {
        let isLessThanZero = isLessThanZero
        let bitPattern = Magnitude(bitPattern: self)
        return isLessThanZero ? bitPattern.twosComplement() : bitPattern
    }
}
