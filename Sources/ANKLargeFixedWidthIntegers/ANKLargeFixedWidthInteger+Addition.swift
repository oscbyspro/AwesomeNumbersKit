//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKFoundation

//*============================================================================*
// MARK: * ANK x Fixed Width Integer x Large x Addition
//*============================================================================*

extension ANKLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func +=(lhs: inout Self, rhs: Self) {
        lhs.body += rhs.body
    }
    
    @inlinable public static func +(lhs: Self, rhs: Self) -> Self {
        Self(bitPattern: lhs.body + rhs.body)
    }
    
    @inlinable public static func &+=(lhs: inout Self, rhs: Self) {
        lhs.body &+= rhs.body
    }
    
    @inlinable public static func &+(lhs: Self, rhs: Self) -> Self {
        Self(bitPattern: lhs.body &+ rhs.body)
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
// MARK: * ANK x Fixed Width Integer x Large x Signed x Addition x Small
//*============================================================================*

extension ANKSignedLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func +=(lhs: inout Self, rhs: Int) {
        lhs.body += rhs
    }
    
    @inlinable public static func +(lhs: Self, rhs: Int) -> Self {
        Self(bitPattern: lhs.body + rhs)
    }
    
    @inlinable public static func &+=(lhs: inout Self, rhs: Int) {
        lhs.body &+= rhs
    }
    
    @inlinable public static func &+(lhs: Self, rhs: Int) -> Self {
        Self(bitPattern: lhs.body &+ rhs)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func addReportingOverflow(_ amount: Int) -> Bool {
        self.body.addReportingOverflow(amount)
    }
    
    @inlinable public func addingReportingOverflow(_ amount: Int) -> PVO<Self> {
        let (pv, o) = self.body.addingReportingOverflow(amount); return (Self(bitPattern: pv), o)
    }
}

//*============================================================================*
// MARK: * ANK x Fixed Width Integer x Large x Unsigned x Addition x Small
//*============================================================================*

extension ANKUnsignedLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func +=(lhs: inout Self, rhs: UInt) {
        lhs.body += rhs
    }
    
    @inlinable public static func +(lhs: Self, rhs: UInt) -> Self {
        Self(bitPattern: lhs.body + rhs)
    }
    
    @inlinable public static func &+=(lhs: inout Self, rhs: UInt) {
        lhs.body &+= rhs
    }
    
    @inlinable public static func &+(lhs: Self, rhs: UInt) -> Self {
        Self(bitPattern: lhs.body &+ rhs)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func addReportingOverflow(_ amount: UInt) -> Bool {
        self.body.addReportingOverflow(amount)
    }
    
    @inlinable public func addingReportingOverflow(_ amount: UInt) -> PVO<Self> {
        let (pv, o) = self.body.addingReportingOverflow(amount); return (Self(bitPattern: pv), o)
    }
}
