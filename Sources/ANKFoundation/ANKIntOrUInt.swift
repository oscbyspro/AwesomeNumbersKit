//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Int Or UInt
//*============================================================================*

public protocol ANKIntOrUInt: ANKLargeFixedWidthInteger<Self>, ANKTrivialFixedWidthInteger where Magnitude == UInt { }

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

//*============================================================================*
// MARK: * ANK x Int Or UInt x Swift
//*============================================================================*

extension  Int: ANKIntOrUInt,   ANKSignedLargeFixedWidthInteger { }
extension UInt: ANKIntOrUInt, ANKUnsignedLargeFixedWidthInteger { }
