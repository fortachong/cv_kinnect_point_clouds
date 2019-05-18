
% Load the images
RGB_Left = imread('LRf.png');
IR_Left = imread('LDf.png');

RGB_Right = imread('RRf.png');
IR_Right = imread('RDf.png');
%RGB_Left = imread('LR9.png');
%IR_Left = imread('LD9.png');

%RGB_Right = imread('RR9.png');
%IR_Right = imread('RD9.png');


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
for i = 1:480
    for j = 1:640
        Z = IR_Right(i, j);
        IRX_Right(i, j) = ((j-1 - cx_d)/fx_d) * double(Z);
        IRY_Right(i, j) = ((i-1 - cy_d)/fy_d) * double(Z);
        IRZ_Right(i, j) = Z;
    end
end

IRX_Left = zeros(480, 640);
IRY_Left = zeros(480, 640);
IRZ_Left = zeros(480, 640);
% Transform the Grid Coordinates
for i = 1:480
    for j = 1:640
        Z = IR_Left(i, j);
        IRX_Left(i, j) = ((j-1 - cx_d)/fx_d) * double(Z);
        IRY_Left(i, j) = ((i-1 - cy_d)/fy_d) * double(Z);
        IRZ_Left(i, j) = double(Z);
    end
end

% Export point cloud to test
% Right Point Clouds
fid = fopen('RigthIRPC.xyz', 'w');
for x = 1:480
    for y = 1:640
        fprintf(fid, '%f %f %f\n', IRZ_Right(x, y), -IRX_Right(x, y), -IRY_Right(x, y));
    end
end
fclose(fid);
% Left Point Clouds
fid = fopen('LeftIRPC.xyz', 'w');
for x = 1:480
    for y = 1:640
        fprintf(fid, '%f %f %f\n', IRZ_Left(x, y), -IRX_Left(x, y), -IRY_Left(x, y));
    end
end
fclose(fid);


%% Get the color corresponding to a Point in IR projected world:

% 1. Right IR to RGB:
IR2RGB_Right_X = zeros(480, 640);
IR2RGB_Right_Y = zeros(480, 640);
IR2RGB_Right_Z = zeros(480, 640);
for i = 1:480
    for j = 1:640
        Point3D = [IRX_Right(i, j) IRY_Right(i, j) IRZ_Right(i, j)]';
        % Change reference:
        NewPoint3D = R*Point3D + T;
        IR2RGB_Right_X(i, j) = NewPoint3D(1);
        IR2RGB_Right_Y(i, j) = NewPoint3D(2);
        IR2RGB_Right_Z(i, j) = NewPoint3D(3);
    end
end
% 2. To Pixel coordinates in Right RGB:
% Data from calibration of Right RGB camera:
%Intrinsic parameters of right camera:

%Focal Length:          fc_right = [ 594.82345   596.71940 ] ± [ 33.54462   42.40504 ]
%Principal point:       cc_right = [ 313.32119   204.22972 ] ± [ 48.81210   40.46981 ]
%Skew:             alpha_c_right = [ 0.00000 ] ± [ 0.00000  ]   => angle of pixel axes = 90.00000 ± 0.00000 degrees
%Distortion:            kc_right = [ 0.36731   -0.23886   -0.06112   -0.00334  0.00000 ] ± [ 0.34684   2.78035   0.04327   0.05616  0.00000 ]

fc_right = [ 594.82345   596.71940 ];
cc_right = [ 313.32119   204.22972 ];
ColorIndexes_Right_R = zeros(480, 640);
ColorIndexes_Right_G = zeros(480, 640);
ColorIndexes_Right_B = zeros(480, 640);

for i = 1:480
    for j = 1:640
        U = IR2RGB_Right_X(i, j) * fc_right(1) / IR2RGB_Right_Z(i, j) + cc_right(1);
        V = IR2RGB_Right_Y(i, j) * fc_right(2) / IR2RGB_Right_Z(i, j) + cc_right(2);
        
        Index_i = round(U);
        Index_j = round(V);
        if Index_i <= 0
            Index_i = 1;
        end
        if Index_j <= 0
            Index_j = 1;
        end
        
        if Index_i > 480
            Index_i = 480;
        end
        if Index_j > 640
            Index_j = 640;
        end
        
        ColorIndexes_Right_R(i, j) = RGB_Right(i, j, 1);
        ColorIndexes_Right_G(i, j) = RGB_Right(i, j, 2);
        ColorIndexes_Right_B(i, j) = RGB_Right(i, j, 3);
    end
