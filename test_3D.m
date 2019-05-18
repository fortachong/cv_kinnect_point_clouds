% Load the images
%RGB_Left = imread('LRf.png');
%IR_Left = imread('LDf.png');

%RGB_Right = imread('RRf.png');
%IR_Right = imread('RDf.png');
RGB_Left = imread('LR9.png');
IR_Left = imread('LD9.png');

RGB_Right = imread('RR9.png');
IR_Right = imread('RD9.png');

HeatMap(IR_Left);
image(RGB_Left);

% Kinect Depth camera parameters
fx_d = 5.7616540758591043e+02;
fy_d = 5.7375619782082447e+02;
cx_d = 3.2442516903961865e+02;
cy_d = 2.3584766381177013e+02;

% Extrinsic parameters between RGB and Depth camera for Kinect V1
% Rotation matrix
R =  inv([  9.9998579449446667e-01, 3.4203777687649762e-03, -4.0880099301915437e-03;
    -3.4291385577729263e-03, 9.9999183503355726e-01, -2.1379604698021303e-03;
    4.0806639192662465e-03, 2.1519484514690057e-03,  9.9998935859330040e-01]);

% Translation vector.
T = -[  2.2142187053089738e-02, -1.4391632009665779e-04, -7.9356552371601212e-03 ]';

% For each point in Left and Right Camera:
IRX_Right = zeros(480, 640);
IRY_Right = zeros(480, 640);
IRZ_Right = zeros(480, 640);
% Transform the Grid Coordinates
for x = 1:480
    for y = 1:640
        Z = IR_Right(x, y);
        IRX_Right(x, y) = ((x - cx_d)/fx_d) * double(Z);
        IRY_Right(x, y) = (y - cy_d) * double(Z) / fy_d;
        IRZ_Right(x, y) = Z;
    end
end

IRX_Left = zeros(480, 640);
IRY_Left = zeros(480, 640);
IRZ_Left = zeros(480, 640);
% Transform the Grid Coordinates
for x = 1:480
    for y = 1:640
        Z = IR_Left(x, y);
        IRX_Left(x, y) = ((x - cx_d)/fx_d) * double(Z);
        IRY_Left(x, y) = (y - cy_d) * double(Z) / fy_d;
        IRZ_Left(x, y) = Z;
    end
end
% Rigid body transformation




% Export point cloud to test
fid = fopen('RigthIRPCtest.xyz', 'w');
for x = 1:480
    for y = 1:640
        fprintf(fid, '%f %f %f %f %f %f\n', IRZ_Right(x, y), (-1) * IRY_Right(x, y), (-1) * IRX_Right(x, y),  RGB_Right(x, y, 1), RGB_Right(x, y, 2), RGB_Right(x, y, 3));
    end
end
fclose(fid);


fid = fopen('LeftIRPCtest.xyz', 'w');
for x = 1:480
    for y = 1:640
        fprintf(fid, '%f %f %f %f %f %f\n', IRZ_Left(x, y), (-1) * IRY_Left(x, y), (-1) * IRX_Left(x, y), RGB_Left(x, y, 1), RGB_Left(x, y, 2), RGB_Left(x, y, 3));
    end
end
fclose(fid);
