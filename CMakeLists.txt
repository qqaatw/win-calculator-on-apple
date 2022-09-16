cmake_minimum_required(VERSION 3.8)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(LIB_SOURCE_FILES
    # CalcManager
    3rdparty/calculator/src/CalcManager/CalculatorHistory.cpp
    3rdparty/calculator/src/CalcManager/NumberFormattingUtils.cpp
    3rdparty/calculator/src/CalcManager/CalculatorManager.cpp
    3rdparty/calculator/src/CalcManager/UnitConverter.cpp
    3rdparty/calculator/src/CalcManager/ExpressionCommand.cpp
    3rdparty/calculator/src/CalcManager/pch.cpp
    # CEngine
    3rdparty/calculator/src/CalcManager/CEngine/CalcInput.cpp
    3rdparty/calculator/src/CalcManager/CEngine/calc.cpp
    3rdparty/calculator/src/CalcManager/CEngine/CalcUtils.cpp
    3rdparty/calculator/src/CalcManager/CEngine/scicomm.cpp
    3rdparty/calculator/src/CalcManager/CEngine/History.cpp
    3rdparty/calculator/src/CalcManager/CEngine/scidisp.cpp
    3rdparty/calculator/src/CalcManager/CEngine/Number.cpp
    3rdparty/calculator/src/CalcManager/CEngine/scifunc.cpp
    3rdparty/calculator/src/CalcManager/CEngine/Rational.cpp
    3rdparty/calculator/src/CalcManager/CEngine/scioper.cpp
    3rdparty/calculator/src/CalcManager/CEngine/RationalMath.cpp
    3rdparty/calculator/src/CalcManager/CEngine/sciset.cpp
    # Ratpack
    3rdparty/calculator/src/CalcManager/Ratpack/basex.cpp
    3rdparty/calculator/src/CalcManager/Ratpack/itrans.cpp
    3rdparty/calculator/src/CalcManager/Ratpack/rat.cpp
    3rdparty/calculator/src/CalcManager/Ratpack/conv.cpp
    3rdparty/calculator/src/CalcManager/Ratpack/itransh.cpp
    3rdparty/calculator/src/CalcManager/Ratpack/support.cpp
    3rdparty/calculator/src/CalcManager/Ratpack/exp.cpp
    3rdparty/calculator/src/CalcManager/Ratpack/logic.cpp
    3rdparty/calculator/src/CalcManager/Ratpack/trans.cpp
    3rdparty/calculator/src/CalcManager/Ratpack/fact.cpp
    3rdparty/calculator/src/CalcManager/Ratpack/num.cpp
    3rdparty/calculator/src/CalcManager/Ratpack/transh.cpp
    )
    
set(LIB_HEADER_FILES
    # CalcManager
    3rdparty/calculator/src/CalcManager/CalculatorHistory.h
    3rdparty/calculator/src/CalcManager/CalculatorManager.h
    3rdparty/calculator/src/CalcManager/CalculatorResource.h
    3rdparty/calculator/src/CalcManager/CalculatorVector.h
    3rdparty/calculator/src/CalcManager/Command.h
    3rdparty/calculator/src/CalcManager/ExpressionCommand.h
    3rdparty/calculator/src/CalcManager/ExpressionCommandInterface.h
    3rdparty/calculator/src/CalcManager/NumberFormattingUtils.h
    3rdparty/calculator/src/CalcManager/UnitConverter.h
    3rdparty/calculator/src/CalcManager/pch.h
    3rdparty/calculator/src/CalcManager/sal_cross_platform.h
    3rdparty/calculator/src/CalcManager/winerror_cross_platform.h
    # CalcManager/Header Files
    "3rdparty/calculator/src/CalcManager/Header Files/CCommand.h"
    "3rdparty/calculator/src/CalcManager/Header Files/CalcEngine.h"
    "3rdparty/calculator/src/CalcManager/Header Files/CalcInput.h"
    "3rdparty/calculator/src/CalcManager/Header Files/CalcUtils.h"
    "3rdparty/calculator/src/CalcManager/Header Files/EngineStrings.h"
    "3rdparty/calculator/src/CalcManager/Header Files/History.h"
    "3rdparty/calculator/src/CalcManager/Header Files/ICalcDisplay.h"
    "3rdparty/calculator/src/CalcManager/Header Files/IHistoryDisplay.h"
    "3rdparty/calculator/src/CalcManager/Header Files/Number.h"
    "3rdparty/calculator/src/CalcManager/Header Files/RadixType.h"
    "3rdparty/calculator/src/CalcManager/Header Files/Rational.h"
    "3rdparty/calculator/src/CalcManager/Header Files/RationalMath.h"
)
set(SOURCE_FILES 
    Shared/Command.swift
    Shared/ContentView.swift
    Shared/Control.swift
    Shared/CalculatorApp.swift
    Shared/MSCalculatorWrapper.h
    Shared/MSCalculatorWrapper.mm
    "Shared/MSCalculator (iOS)-Bridging-Header.h"
    "Shared/MSCalculator (macOS)-Bridging-Header.h"
)

set(ICON_NAME "Calculator.icns")
set(ICON_PATH "assets/Calculator.icns")
set(COPYRIGHT "2022 qqaatw\nApache License 2.0\nThe icon is licensed under CC BY 4.0")

enable_language("Swift")
project(WinCalculatorOnApple)

add_library(MSCalculator SHARED ${LIB_SOURCE_FILES} ${LIB_HEADER_FILES})
target_include_directories(MSCalculator PRIVATE 3rdparty/calculator/src/CalcManager/)

set_source_files_properties(${ICON_PATH} PROPERTIES MACOSX_PACKAGE_LOCATION "Resources")
add_executable(${PROJECT_NAME} MACOSX_BUNDLE ${SOURCE_FILES} ${ICON_PATH})
target_link_libraries(${PROJECT_NAME} PRIVATE MSCalculator)
target_include_directories(${PROJECT_NAME} PRIVATE .)
target_include_directories(${PROJECT_NAME} PRIVATE 3rdparty/calculator/src/)
target_include_directories(${PROJECT_NAME} PRIVATE 3rdparty/calculator/src/CalcManager/)
set_target_properties(${PROJECT_NAME} PROPERTIES
  Swift_LANGUAGE_VERSION 5.0
  XCODE_ATTRIBUTE_SWIFT_OBJC_INTERFACE_HEADER_NAME "MSCalculatorWrapper.h"
  XCODE_ATTRIBUTE_DERIVED_FILE_DIR "${PROJECT_BINARY_DIR}"
  XCODE_ATTRIBUTE_SWIFT_OBJC_BRIDGING_HEADER "${PROJECT_SOURCE_DIR}/Shared/MSCalculator (macOS)-Bridging-Header.h"
  MACOSX_BUNDLE_ICON_FILE ${ICON_NAME}
  MACOSX_BUNDLE_COPYRIGHT ${COPYRIGHT}
)

install(TARGETS ${PROJECT_NAME}
    CONFIGURATIONS Debug
    BUNDLE DESTINATION Debug/ COMPONENT Runtime
    RUNTIME DESTINATION Debug/ COMPONENT Runtime
)


# Install dynamic libraries to the bundle
# https://github.com/ionyshch/cmake-bundle-macos/blob/master/CMakeLists.txt
set(APPS "${CMAKE_BINARY_DIR}/Debug/${PROJECT_NAME}.app")

install(CODE "
    include(BundleUtilities)
    fixup_bundle(\"${APPS}\" \"\" \"${CMAKE_BINARY_DIR}/Debug\")"
)

set(CPACK_GENERATOR "DRAGNDROP")
include(CPack)