end

%% Creates a Point Cloud in 3D space for future reference for the Right
fid = fopen('Right3D.xyz', 'w');
for i = 1:480
    for j = 1:640
        fprintf(fid, '%f %f %f %f %f %f\n', IR2RGB_Right_Z(i, j), -IR2RGB_Right_X(i, j), -IR2RGB_Right_Y(i, j), ColorIndexes_Right_R(i, j), ColorIndexes_Right_G(i, j), ColorIndexes_Right_B(i, j));
        % fprintf(fid, '%f %f %f %f %f %f\n', IR2RGB_Right_Z(i, j), -IR2RGB_Right_X(i, j), -IR2RGB_Right_Y(i, j), RGB_Right(i, j, 1), RGB_Right(i, j, 2), RGB_Right(i, j, 3));
    end
end
fclose(fid);

%% Do the same for the Left RGB camera
% 1. Left IR to RGB:
IR2RGB_Left_X = zeros(480, 640);
IR2RGB_Left_Y = zeros(480, 640);
IR2RGB_Left_Z = zeros(480, 640);
for i = 1:480
    for j = 1:640
        Point3D = [IRX_Left(i, j) IRY_Left(i, j) IRZ_Left(i, j)]';
        % Change reference:
        NewPoint3D = R*Point3D + T;
        IR2RGB_Left_X(i, j) = NewPoint3D(1);
        IR2RGB_Left_Y(i, j) = NewPoint3D(2);
        IR2RGB_Left_Z(i, j) = NewPoint3D(3);
    end
end
% 2. To Pixel coordinates in Left RGB:
%Intrinsic parameters of left camera:

%Focal Length:          fc_left = [ 515.98373   506.36716 ] ± [ 32.08629   29.01246 ]
%Principal point:       cc_left = [ 356.82633   223.83975 ] ± [ 33.34426   21.78764 ]
%Skew:             alpha_c_left = [ 0.00000 ] ± [ 0.00000  ]   => angle of pixel axes = 90.00000 ± 0.00000 degrees
%Distortion:            kc_left = [ 0.54143   -1.02578   -0.02251   0.07919  0.00000 ] ± [ 0.25389   0.90103   0.02223   0.05348  0.00000 ]
fc_left = [ 515.98373   506.36716 ];
cc_left = [ 356.82633   223.83975 ];
ColorIndexes_Left_R = zeros(480, 640);
ColorIndexes_Left_G = zeros(480, 640);
ColorIndexes_Left_B = zeros(480, 640);

for i = 1:480
    for j = 1:640
        U = IR2RGB_Left_X(i, j) * fc_left(1) / IR2RGB_Left_Z(i, j) + cc_left(1);
        V = IR2RGB_Left_Y(i, j) * fc_left(2) / IR2RGB_Left_Z(i, j) + cc_left(2);
        
        Index_i = round(U);
        Index_j = round(V);
        if Index_i <= 0
            Index_i = 1;
        end
        if Index_j <= 0
            Index_j = 1;
        end
        
        if Index_i > 480
            Index_i = 480;
        end
        if Index_j > 640
            Index_j = 640;
        end
        
        ColorIndexes_Left_R(i, j) = RGB_Left(i, j, 1);
        ColorIndexes_Left_G(i, j) = RGB_Left(i, j, 2);
        ColorIndexes_Left_B(i, j) = RGB_Left(i, j, 3);
    end
end

