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
// MARK: * Types
//*============================================================================*

enum Trivial {
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    static let allBinaryIntegerTypes: [any ANKBinaryInteger.Type] =
    [Int.self,  Int8.self,  Int16.self,  Int32.self,  Int64.self,
    UInt.self, UInt8.self, UInt16.self, UInt32.self, UInt64.self]
    
    static let allSignedIntegerTypes =
    allBinaryIntegerTypes.compactMap({ $0 as? any /*----*/ANKSignedInteger.Type })
    
    static let allUnsignedIntegerTypes =
    allBinaryIntegerTypes.compactMap({ $0 as? any /*--*/ANKUnsignedInteger.Type })
    
    static let allFixedWidthIntegerTypes =
    allBinaryIntegerTypes.compactMap({ $0 as? any /**/ANKFixedWidthInteger.Type })
    
    static let allSignedFixedWidthIntegerTypes =
    allFixedWidthIntegerTypes.compactMap({ $0 as? any /*---*/ANKSignedFixedWidthInteger.Type })
    
    static let allUnsignedFixedWidthIntegerTypes =
    allFixedWidthIntegerTypes.compactMap({ $0 as? any /*-*/ANKUnsignedFixedWidthInteger.Type })
    
    static let allLargeFixedWidthIntegerTypes =
    allFixedWidthIntegerTypes.compactMap({ $0 as? any /*----*/ANKLargeFixedWidthInteger.Type })
    
    static let allSignedLargeFixedWidthIntegerTypes =
    allFixedWidthIntegerTypes.compactMap({ $0 as? any   ANKSignedLargeFixedWidthInteger.Type })
    
    static let allUnsignedLargeFixedWidthIntegerTypes =
    allFixedWidthIntegerTypes.compactMap({ $0 as? any ANKUnsignedLargeFixedWidthInteger.Type })
    
    static let allEitherIntOrUIntTypes =
    allFixedWidthIntegerTypes.compactMap({ $0 as? any /*-----------------*/ANKIntOrUInt.Type })
}
