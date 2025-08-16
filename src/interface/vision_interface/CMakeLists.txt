cmake_minimum_required(VERSION 3.8)
project(vision_interface)

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

# find dependencies
find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(std_msgs REQUIRED)
find_package(rosidl_default_generators REQUIRED)
find_package(Python COMPONENTS Interpreter REQUIRED)

# detect virtualenv and set Pip args accordingly
if(DEFINED ENV{VIRTUAL_ENV} OR DEFINED ENV{CONDA_PREFIX})
  set(_pip_args)
else()
  set(_pip_args "--user")
endif()

# Specify the Python package version and installation arguments
set(_pypkg "empy==3.3.4")
set(_pip_args "--quiet")  # Optional: You can add flags like --quiet to suppress output

# Install the Python package using execute_process
execute_process(
  COMMAND ${Python3_EXECUTABLE} -m pip install ${_pip_args} ${_pypkg}
  RESULT_VARIABLE pip_result
  OUTPUT_VARIABLE pip_output
  ERROR_VARIABLE pip_error
)

# Check if installation was successful
if(pip_result)
  message(FATAL_ERROR "Failed to install Python package ${_pypkg}: ${pip_error}")
else()
  message(STATUS "Successfully installed Python package ${_pypkg}")
endif()

rosidl_generate_interfaces(${PROJECT_NAME}
  "msg/DetectedObject.msg"
  "msg/Detections.msg"
  DEPENDENCIES std_msgs builtin_interfaces
)

if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  # the following line skips the linter which checks for copyrights
  # comment the line when a copyright and license is added to all source files
  set(ament_cmake_copyright_FOUND TRUE)
  # the following line skips cpplint (only works in a git repo)
  # comment the line when this package is in a git repo and when
  # a copyright and license is added to all source files
  set(ament_cmake_cpplint_FOUND TRUE)
  ament_lint_auto_find_test_dependencies()
endif()

ament_export_dependencies(rosidl_default_runtime)

ament_package()
