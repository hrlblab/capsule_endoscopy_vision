% Step 1: Import data from Excel
data = xlsread('Results.csv');  % Replace with your file path

% Extract data for blue point (first 3 columns) and red point (next 3 columns)
x0 = data(:, 1);
y0 = data(:, 2);
z0 = data(:, 3);

x1 = data(:, 4);
y1 = data(:, 5);
z1 = data(:, 6);

% Step 2: Set up main 3D plot (Figure 2 - Zoomed-Out View)
figure;
axis equal;  % Equal scaling for x, y, and z axes
margin = 100;  % Increase this value to zoom out more
xmin = 0;
xmax = max([x0; x1]) + margin;
ymin = 0;
ymax = max([y0; y1]) + margin;
zmin = 0;
zmax = max([z0; z1]) + margin;
axis([xmin xmax ymin ymax zmin zmax]);  % Set axis limits based on data range with additional margin
xlabel('X (mm)');
ylabel('Y (mm)');
zlabel('Z (mm)');
title('Zoomed-Out View of Points Movement');
view(3);  % Set the default view to 3D

grid on;  % Turn on the grid
xticks(linspace(xmin, xmax, 10));  % Set x-axis ticks
yticks(linspace(ymin, ymax, 10));  % Set y-axis ticks
zticks(linspace(zmin, zmax, 10));  % Set z-axis ticks

hold on;

% Angle display text boxes
angle_text_xy = uicontrol('Style', 'text', 'Position', [100 250 300 20], ...
    'String', 'Angle with XY-plane: ', 'HorizontalAlignment', 'left');

angle_text_xz = uicontrol('Style', 'text', 'Position', [100 280 300 20], ...
    'String', 'Angle with XZ-plane: ', 'HorizontalAlignment', 'left');

% Timer display
timer_display = uicontrol('Style', 'text', 'Position', [100 220 120 20], ...
    'String', 'Time: 0 s');

% Initialize red and blue points in the main plot (Figure 2)
h_point0 = plot3(x0(1), y0(1), z0(1), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
h_point1 = plot3(x1(1), y1(1), z1(1), 'bo', 'MarkerSize', 10, 'MarkerFaceColor', 'b');

% Initialize line connecting the points in the main plot (Figure 2)
line_connect = plot3([x0(1), x1(1)], [y0(1), y1(1)], [z0(1), z1(1)], 'k-', 'LineWidth', 2);

% Initialize trails in the main plot (Figure 2)
trail0 = animatedline('Color', 'r', 'LineWidth', 1.5);
trail1 = animatedline('Color', 'b', 'LineWidth', 1.5);

% Zoomed-in view parameters
zoom_factor = 2;  % Zoom factor
zoomed_in_radius = 50;  % Radius around points for zoomed-in view

% Step 3: Set up zoomed-in plot (Figure 1)
figure;
axis equal;  % Equal scaling for x, y, and z axes
xlabel('X (mm)');
ylabel('Y (mm)');
zlabel('Z (mm)');
title('Zoomed-In View of Points Movement');
view(3);  % Set the default view to 3D

grid on;  % Turn on the grid

hold on;

% Initialize red and blue points in the zoomed-in plot (Figure 1)
h_point0_zoomed = plot3(x0(1), y0(1), z0(1), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
h_point1_zoomed = plot3(x1(1), y1(1), z1(1), 'bo', 'MarkerSize', 10, 'MarkerFaceColor', 'b');

% Initialize line connecting the points in the zoomed-in plot (Figure 1)
line_connect_zoomed = plot3([x0(1), x1(1)], [y0(1), y1(1)], [z0(1), z1(1)], 'k-', 'LineWidth', 2);

% Animation loop
fps = 41.5;  % Frames per second
frame_duration = 1 / fps;  % Duration of each frame in seconds
num_frames = min(length(x0), length(x1));

start_time = tic;  % Start a timer

% Initialize arrays to store angles
angles_xy = zeros(num_frames, 1);
angles_xz = zeros(num_frames, 1);

for i = 1:num_frames  % Loop through the frames
    % Clear angle displays
    angle_display_xy = '';
    angle_display_xz = '';

    % Update the position of the red and blue points in Figure 2 (main plot)
    set(h_point0, 'XData', x0(i), 'YData', y0(i), 'ZData', z0(i));
    set(h_point1, 'XData', x1(i), 'YData', y1(i), 'ZData', z1(i));

    % Update line connecting the points in Figure 2 (main plot)
    set(line_connect, 'XData', [x0(i), x1(i)], 'YData', [y0(i), y1(i)], 'ZData', [z0(i), z1(i)]);

    % Update trails in Figure 2 (main plot)
    addpoints(trail0, x0(i), y0(i), z0(i));
    addpoints(trail1, x1(i), y1(i), z1(i));

    % Update the position of the red and blue points in Figure 1 (zoomed-in plot)
    set(h_point0_zoomed, 'XData', x0(i), 'YData', y0(i), 'ZData', z0(i));
    set(h_point1_zoomed, 'XData', x1(i), 'YData', y1(i), 'ZData', z1(i));

    % Update line connecting the points in Figure 1 (zoomed-in plot)
    set(line_connect_zoomed, 'XData', [x0(i), x1(i)], 'YData', [y0(i), y1(i)], 'ZData', [z0(i), z1(i)]);

    % Update zoomed-in axis limits based on the current positions
    center_x = (x0(i) + x1(i)) / 2;
    center_y = (y0(i) + y1(i)) / 2;
    center_z = (z0(i) + z1(i)) / 2;
    axis([center_x-zoomed_in_radius, center_x+zoomed_in_radius, ...
          center_y-zoomed_in_radius, center_y+zoomed_in_radius, ...
          center_z-zoomed_in_radius, center_z+zoomed_in_radius]);

    % Update timer display
    elapsed_time = toc(start_time);
    set(timer_display, 'String', sprintf('Time: %.1f s', elapsed_time));

    % Calculate angles with respect to XY-plane and XZ-plane
    angle_xy = atan2d(z1(i) - z0(i), norm([x1(i) - x0(i), y1(i) - y0(i)]));  % Angle with XY-plane
    angle_xz = atan2d(y1(i) - y0(i), norm([x1(i) - x0(i), z1(i) - z0(i)]));  % Angle with XZ-plane

    % Store angles for display
    angles_xy(i) = angle_xy;
    angles_xz(i) = angle_xz;

    % Update angle display text boxes with 3 decimal places
    set(angle_text_xy, 'String', sprintf('Angle with XY-plane: %.3f degrees', angle_xy));
    set(angle_text_xz, 'String', sprintf('Angle with XZ-plane: %.3f degrees', angle_xz));

    % Pause for the appropriate amount of time to maintain desired fps
    pause(frame_duration);
end
