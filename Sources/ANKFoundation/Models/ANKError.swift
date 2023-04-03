//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Error
//*============================================================================*

/// A generic error.
@frozen public struct ANKError: Error {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    /// Creates a generic error.
    @_transparent public init() { }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    /// Throws the error if the predicate is false.
    ///
    /// This is an awesome alternative to the guard-else-throw pattern.
    ///
    /// ```swift
    /// try   predicate ||           ANKError()
    /// guard predicate else { throw ANKError() }
    /// ```
    ///
    @_transparent public static func ||(predicate: Bool, error: Self) throws {
        guard predicate else { throw error }
    }
    
    /// Throws the error if the value is nil.
    ///
    /// This is an awesome alternative to the guard-let-else-throw pattern.
    ///
    /// ```swift
    ///       let value = try value ??           ANKError()
    /// guard let value =     value else { throw ANKError() }
    /// ```
    ///
    @_transparent public static func ??<T>(value: T?, error: Self) throws -> T {
        if let value { return value } else { throw error }
    }
}
