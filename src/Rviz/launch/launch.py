from launch import LaunchDescription
from launch_ros.actions import Node

def generate_launch_description():
    with open('/home/redbackbots/Workspace/booster/robocup_demo/src/Rviz/urdf/T1_Serial.urdf', 'r') as infp:
        robot_desc = infp.read()

    return LaunchDescription([
        Node(
            package='robot_state_publisher',
            executable='robot_state_publisher',
            name='robot_state_publisher',
            output='screen',
            parameters=[{'robot_description': robot_desc}]
        )
    ])
