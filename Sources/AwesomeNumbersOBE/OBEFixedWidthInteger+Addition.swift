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
// MARK: * OBE x Fixed Width Integer x Addition
//*============================================================================*

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func +=(lhs: inout Self, rhs: Self) {
        lhs.body += rhs.body
    }
    
    @inlinable public static func +(lhs: Self, rhs: Self) -> Self {
        Self(bitPattern: lhs.body + rhs.body)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func addReportingOverflow(_ amount: Self) -> Bool {
        self.body.addReportingOverflow(amount.body)
    }
    
    @inlinable public func addingReportingOverflow(_ amount: Self) -> PVO<Self> {
        let (pv, o) = self.body.addingReportingOverflow(amount.body); return (Self(bitPattern: pv), o)
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Signed x Addition
//*============================================================================*

extension OBESignedFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func +=(lhs: inout Self, rhs: Int) {
        lhs.add(rhs)
    }
    
    @inlinable public static func +(lhs: Self, rhs: Int) -> Self {
        lhs.adding(rhs)
    }
    
    @inlinable public static func &+=(lhs: inout Self, rhs: Int) {
        lhs.addWrappingAround(rhs)
    }
    
    @inlinable public static func &+(lhs: Self, rhs: Int) -> Self {
        lhs.addingWrappingAround(rhs)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func add(_ amount: Int, at index: Int = 0) {
        self.body.add(amount, at: index)
    }
    
    @inlinable public func adding(_ amount: Int, at index: Int = 0) -> Self {
        Self(bitPattern: self.body.adding(amount, at: index))
    }
    
    @inlinable public mutating func addWrappingAround(_ amount: Int, at index: Int = 0) {
        self.body.addWrappingAround(amount, at: index)
    }
    
    @inlinable public func addingWrappingAround(_ amount: Int, at index: Int = 0) -> Self {
        Self(bitPattern: self.body.addingWrappingAround(amount))
    }
    
    @inlinable public mutating func addReportingOverflow(_ amount: Int, at index: Int = 0) -> Bool {
        self.body.addReportingOverflow(amount, at: index)
    }
    
    @inlinable public func addingReportingOverflow(_ amount: Int, at index: Int = 0) -> PVO<Self> {
        var pv = self; let o = pv.addReportingOverflow(amount, at: index); return (pv, o)
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Unsigned x Addition
//*============================================================================*

extension OBEUnsignedFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func +=(lhs: inout Self, rhs: UInt) {
        lhs.add(rhs)
    }
    
    @inlinable public static func +(lhs: Self, rhs: UInt) -> Self {
        lhs.adding(rhs)
    }
    
    @inlinable public static func &+=(lhs: inout Self, rhs: UInt) {
        lhs.addWrappingAround(rhs)
    }
    
    @inlinable public static func &+(lhs: Self, rhs: UInt) -> Self {
        lhs.addingWrappingAround(rhs)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func add(_ amount: UInt, at index: Int = 0) {
        self.body.add(amount, at: index)
    }
    
    @inlinable public func adding(_ amount: UInt, at index: Int = 0) -> Self {
        Self(bitPattern: self.body.adding(amount, at: index))
    }
    
    @inlinable public mutating func addWrappingAround(_ amount: UInt, at index: Int = 0) {
        self.body.addWrappingAround(amount, at: index)
    }
    
    @inlinable public func addingWrappingAround(_ amount: UInt, at index: Int = 0) -> Self {
        Self(bitPattern: self.body.addingWrappingAround(amount))
    }
    
    @inlinable public mutating func addReportingOverflow(_ amount: UInt, at index: Int = 0) -> Bool {
        self.body.addReportingOverflow(amount, at: index)
    }
    
    @inlinable public func addingReportingOverflow(_ amount: UInt, at index: Int = 0) -> PVO<Self> {
        var pv = self; let o = pv.addReportingOverflow(amount, at: index); return (pv, o)
    }
}
