# How to run:

## Requirements

Install TFD:
- cd $HOME
- git clone https://github.com/roveri-marco/tfd
- cd tfd
- ./build
- sudo nano /opt/ros/\<ros-version>/share/plansys2_bringup/params/plansys2_params.yaml
- modify the file by putting TFD instead of POPF in plan_solver_plugins:["POPF"]
- nano ~/.bashrc
- add: export TFD_HOME=$HOME/tfd/downward/
- close terminal, reopen and check "echo $TFD_HOME"

Module plansys2_tfd_plan_solver:

- cd $HOME
- git clone https://github.com/PlanSys2/plansys2_tfd_plan_solver.git
- mv plansys2_tfd_plan_solver tfd_ps
- cd tfd_ps
- colcon build --symlink-install

## Execution:

- cd \<path-to-project-root>/problem5
- source /opt/ros/\<ros-version>/setup.bash
- colcon build --symlink-install
- rosdep install --from-paths src --ignore-src -r -y
- colcon build --symlink-install
- source $HOME/tfd_ps/install/setup.bash
- ros2 launch problem5 launcher.py

in another terminal:
- source /opt/ros/<ros-version>/setup.bash
- ros2 run plansys2_terminal plansys2_terminal 