# Reader Automation scripts for EECS 31L  

This repository is aimed to maintain and improve automating scripts for 
grading labs for EECS 31L - Intro to Digital Logic Lab. The main objectives of the 
script is as follows:

* Simplify extracting and organizing student submissions to grade both testbench and design
* Automate compilation and waveform generation to speed up the process. 
* Some degree of error handling such as prompting when filenames are wrong, or when module names are incorrect, allowing
for fixing from reader's side to minimize the need of manual grading. 
* Generate a final csv of graded and failed submissions in order to integrate with gradescope. 

## Dependencies

The current script uses Icarus Verilog compiler and simulator, and gtkwave for waveform analysis. 
The reason for choosing these is they are both available on Linux and Windows platforms and can be used 
very easily using the command line. 

Since student will be working on Vivado, it is recommended to ask students to add an initial block in 
their testbench to dump the waveforms so that it is accessible by gtkwave. Otherwise, the script 
is designed to pause before testbench grading and prompts the user to add code to the testbench manually 
before continuing the grading. 


## Script flow

The script flow is as mentioned below. 

* Extract submission from zipfile and walk through directories to extract source code folder. 
* Check if expected files are found in source code. Reader to provide expected file list. 
    * Students are expected to follow strict filenames and module names. 
* Extract design files and run them along with batch testbench with rubric included and show output in 
terminal (designGrading folder)
* If above fails, individual design files are extracted and run with their appropriate golden testbench. (manualGrading folder)
    * Expected that golden testbenches are subsets of testbench_with_rubric, showing points awarded. 
* Prompt user to enter the grade. 
    * Prompt is given since tesbench with rubric is difficult to parse and extract value. 
    It is easier for user to read output and enter in prompt.
* Extract testbench files, pair with golden design files, compile and run
* Assuming that waveform dumping is included, run gtkwave to pull up the waveform for analysis. 
* Prompt user to enter grade for testbench. 
* Prompt user to enter report grade. 
* Add the grades and write into csv file. 

## Quick improvements. 

* Right now, all expected files are hardcoded as global variables. Can make them CLI friendly, or parse a textfile containing filenames
and dependencies. 

