//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Magnitude
//*============================================================================*

extension OBEFixedWidthInteger where Self: SignedInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable static func magnitude(_ x: Self) -> Magnitude {
        // TODO: formTwosComplement()
        let m = Magnitude(bitPattern: x); return x.isLessThanZero ? ~m &+ 1 : m
    }
}
