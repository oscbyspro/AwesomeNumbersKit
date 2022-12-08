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
// MARK: * UInt128
//*============================================================================*

extension UInt128 {
    
    //=------------------------------------------------------------------------=
    // MARK: Addition
    //=------------------------------------------------------------------------=
    
    @inlinable public static func +(lhs: Self, rhs: Self) -> Self {
        fatalError("TODO")
    }
    
    @inlinable public func addReportingOverflow(_ rhs: Self) -> Bool {
        fatalError("TODO")
    }
    
    @inlinable public func addingReportingOverflow(_ rhs: Self) -> PVO<Self> {
        fatalError("TODO")
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Bitwise
    //=------------------------------------------------------------------------=
    
    @inlinable public static func &=(lhs: inout Self, rhs: Self) {
        fatalError("TODO")
    }
    
    @inlinable public static func |=(lhs: inout Self, rhs: Self) {
        fatalError("TODO")
    }
    
    @inlinable public static func ^=(lhs: inout Self, rhs: Self) {
        fatalError("TODO")
    }
    
    @inlinable public var byteSwapped: Self {
        fatalError("TODO")
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Division
    //=------------------------------------------------------------------------=
    
    @inlinable public static func /=(lhs: inout Self, rhs: Self) {
        fatalError("TODO")
    }
    
    @inlinable public static func /(lhs: Self, rhs: Self) -> Self {
        fatalError("TODO")
    }
    
    @inlinable public static func %=(lhs: inout Self, rhs: Self) {
        fatalError("TODO")
    }
    
    @inlinable public static func % (lhs: Self, rhs: Self) -> Self {
        fatalError("TODO")
    }
    
    @inlinable public func dividedReportingOverflow(by rhs: Self) -> PVO<Self> {
        fatalError("TODO")
    }
    
    @inlinable public func remainderReportingOverflow(dividingBy rhs: Self) -> PVO<Self> {
        fatalError("TODO")
    }
    
    @inlinable public func dividingFullWidth(_ dividend: HL<Self, Magnitude>) -> QR<Self, Self> {
        fatalError("TODO")
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Multiplication
    //=------------------------------------------------------------------------=
    
    @inlinable public static func *=(lhs: inout Self, rhs: Self) {
        fatalError("TODO")
    }
    
    @inlinable public static func *(lhs: Self, rhs: Self) -> Self {
        fatalError("TODO")
    }
    
    @inlinable public func multipliedReportingOverflow(by rhs: Self) -> PVO<Self> {
        fatalError("TODO")
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Number
    //=------------------------------------------------------------------------=
    
    @inlinable public init(integerLiteral value: UInt) {
        fatalError("TODO")
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Subtraction
    //=------------------------------------------------------------------------=
    
    @inlinable public static func -(lhs: Self, rhs: Self) -> Self {
        fatalError("TODO")
    }
    
    @inlinable public func subtractReportingOverflow(_ rhs: Self) -> Bool {
        fatalError("TODO")
    }
    
    @inlinable public func subtractingReportingOverflow(_ rhs: Self) -> PVO<Self> {
        fatalError("TODO")
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Words
    //=------------------------------------------------------------------------=
    
    @inlinable public var trailingZeroBitCount: Int {
        fatalError("TODO")
    }
    
    @inlinable public var nonzeroBitCount: Int {
        fatalError("TODO")
    }
    
    @inlinable public var leadingZeroBitCount: Int {
        fatalError("TODO")
    }
}
