cmake_minimum_required(VERSION 3.5)
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
  ament_lint_auto_find_test_dependencies()

  find_package(ament_cmake_gtest REQUIRED)
endif()

ament_export_dependencies(${dependencies})

ament_package()
