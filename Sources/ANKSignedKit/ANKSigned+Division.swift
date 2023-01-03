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
// MARK: * ANK x Signed x Division
//*============================================================================*

extension ANKSigned {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
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
    
    @inlinable public static func %(lhs: Self, rhs: Self) -> Self {
        fatalError("TODO")
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func divideReportingOverflow(by divisor: Self) -> Bool {
        fatalError("TODO")
    }
    
    @inlinable public func dividedReportingOverflow(by divisor: Self) -> PVO<Self> {
        fatalError("TODO")
    }
    
    @inlinable public mutating func formRemainderReportingOverflow(by divisor: Self) -> Bool {
        fatalError("TODO")
    }
    
    @inlinable public func remainderReportingOverflow(dividingBy divisor: Self) -> PVO<Self> {
        fatalError("TODO")
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public func quotientAndRemainder(dividingBy rhs: Self) -> QR<Self, Self> {
        fatalError("TODO")
    }
}
