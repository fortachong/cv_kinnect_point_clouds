% Load the images
RGB_Left = imread('LRf.png');
IR_Left = imread('LDf.png');

RGB_Right = imread('RRf.png');
IR_Right = imread('RDf.png');

%% We found this in a book, but we don't use it
%dc1= -0.0030711016;
%dc2=3.3309495161;
%z = 1.0f / (depth_image(v,u)*dc1+dc2);

%% KINECT Parameters
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

%% Step 1. For each point in the pixel coordinates, project
% to the 3D space in each IR camera sensor coordinate frame

% For each point in Left and Right Camera:
IRX_Right = zeros(480, 640);
IRY_Right = zeros(480, 640);
IRZ_Right = zeros(480, 640);
% Transform the Grid Coordinates
for x = 1:480
    for y = 1:640
        Z = IR_Right(x, y);
        IRX_Right(x, y) = ((x - cx_d)/fx_d) * double(Z);
        IRY_Right(x, y) = ((y - cy_d)/fy_d) * double(Z);
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
        IRY_Left(x, y) = ((y - cy_d)/fy_d) * double(Z);
        IRZ_Left(x, y) = double(Z);
    end
end

% Export point cloud to test
% Right Point Clouds
fid = fopen('RigthIRPC.xyz', 'w');
for x = 1:480
    for y = 1:640
        fprintf(fid, '%f %f %f\n', IRZ_Right(x, y),  IRY_Right(x, y), IRX_Right(x, y));
    end
end
fclose(fid);
% Left Point Clouds
fid = fopen('LeftIRPC.xyz', 'w');
for x = 1:480
    for y = 1:640
        fprintf(fid, '%f %f %f\n', IRZ_Left(x, y), IRY_Left(x, y), IRX_Left(x, y));
    end
end
fclose(fid);

%% Transform the coordinates to the Left RGB camera coordinate system using 
% data from the stereo calibration
%Intrinsic parameters of left camera:

%Focal Length:          fc_left = [ 515.98373   506.36716 ] ± [ 32.08629   29.01246 ]
%Principal point:       cc_left = [ 356.82633   223.83975 ] ± [ 33.34426   21.78764 ]
%Skew:             alpha_c_left = [ 0.00000 ] ± [ 0.00000  ]   => angle of pixel axes = 90.00000 ± 0.00000 degrees
%Distortion:            kc_left = [ 0.54143   -1.02578   -0.02251   0.07919  0.00000 ] ± [ 0.25389   0.90103   0.02223   0.05348  0.00000 ]


%Intrinsic parameters of right camera:

%Focal Length:          fc_right = [ 594.82345   596.71940 ] ± [ 33.54462   42.40504 ]
%Principal point:       cc_right = [ 313.32119   204.22972 ] ± [ 48.81210   40.46981 ]
%Skew:             alpha_c_right = [ 0.00000 ] ± [ 0.00000  ]   => angle of pixel axes = 90.00000 ± 0.00000 degrees
%Distortion:            kc_right = [ 0.36731   -0.23886   -0.06112   -0.00334  0.00000 ] ± [ 0.34684   2.78035   0.04327   0.05616  0.00000 ]


%Extrinsic parameters (position of right camera wrt left camera):

%Rotation vector:             om = [ -0.08170   0.75781  -0.07675 ]
%Translation vector:           T = [ -711.50008   61.41676  500.67368 ]

Rot = [ 0.75781 -0.08170 -0.07675 ]';
Rot_Matrix = rotationVectorToMatrix(Rot);
Tr =  [ 61.41676 -711.50008 500.67368 ]';
% Tr = [ 61.41676-90 -711.50008-7 500.67368-97 ]';
% Tr = [ 61.41676-90 -711.50008-7 500.67368-77 ]';
% Tr = [ 61.41676-90 -711.50008-7 500.67368-77+20 ]';

IRX_R_L = zeros(480, 640);
IRY_R_L = zeros(480, 640);
IRZ_R_L = zeros(480, 640);

fid_1 = fopen('Final_D3.xyz', 'w');
fid_2 = fopen('Final_D3_Right.xyz', 'w');
fid_3 = fopen('Final_D3_Left_to_Right.xyz', 'w');
for x = 1:480
    for y = 1:640
        Point3D = [IRX_Left(x, y) IRY_Left(x, y) IRZ_Left(x, y)]';
        
        % Point3D = [IRX_Right(x, y) IRY_Right(x, y) IRZ_Right(x, y) 1]';
        
        Point3D_R_L = Rot_Matrix * Point3D + Tr;
        IRX_R_L(x, y) = Point3D_R_L(1);
        IRY_R_L(x, y) = Point3D_R_L(2);
        IRZ_R_L(x, y) = Point3D_R_L(3);
               
        fprintf(fid_1, '%f %f %f %f %f %f\n', IRZ_Right(x, y), (-1)*IRY_Right(x, y), (-1)*IRX_Right(x, y), RGB_Right(x, y, 1), RGB_Right(x, y, 2), RGB_Right(x, y, 3));
        fprintf(fid_1, '%f %f %f %f %f %f\n', IRZ_R_L(x, y), (-1)*IRY_R_L(x, y), (-1)*IRX_R_L(x, y), RGB_Left(x, y, 1), RGB_Left(x, y, 2), RGB_Left(x, y, 3));
        
        fprintf(fid_2, '%f %f %f %f %f %f\n', IRZ_Right(x, y), (-1)*IRY_Right(x, y), (-1)*IRX_Right(x, y), RGB_Right(x, y, 1), RGB_Right(x, y, 2), RGB_Right(x, y, 3));
        fprintf(fid_3, '%f %f %f %f %f %f\n', IRZ_R_L(x, y), (-1)*IRY_R_L(x, y), (-1)*IRX_R_L(x, y), RGB_Left(x, y, 1), RGB_Left(x, y, 2), RGB_Left(x, y, 3));
    end
end
fclose(fid_1);
fclose(fid_2);
fclose(fid_3);

