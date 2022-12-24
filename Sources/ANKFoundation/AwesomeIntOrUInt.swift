//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Awesome x Int Or UInt
//*============================================================================*

public protocol AwesomeIntOrUInt: AwesomeLargeFixedWidthInteger<Self> where Magnitude == UInt { }

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension AwesomeIntOrUInt {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent public init(repeating word: UInt) {
        self.init(_truncatingBits: word)
    }
    
    @_transparent public init(bitPattern: some AwesomeIntOrUInt) {
        self = unsafeBitCast(bitPattern, to: Self.self)
    }
}

//*============================================================================*
// MARK: * Awesome x Int Or UInt x Swift
//*============================================================================*

extension  Int: AwesomeIntOrUInt,   AwesomeSignedLargeFixedWidthInteger { }
extension UInt: AwesomeIntOrUInt, AwesomeUnsignedLargeFixedWidthInteger { }

//=----------------------------------------------------------------------------=
// MARK: + Fixes Marked As Unavailable in /Integers.swift
//=----------------------------------------------------------------------------=

extension Int {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public static func &+(lhs: Self, rhs: Self) -> Self {
        lhs.addingReportingOverflow(rhs).partialValue
    }

    @_transparent public static func &-(lhs: Self, rhs: Self) -> Self {
        lhs.subtractingReportingOverflow(rhs).partialValue
    }
}
