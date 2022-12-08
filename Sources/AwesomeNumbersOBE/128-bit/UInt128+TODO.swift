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
    // MARK: Bitwise
    //=------------------------------------------------------------------------=
    
    @inlinable public var byteSwapped: Self {
        fatalError("TODO")
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Division
    //=------------------------------------------------------------------------=
    
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
    
    @inlinable public func multipliedReportingOverflow(by rhs: Self) -> PVO<Self> {
        fatalError("TODO")
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Number
    //=------------------------------------------------------------------------=
    
    @inlinable public init(integerLiteral value: UInt) {
        fatalError("TODO")
    }
}
