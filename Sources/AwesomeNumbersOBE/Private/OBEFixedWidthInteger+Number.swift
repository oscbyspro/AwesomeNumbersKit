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
// MARK: * OBE x Fixed Width Integer x Number
//*============================================================================*
//=----------------------------------------------------------------------------=
// most init methods must be overloaded at the un/signed integer protocol level
//=----------------------------------------------------------------------------=

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(_truncatingBits source: UInt) {
        self.init(descending:(High(), Low(_truncatingBits: source))) // Low.bitWidth >= UInt.bitWidth
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(_integerLiteral source: some AwesomeFixedWidthInteger) {
        let high = High(repeating: source.isLessThanZero)
        let low  = Self.reinterpret(High(truncatingIfNeeded: source))
        self.init(descending:(high, low))
    }
    
    @inlinable init(_basic source: some BinaryInteger) {
        self.init(exactly: source)!
    }

    @inlinable init?<T: BinaryInteger>(_exactly source: T) {
        if Self.isSigned && source < 0 { return nil }        
        //=--------------------------------------=
        //
        //=--------------------------------------=
        if  let low = Low(exactly: source.magnitude) {
            self.init(descending:(source < (0 as T) ? (~0, ~low &+ 1) : (0, low)))
        //=--------------------------------------=
        //
        //=--------------------------------------=
        }   else {
            let low = Low(source & T(~0 as Low))
            guard let high = High(exactly: source >> Low.bitWidth) else { return nil }
            self.init(descending:(high, low))
        }
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Number x Signed
//*============================================================================*

extension OBESignedFixedWidthInteger {

    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(integerLiteral source: Int) {
        self.init(_integerLiteral: source)
    }
    
    @inlinable public init(_ source: some BinaryInteger) {
        self.init(_basic: source)
    }

    @inlinable public init?(exactly source: some BinaryInteger) {
        self.init(_exactly: source)
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Number x Unsigned
//*============================================================================*

extension OBEUnsignedFixedWidthInteger {

    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(integerLiteral source: UInt) {
        self.init(_integerLiteral: source)
    }
    
    @inlinable public init(_ source: some BinaryInteger) {
        self.init(_basic: source)
    }

    @inlinable public init?(exactly source: some BinaryInteger) {
        self.init(_exactly: source)
    }
}
