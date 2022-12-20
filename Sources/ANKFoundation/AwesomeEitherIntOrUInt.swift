//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Awesome x Either Int Or UInt
//*============================================================================*

public protocol AwesomeEitherIntOrUInt: AwesomeFixedWidthInteger where Magnitude: AwesomeEitherIntOrUInt { }

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension AwesomeEitherIntOrUInt {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(repeating word: UInt) {
        self.init(_truncatingBits:   word)
    }
    
    @inlinable public init(bitPattern: some AwesomeEitherIntOrUInt) {
        self = Swift.unsafeBitCast(bitPattern, to: Self.self)
    }
}

//*============================================================================*
// MARK: * Awesome x Either Int Or UInt x Swift
//*============================================================================*

extension  Int: AwesomeEitherIntOrUInt,   AwesomeSignedLargeFixedWidthInteger { }
extension UInt: AwesomeEitherIntOrUInt, AwesomeUnsignedLargeFixedWidthInteger { }
