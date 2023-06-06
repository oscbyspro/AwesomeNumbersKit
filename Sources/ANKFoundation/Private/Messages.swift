//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Messages
//*============================================================================*

extension ANK {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    /// A message describing the source code location of an overflow occurrence.
    @inlinable public static func callsiteOverflowInfo(
    function: StaticString = #function, file: StaticString = #file, line: UInt = #line) -> String {
        "overflow in \(function) at \(file):\(line)"
    }
    
    /// A message describing the source code location of an index-out-of-bounds occurrence.
    @inlinable public static func callsiteIndexOutOfBoundsInfo(
    function: StaticString = #function, file: StaticString = #file, line: UInt = #line) -> String {
        "index out of bounds in \(function) at \(file):\(line)"
    }
}
