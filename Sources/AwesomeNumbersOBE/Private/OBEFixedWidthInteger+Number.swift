//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Number
//*============================================================================*

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=

    @inlinable public init(_truncatingBits uint: UInt) {
        self.init(descending:(High(), Low(_truncatingBits: uint))) // Low.bitWidth >= UInt.bitWidth
    }
    
    @inlinable public init(integerLiteral x: IntegerLiteralType) where IntegerLiteralType: BinaryInteger {
        self.init(x)
    }
    
    #warning("WIP")
    #warning("WIP")
    #warning("WIP")
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
//    @inlinable public init(_ source: some BinaryInteger) {
//        guard let result = Self(exactly: source) else {
//            preconditionFailure("Value is outside the representable range")
//        }
//
//        self = result
//    }
//
//    @inlinable public init?<T: BinaryInteger>(exactly source: T) {
//        guard Self.isSigned || source >= 0 else { return nil }
//        //=--------------------------------------=
//        //
//        //=--------------------------------------=
//        if  let low = Low(exactly: source.magnitude) {
//            self.init(descending:(source < (0 as T) ? (~0, ~low &+ 1) : (0, low)))
//        //=--------------------------------------=
//        //
//        //=--------------------------------------=
//        }   else {
//            let low = Low(source & T(~0 as Low))
//            guard let high = High(exactly: source >> Low.bitWidth) else { return nil }
//            self.init(descending:(high, low))
//        }
//    }
}
