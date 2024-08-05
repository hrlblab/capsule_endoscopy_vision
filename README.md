# Dual_Camera_3D_Visualization
for John's VISE summer project

Introduction
This repository contains MATLAB code developed for a research project titled "Dual Camera Localization and Orientation Tracking for Esophageal Endoscopic Applications." The project aims to enhance capsule endoscopy by implementing a dual-camera system that precisely tracks localization and orientation. The code provides a way to visualize the movement of points in 3D space and calculate angles with respect to XY and XZ planes, using data obtained from the dual-camera system.

Overview of the Code
This MATLAB script animates the movement of two points (red and blue) in 3D space using data imported from an Excel spreadsheet named Results.csv. The script calculates and displays angles between the points concerning the XY-plane and XZ-plane. Additionally, it provides both a zoomed-out and zoomed-in view of the points' movement, helping visualize the 3D trajectory.

Key Components:
Data Import:

The code reads coordinates from Results.csv to obtain the x, y, and z positions for both the red and blue points.
The structure of Results.csv should have six columns:
The first three columns represent the blue point's coordinates (x, y, z).
The next three columns represent the red point's coordinates (x, y, z).
3D Visualization:

Two figures are generated:
Figure 1: A zoomed-in view focused on the immediate vicinity of the points.
Figure 2: A zoomed-out view that provides a broader context of the movement.
Red and blue points are plotted, and a line is drawn between them to show their connection.
Angle Calculation:

The angles between the two points and the XY-plane and XZ-plane are calculated and displayed in real-time.
Text boxes update these angles for each frame of the animation, offering insights into the relative positioning of the points.
Animation:

The code animates the movement of the points, allowing the user to observe their trajectories over time.
A timer displays the elapsed time for the animation.
Using the Code
To use the code, follow these steps:

Prepare the Excel File:

Make sure your data is in an Excel file named Results.csv with the specified structure.
Run the MATLAB Script:

Open MATLAB.
Ensure the script and the Results.csv file are in the same directory.
Run the script. The animation will display in two separate figures, showing the zoomed-in and zoomed-out views.
Interpret the Results:

The red and blue dots represent tracked points, with lines connecting them.
Angles with respect to the XY and XZ planes are updated in real-time.
Generating the Results.csv with Fiji
To obtain the data required for Results.csv, you can use Fiji (an open-source image processing package). Here's how to use Fiji to extract the necessary information:

Capture Images: (See Camera Setup.png)

Use your dual-camera system (with overhead and side view cameras) to capture synchronized images of the target object.
Process with Fiji:

Open Fiji and load your image sequence.
Use Fiji's built-in tools to detect the points of interest in the images.
Extract the coordinates of these points and export them to a CSV file.
Format the CSV:

Make sure the exported CSV matches the expected format for the MATLAB script (blue point: x, y, z; red point: x, y, z).
Rename the CSV to Results.csv and place it in the same directory as the MATLAB script.
