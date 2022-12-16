//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Awesome x Fixed Width Integer x Large
//*============================================================================*

public protocol AwesomeLargeFixedWidthInteger: AwesomeFixedWidthInteger where
Magnitude: AwesomeUnsignedLargeFixedWidthInteger {
        
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(repeating word: UInt)
}

//*============================================================================*
// MARK: * Awesome x Fixed Width Integer x Large x Signed
//*============================================================================*

public protocol AwesomeSignedLargeFixedWidthInteger: AwesomeLargeFixedWidthInteger,
AwesomeSignedFixedWidthInteger { }

//*============================================================================*
// MARK: * Awesome x Fixed Width Integer x Large x Unsigned
//*============================================================================*

public protocol AwesomeUnsignedLargeFixedWidthInteger: AwesomeLargeFixedWidthInteger,
AwesomeUnsignedFixedWidthInteger { }