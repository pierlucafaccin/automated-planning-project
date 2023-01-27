# Automated Planning: Theory and Practice

This repository contains the project developed by Alessandro Zinni and Pierluca Faccin for the master's degree in Artificial Intelligence Systems at the University of Trento.

## Overview

This project is focused on the field of automated planning and covers various aspects of the theory and practice of planning. The repository contains 5 folders, each of which presents the domain and problem files for each assigned problem.

## Folders

- Problem1: Contains the domain and problem files for the first assigned problem and the results.txt to see the plan generated.
- Problem2: Contains the domain and problem files for the second assigned problem in 2 versions: with and without fluents, with the respective results .txt files.
- Problem3: Contains the domain and problem files for the third assigned problem and the results.txt to see the plan generated.
- Problem4: Contains the domain and problem (2 versions: one simpler than the other) files for the fourth assigned problem and the results.txt to see the plan generated.
- Problem5: Contains CMakeLists.txt, package.xml, launch/commands (which contains all the necessary instances, predicates and goals for our problem),
launch/launcher.py (which contains the code to select the domain and run the executables that implement the PDDL actions), pddl/domain-simple.pddl (which contains the domain file of the Problem 4), src (which contains all the C++ APIs implementation), results.txt (which contains the generated plan), run.md (which contains all the instructions to run the code).

## Usage

To use the files in this repository, you will need a planning system such as Fast Downward or any other PDDL-compatible planner. The domain and problem files can be used as input to the planner to generate a plan to solve the corresponding problem. Make sure to read each ReadMe.md file in each folder, to understand how and which planner to choose.

## Contributions

This project was developed by [Alessandro Zinni](https://github.com/Zinni98) and [Pierluca Faccin](https://github.com/pierlucafaccin) as part of their master's degree studies at the University of Trento. If you have any questions or suggestions, please feel free to contact us or open an issue on this repository.

