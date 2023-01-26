# Copyright 2019 Intelligent Robotics Lab
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import os

from ament_index_python.packages import get_package_share_directory

from launch import LaunchDescription
from launch.actions import DeclareLaunchArgument, IncludeLaunchDescription, SetEnvironmentVariable
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch.substitutions import LaunchConfiguration
from launch_ros.actions import Node


def generate_launch_description():
    # Get the launch directory
    example_dir = get_package_share_directory('problem5')
    namespace = LaunchConfiguration('namespace')

    declare_namespace_cmd = DeclareLaunchArgument(
        'namespace',
        default_value='',
        description='Namespace')

    plansys2_cmd = IncludeLaunchDescription(
        PythonLaunchDescriptionSource(os.path.join(
            get_package_share_directory('plansys2_bringup'),
            'launch',
            'plansys2_bringup_launch_monolithic.py')),
        launch_arguments={
            'model_file': example_dir + '/pddl/domain-simple.pddl',
            'namespace': namespace
        }.items())

    # Specify the actions
    move_cmd = Node(
        package='problem5',
        executable='move_node',
        name='move_node',
        namespace=namespace,
        output='screen',
        parameters=[])
    
    move_with_box_cmd = Node(
        package='problem5',
        executable='move_with_box_node',
        name='move_with_box_node',
        namespace=namespace,
        output='screen',
        parameters=[])
    
    move_with_box2_cmd = Node(
        package='problem5',
        executable='move_with_box2_node',
        name='move_with_box2_node',
        namespace=namespace,
        output='screen',
        parameters=[])

    move_with_box3_cmd = Node(
        package='problem5',
        executable='move_with_box3_node',
        name='move_with_box3_node',
        namespace=namespace,
        output='screen',
        parameters=[])

    move_with_box4_cmd = Node(
        package='problem5',
        executable='move_with_box4_node',
        name='move_with_box4_node',
        namespace=namespace,
        output='screen',
        parameters=[])

    fill_item_cmd = Node(
        package='problem5',
        executable='fill_item_node',
        name='fill_item_node',
        namespace=namespace,
        output='screen',
        parameters=[])

    load_carrier_cmd = Node(
        package='problem5',
        executable='load_carrier_node',
        name='load_carrier_node',
        namespace=namespace,
        output='screen',
        parameters=[])

    unloadrobot_cmd = Node(
        package='problem5',
        executable='unloadrobot_node',
        name='unloadrobot_node',
        namespace=namespace,
        output='screen',
        parameters=[])

    empty_box_food_cmd = Node(
        package='problem5',
        executable='empty_box_food_node',
        name='empty_box_food_node',
        namespace=namespace,
        output='screen',
        parameters=[])

    empty_box_medicine_cmd = Node(
        package='problem5',
        executable='empty_box_medicine_node',
        name='empty_box_medicine_node',
        namespace=namespace,
        output='screen',
        parameters=[])
    
    empty_box_tool_cmd = Node(
        package='problem5',
        executable='empty_box_tool_node',
        name='empty_box_tool_node',
        namespace=namespace,
        output='screen',
        parameters=[])





    ld = LaunchDescription()

    # Set environment variables
    ld.add_action(declare_namespace_cmd)

    # Declare the launch options
    ld.add_action(plansys2_cmd)

    ld.add_action(move_cmd)
    ld.add_action(move_with_box_cmd)
    ld.add_action(move_with_box2_cmd)
    ld.add_action(move_with_box3_cmd)
    ld.add_action(move_with_box4_cmd)
    ld.add_action(load_carrier_cmd)
    ld.add_action(fill_item_cmd)
    ld.add_action(unloadrobot_cmd)
    ld.add_action(empty_box_food_cmd)
    ld.add_action(empty_box_medicine_cmd)
    ld.add_action(empty_box_tool_cmd)

    return ld
