//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Full Width x Uninitialized
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    /// Creates a new instance with access to a temporary allocation.
    @inlinable public static func uninitialized(_ body: (inout Self) -> Void) -> Self {
        Swift.withUnsafeTemporaryAllocation(of: Self.self, capacity: 1) { buffer in
            //=----------------------------------=
            // de/init: pointee is trivial
            //=----------------------------------=
            body( &buffer.baseAddress.unsafelyUnwrapped.pointee)
            return buffer.baseAddress.unsafelyUnwrapped.pointee
        }
    }
}