%% Creates a Point Cloud in 3D space for future reference for the Left
fid = fopen('Left3D_V0.xyz', 'w');
for i = 1:480
    for j = 1:640
        % fprintf(fid, '%f %f %f %f %f %f\n', IR2RGB_Left_Z(i, j), -IR2RGB_Left_X(i, j), -IR2RGB_Left_Y(i, j), ColorIndexes_Left_R(i, j), ColorIndexes_Left_G(i, j), ColorIndexes_Left_B(i, j));
        fprintf(fid, '%f %f %f %f %f %f\n', IR2RGB_Left_Z(i, j), -IR2RGB_Left_X(i, j), -IR2RGB_Left_Y(i, j), RGB_Left(i, j, 1), RGB_Left(i, j, 2), RGB_Left(i, j, 3));
    end
end
fclose(fid);

%% Convert 3D Cloud in Left to the Right using the stereo calibration matrix
%Rotation vector:             om = [ -0.08170   0.75781  -0.07675 ]
%Translation vector:           T = [ -711.50008   61.41676  500.67368 ]
Rot = [ -0.08170   0.75781  -0.07675 ]';
Rot_matrix = rotationVectorToMatrix(Rot);
Rot_matrix = inv(Rot_matrix);

Trans = [ -711.50008   61.41676-85  500.67368-200 ]';
RGB_L2R_X = zeros(480, 640);
RGB_L2R_Y = zeros(480, 640);
RGB_L2R_Z = zeros(480, 640);
for i = 1:480
    for j = 1:640
        Point3D = [IR2RGB_Left_X(i, j) IR2RGB_Left_Y(i, j) IR2RGB_Left_Z(i, j)]';
        NewPoint3D = Rot_matrix * Point3D + Trans;
        
        RGB_L2R_X(i, j) = NewPoint3D(1);
        RGB_L2R_Y(i, j) = NewPoint3D(2);
        RGB_L2R_Z(i, j) = NewPoint3D(3);
    end
end

%% Store in 2 files
fid1 = fopen('Left2Rigth.xyz', 'w');
fid2 = fopen('Final.xyz', 'w');
for i = 1:480
    for j = 1:640
        fprintf(fid1, '%f %f %f %f %f %f\n', RGB_L2R_Z(i, j), -RGB_L2R_X(i, j), -RGB_L2R_Y(i, j), ColorIndexes_Left_R(i, j), ColorIndexes_Left_G(i, j), ColorIndexes_Left_B(i, j));
        fprintf(fid2, '%f %f %f %f %f %f\n', RGB_L2R_Z(i, j), -RGB_L2R_X(i, j), -RGB_L2R_Y(i, j), ColorIndexes_Left_R(i, j), ColorIndexes_Left_G(i, j), ColorIndexes_Left_B(i, j));
        fprintf(fid2, '%f %f %f %f %f %f\n', IR2RGB_Right_Z(i, j), -IR2RGB_Right_X(i, j), -IR2RGB_Right_Y(i, j), ColorIndexes_Right_R(i, j), ColorIndexes_Right_G(i, j), ColorIndexes_Right_B(i, j));
    end
end
fclose(fid1);
fclose(fid2);

%% pcshow
PCX1 = reshape(IR2RGB_Right_X, 480 * 640, 1);
PCY1 = reshape(IR2RGB_Right_Y, 480 * 640, 1);
PCZ1 = reshape(IR2RGB_Right_Z, 480 * 640, 1);

CR1 = reshape(ColorIndexes_Right_R, 480 * 640, 1);
CG1 = reshape(ColorIndexes_Right_G, 480 * 640, 1);
CB1 = reshape(ColorIndexes_Right_B, 480 * 640, 1);

PCX2 = reshape(RGB_L2R_X, 480 * 640, 1);
PCY2 = reshape(RGB_L2R_Y, 480 * 640, 1);
PCZ2 = reshape(RGB_L2R_Z, 480 * 640, 1);

CR2 = reshape(ColorIndexes_Left_R, 480 * 640, 1);
CG2 = reshape(ColorIndexes_Left_G, 480 * 640, 1);
CB2 = reshape(ColorIndexes_Left_B, 480 * 640, 1);

PCX = [PCX1; PCX2];
PCY = [PCY1; PCY2];
PCZ = [PCZ1; PCZ2];
CR = [CR1; CR2];
CG = [CG1; CG2];
CB = [CB1; CB2];
pcshow([PCX -PCY -PCZ], [CR./256 CG./256 CB./256]);