// swift-tools-version: 5.7
//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import PackageDescription

//*============================================================================*
// MARK: * AwesomeNumbersKit
//*============================================================================*

let withSlowBuildAlerts: [SwiftSetting] = [
.unsafeFlags(["-Xfrontend", "-warn-long-function-bodies=100"],          .when(configuration: .debug)),
.unsafeFlags(["-Xfrontend", "-warn-long-expression-type-checking=100"], .when(configuration: .debug))]

//*============================================================================*
// MARK: * AwesomeNumbersKit x Package
//*============================================================================*

let package = Package(
    name: "AwesomeNumbersKit",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        //=--------------------------------------=
        // AwesomeNumbersKit
        //=--------------------------------------=
        .library(
        name: "AwesomeNumbersKit",
        targets: ["AwesomeNumbersKit"]),
        //=--------------------------------------=
        // AwesomeNumbersOBE
        //=--------------------------------------=
        .library(
        name: "AwesomeNumbersOBE",
        targets: ["AwesomeNumbersOBE"]),
    ],
    targets: [
        //=--------------------------------------=
        // AwesomeNumbersKit
        //=--------------------------------------=
        .target(
        name: "AwesomeNumbersKit",
        dependencies: [],
        swiftSettings: withSlowBuildAlerts),
        
        .testTarget(
        name: "AwesomeNumbersKitTests",
        dependencies: ["AwesomeNumbersKit"],
        swiftSettings: withSlowBuildAlerts),
        
        .testTarget(
        name: "AwesomeNumbersKitBenchmarks",
        dependencies: ["AwesomeNumbersKit"]),
        //=--------------------------------------=
        // AwesomeNumbersOBE
        //=--------------------------------------=
        .target(
        name: "AwesomeNumbersOBE",
        dependencies: ["AwesomeNumbersKit"],
        swiftSettings: withSlowBuildAlerts),
        
        .testTarget(
        name: "AwesomeNumbersOBETests",
        dependencies: ["AwesomeNumbersOBE"],
        swiftSettings: withSlowBuildAlerts),
        
        .testTarget(
        name: "AwesomeNumbersOBEBenchmarks",
        dependencies: ["AwesomeNumbersOBE"]),
    ]
)
