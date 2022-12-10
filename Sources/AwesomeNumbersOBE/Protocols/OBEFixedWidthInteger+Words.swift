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
// MARK: * OBE x Fixed Width Integer x Words
//*============================================================================*

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public var nonzeroBitCount: Int {
        _storage.nonzeroBitCount
    }
    
    @inlinable public var leadingZeroBitCount: Int {
        _storage.leadingZeroBitCount
    }
    
    @inlinable public var trailingZeroBitCount: Int {
        _storage.trailingZeroBitCount
    }
    
    @inlinable public var mostSignificantBit: Bool {
        _storage.mostSignificantBit
    }
    
    @inlinable public var leastSignificantBit: Bool {
        _storage.leastSignificantBit
    }
    
    @inlinable public var mostSignificantWord: UInt {
        _storage.mostSignificantWord
    }
    
    @inlinable public var leastSignificantWord: UInt {
        _storage.leastSignificantWord
    }
}
