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
// MARK: * Miscellaneous
//*============================================================================*
//=----------------------------------------------------------------------------=
// MARK: + UInt
//=----------------------------------------------------------------------------=

extension UInt {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
        
    @inlinable var mostSignificantBit: Bool {
        self & 1 << (bitWidth - 1) != 0
    }
    
    @inlinable var leastSignificantBit: Bool {
        self & 1 != 0
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Awesome Fixed Width Integer
//=----------------------------------------------------------------------------=

extension AwesomeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(repeating bit: Bool) {
        self = bit ? ~0 : 0 // TODO: protocol requirement (maybe)
    }
}
