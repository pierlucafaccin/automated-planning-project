# How to run:


- cd $HOME
- git clone https://github.com/roveri-marco/tfd
- cd tfd
- ./build
- sudo nano /opt/ros/humble/share/plansys2_bringup/params/plansys2_params.yaml
- modify the file by putting TFD instead of POPF in plan_solver_plugins:["POPF"]
- nano ~/.bashrc
- add: export TFD_HOME=/home/alessandro/tfd/downward/
- close terminal, reopen and check "echo $TFD_HOME"


Execution:
- source /opt/ros/<ros-version>/setup.bash
- colcon build --symlink-install
- rosdep install --from-paths src --ignore-src -r -y
- colcon build --symlink-install
- source install/setup.bash
- ros2 launch problem5 launcher.py

in another terminal:
- source /opt/ros/<ros-version>/setup.bash
- ros2 run plansys2_terminal plansys2_terminal 