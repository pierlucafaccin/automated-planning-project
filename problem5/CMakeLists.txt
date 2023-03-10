cmake_minimum_required(VERSION 3.8)
project(problem5)


find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(rclcpp_action REQUIRED)
find_package(plansys2_msgs REQUIRED)
find_package(plansys2_executor REQUIRED)

set(CMAKE_CXX_STANDARD 17)

set(dependencies
    rclcpp
    rclcpp_action
    plansys2_msgs
    plansys2_executor
)

add_executable(move_node src/move_node.cpp)
ament_target_dependencies(move_node ${dependencies})

add_executable(move_with_box_node src/move_with_box_node.cpp)
ament_target_dependencies(move_with_box_node ${dependencies})

add_executable(move_with_box2_node src/move_with_box2_node.cpp)
ament_target_dependencies(move_with_box2_node ${dependencies})

add_executable(move_with_box3_node src/move_with_box3_node.cpp)
ament_target_dependencies(move_with_box3_node ${dependencies})

add_executable(move_with_box4_node src/move_with_box4_node.cpp)
ament_target_dependencies(move_with_box4_node ${dependencies})

add_executable(fill_item_node src/fill_item_node.cpp)
ament_target_dependencies(fill_item_node ${dependencies})

add_executable(load_carrier_node src/load_carrier_node.cpp)
ament_target_dependencies(load_carrier_node ${dependencies})

add_executable(empty_box_food_node src/empty_box_food_node.cpp)
ament_target_dependencies(empty_box_food_node ${dependencies})

add_executable(empty_box_medicine_node src/empty_box_medicine_node.cpp)
ament_target_dependencies(empty_box_medicine_node ${dependencies})

add_executable(empty_box_tool_node src/empty_box_tool_node.cpp)
ament_target_dependencies(empty_box_tool_node ${dependencies})

add_executable(unloadrobot_node src/unloadrobot_node.cpp)
ament_target_dependencies(unloadrobot_node ${dependencies})

install(DIRECTORY launch pddl DESTINATION share/${PROJECT_NAME})

install(TARGETS
  move_node
  move_with_box_node
  move_with_box2_node
  move_with_box3_node
  move_with_box4_node
  load_carrier_node
  fill_item_node
  empty_box_food_node
  empty_box_medicine_node
  empty_box_tool_node
  unloadrobot_node
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION lib/${PROJECT_NAME}
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

ament_package()
