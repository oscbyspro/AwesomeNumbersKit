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
// MARK: * Trivial
//*============================================================================*

enum Trivial {
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    static let allFixedWidthIntegerTypes: [any AwesomeFixedWidthInteger.Type] =
    [Int.self,  Int8.self,  Int16.self,  Int32.self,  Int64.self,
    UInt.self, UInt8.self, UInt16.self, UInt32.self, UInt64.self]
    
    static let allSignedFixedWidthIntegerTypes =
    allFixedWidthIntegerTypes.compactMap({ $0 as? any /*---*/AwesomeSignedFixedWidthInteger.Type })
    
    static let allUnsignedFixedWidthIntegerTypes =
    allFixedWidthIntegerTypes.compactMap({ $0 as? any /*-*/AwesomeUnsignedFixedWidthInteger.Type })
    
    static let allLargeFixedWidthIntegerTypes =
    allFixedWidthIntegerTypes.compactMap({ $0 as? any /*----*/AwesomeLargeFixedWidthInteger.Type })
    
    static let allSignedLargeFixedWidthIntegerTypes =
    allFixedWidthIntegerTypes.compactMap({ $0 as? any   AwesomeSignedLargeFixedWidthInteger.Type })
    
    static let allUnsignedLargeFixedWidthIntegerTypes =
    allFixedWidthIntegerTypes.compactMap({ $0 as? any AwesomeUnsignedLargeFixedWidthInteger.Type })
    
    static let allEitherIntOrUIntTypes =
    allFixedWidthIntegerTypes.compactMap({ $0 as? any /*-----------*/AwesomeEitherIntOrUInt.Type })
}
