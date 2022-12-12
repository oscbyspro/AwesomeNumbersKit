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
// MARK: * Int256
//*============================================================================*

@frozen public struct Int256: OBESignedFixedWidthInteger {
    
    public typealias Magnitude = UInt256
        
    public typealias X64 = (UInt64, UInt64, UInt64, UInt64)
    
    public typealias X32 = (UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32)
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    @usableFromInline var body: OBEDoubleWidth<Int128>
}

//*============================================================================*
// MARK: * UInt256
//*============================================================================*

@frozen public struct UInt256: OBEUnsignedFixedWidthInteger {
    
    public typealias X64 = (UInt64, UInt64, UInt64, UInt64)

    public typealias X32 = (UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32)

    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=

    @usableFromInline var body: OBEDoubleWidth<UInt128>
}
