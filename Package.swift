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
// MARK: * Awesome Numbers Kit
//*============================================================================*

let withSlowBuildAlerts: [SwiftSetting] = [
.unsafeFlags(["-Xfrontend", "-warn-long-function-bodies=200"],          .when(configuration: .debug)),
.unsafeFlags(["-Xfrontend", "-warn-long-expression-type-checking=200"], .when(configuration: .debug))]

//*============================================================================*
// MARK: * Awesome Numbers Kit x Package
//*============================================================================*

let package = Package(
    name: "AwesomeNumbersKit",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        //=--------------------------------------=
        // Awesome Numbers Kit
        //=--------------------------------------=
        .library(
        name: "AwesomeNumbersKit",
        targets: ["AwesomeNumbersKit"]),
        //=--------------------------------------=
        // ANK x Foundation
        //=--------------------------------------=
        .library(
        name: "ANKFoundation",
        targets: ["ANKFoundation"]),
        //=--------------------------------------=
        // ANK x Large Fixed Width Integers
        //=--------------------------------------=
        .library(
        name: "ANKLargeFixedWidthIntegers",
        targets: ["ANKLargeFixedWidthIntegers"]),
    ],
    targets: [
        //=--------------------------------------=
        // Awesome Numbers Kit
        //=--------------------------------------=
        .target(
        name: "AwesomeNumbersKit",
        dependencies: ["ANKFoundation", "ANKLargeFixedWidthIntegers"],
        path: "Bundles/AwesomeNumbersKit"),
        //=--------------------------------------=
        // ANK x Foundation
        //=--------------------------------------=
        .target(
        name: "ANKFoundation",
        dependencies: [],
        swiftSettings: withSlowBuildAlerts),
        
        .testTarget(
        name: "ANKFoundationTests",
        dependencies: ["ANKFoundation"],
        swiftSettings: withSlowBuildAlerts),
        
        .testTarget(
        name: "ANKFoundationBenchmarks",
        dependencies: ["ANKFoundation"],
        swiftSettings: withSlowBuildAlerts),
        //=--------------------------------------=
        // ANK x Large Fixed Width Integers
        //=--------------------------------------=
        .target(
        name: "ANKLargeFixedWidthIntegers",
        dependencies: ["ANKFoundation"],
        swiftSettings: withSlowBuildAlerts),
        
        .testTarget(
        name: "ANKLargeFixedWidthIntegersTests",
        dependencies: ["ANKLargeFixedWidthIntegers"],
        swiftSettings: withSlowBuildAlerts),
        
        .testTarget(
        name: "ANKLargeFixedWidthIntegersBenchmarks",
        dependencies: ["ANKLargeFixedWidthIntegers"],
        swiftSettings: withSlowBuildAlerts),
    ]
)
