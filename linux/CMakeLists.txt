cmake_minimum_required(VERSION 3.10)
project(xamon LANGUAGES CXX)

set(BINARY_NAME "xamon")
set(APPLICATION_ID "com.example.xamon")

cmake_policy(SET CMP0063 NEW)

set(CMAKE_INSTALL_RPATH "$ORIGIN/lib")

# Include the flutter library and its dependencies.
include(flutter/generated_plugins.cmake)

# Define the executable.
add_executable(${BINARY_NAME}
  "main.cc"
  "my_application.cc"
  "my_application.h"
  "${FLUTTER_MANAGED_SOURCES}"
)

# Apply standard Flutter build settings.
apply_standard_settings(${BINARY_NAME})

# Set the target property to enable LTO (Link Time Optimization) if supported.
set_target_properties(${BINARY_NAME} PROPERTIES INTERPROCEDURAL_OPTIMIZATION_MAYBE_SUPPORTED ON)

# Configure the executable.
target_link_libraries(${BINARY_NAME} PRIVATE flutter)
target_link_libraries(${BINARY_NAME} PRIVATE gtk)
target_link_libraries(${BINARY_NAME} PRIVATE ${FLUTTER_LIBRARIES})
add_dependencies(${BINARY_NAME} flutter_wrapper_app)

# Install the executable and its dependencies.
set(INSTALL_BUNDLE_DATA_DIR "${CMAKE_INSTALL_PREFIX}")
set(INSTALL_BUNDLE_LIB_DIR "${CMAKE_INSTALL_PREFIX}/lib")

install(TARGETS ${BINARY_NAME} DESTINATION "${INSTALL_BUNDLE_DATA_DIR}")
install(FILES "${FLUTTER_ICU_DATA_FILE}" DESTINATION "${INSTALL_BUNDLE_DATA_DIR}")
install(FILES "${FLUTTER_LIBRARY}" DESTINATION "${INSTALL_BUNDLE_LIB_DIR}")

foreach(resource ${FLUTTER_ASSET_BUNDLES})
  install(DIRECTORY "${resource}" DESTINATION "${INSTALL_BUNDLE_DATA_DIR}")
endforeach()

# Copy the desktop file.
configure_file("desktop_file.desktop.in" "${BINARY_NAME}.desktop" @ONLY)
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/${BINARY_NAME}.desktop"
  DESTINATION "${CMAKE_INSTALL_PREFIX}/share/applications")
