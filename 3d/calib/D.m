% Load the images
RGB_Left = imread('LRf.png');
IR_Left = imread('LDf.png');


RGB_Right = imread('RRf.png');
IR_Right = imread('RDf.png');

%dc1= -0.0030711016;
%dc2=3.3309495161;

%z = 1.0f / (depth_image(v,u)*dc1+dc2);


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
% Rigid body transformation

% Export point cloud to test
fid = fopen('RigthIRPC.xyz', 'w');
for x = 1:480
    for y = 1:640
        fprintf(fid, '%f %f %f\n', IRZ_Right(x, y),  IRY_Right(x, y), IRX_Right(x, y));
    end
end
fclose(fid);


fid = fopen('LeftIRPC.xyz', 'w');
for x = 1:480
    for y = 1:640
        fprintf(fid, '%f %f %f\n', IRZ_Left(x, y), IRY_Left(x, y), IRX_Left(x, y));
    end
end
fclose(fid);

% Do a rigid body transformation with the extrinsic parameters between the
% ir camera and the rgb camera

Rot = [R(1,1) R(1,2) R(1,3); 
      R(2,1) R(2,2) R(2,3); 
      R(3,1) R(3,2) R(3,3)];
Tr = T;
M45 = [Rot(1,1) Rot(1,2) Rot(1,3) Tr(1);
       Rot(2,1) Rot(2,2) Rot(2,3) Tr(2);
       Rot(3,1) Rot(3,2) Rot(3,3) Tr(2);
       0 0 0 1
    ];
M45 = inv(M45);

% Right Rigid body transformation
fid = fopen('RightIRPC_Rigid.xyz', 'w');
IRX_RB_Right = zeros(480, 640);
IRY_RB_Right = zeros(480, 640);
IRZ_RB_Right = zeros(480, 640);
for x = 1:480
    for y = 1:640
        Point3D = [IRX_Right(x, y) IRY_Right(x, y) IRZ_Right(x, y) 1]';
        % RGBPoint3D = Rot * Point3D + T;
        
        RGBPoint3D = M45*Point3D;
        RGBX = RGBPoint3D(1)/RGBPoint3D(4);
        RGBY = RGBPoint3D(2)/RGBPoint3D(4);
        RGBZ = RGBPoint3D(3)/RGBPoint3D(4);
        
        %RGBX = RGBPoint3D(1);
        %RGBY = RGBPoint3D(2);
        %RGBZ = RGBPoint3D(3);
        IRX_RB_Right(x, y) = RGBX;
        IRY_RB_Right(x, y) = RGBY;
        IRZ_RB_Right(x, y) = RGBZ;
        fprintf(fid, '%f %f %f\n', RGBZ, RGBX, RGBY);
    end
end
fclose(fid);

% Left Rigid body transformation
fid = fopen('LeftIRPC_Rigid.xyz', 'w');
IRX_RB_Left = zeros(480, 640);
IRY_RB_Left = zeros(480, 640);
IRZ_RB_Left = zeros(480, 640);
for x = 1:480
    for y = 1:640
        Point3D = [IRX_Left(x, y) IRY_Left(x, y) IRZ_Left(x, y)]';
        RGBPoint3D = Rot * Point3D + Tr;
        %RGBX = RGBPoint3D(1)/RGBPoint3D(4);
        %RGBY = RGBPoint3D(2)/RGBPoint3D(4);
        %RGBZ = RGBPoint3D(3)/RGBPoint3D(4);
        RGBX = RGBPoint3D(1);
        RGBY = RGBPoint3D(2);
        RGBZ = RGBPoint3D(3);
        IRX_RB_Left(x, y) = RGBX;
        IRY_RB_Left(x, y) = RGBY;
        IRZ_RB_Left(x, y) = RGBZ;
        fprintf(fid, '%f %f %f\n', RGBZ, RGBX, RGBY);
    end
end
fclose(fid);

%%
% Now do the transformation from the 3D X point to the camera RGB using the
% intrinsic parameters from the calibration
%Stereo calibration parameters after loading the individual calibration files

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
fc_right = [ 594.82345   596.71940 ];
cc_right = [ 313.32119   204.22972 ];
% Reproject 3D to 2D on Right RGB
RUV_Right = zeros(480, 640);
GUV_Right = zeros(480, 640);
BUV_Right = zeros(480, 640);
fid = fopen('Right_RGB_PC.xyz', 'w');
for x = 1:480
    for y = 1:640
        Point3D = [IRX_RB_Right(x, y) IRY_RB_Right(x, y) IRZ_RB_Right(x, y)]';
        % Point3D = [IRX_Right(x, y) IRY_Right(x, y) IRZ_Right(x, y)]';
        Point2D(1) = Point3D(1) * fc_right(1) / Point3D(3) + cc_right(1);
        Point2D(2) = Point3D(2) * fc_right(2) / Point3D(3) + cc_right(2);
        % PointUV = [(Point2D(1)/Point2D(3)) (Point2D(2)/Point2D(3))];
        PointUV = [Point2D(1) Point2D(2)];
        x_coord = round(PointUV(1));
        y_coord = round(PointUV(2));
        if x_coord <= 0
            x_coord = 1;
        end
        if y_coord <= 0
            y_coord = 1;
        end
        
        if x_coord > 480
            x_coord = 480;
        end
        if y_coord > 640
            y_coord = 640;
        end
        
        RUV_Right(x, y) = RGB_Right(x_coord, y_coord, 1);
        GUV_Right(x, y) = RGB_Right(x_coord, y_coord, 2);
        BUV_Right(x, y) = RGB_Right(x_coord, y_coord, 3);
        
        % fprintf(fid, '%f %f %f\n', IRZ_RB_Right(x, y), (-1)*IRY_RB_Right(x, y), (-1)*IRX_RB_Right(x, y));
        fprintf(fid, '%f %f %f %f %f %f\n', IRZ_RB_Right(x, y), (-1)*IRY_RB_Right(x, y), (-1)*IRX_RB_Right(x, y), RUV_Right(x, y), GUV_Right(x, y), BUV_Right(x, y));
    end
end
fclose(fid);


%% Now for the Left Camera
fc_left =  [ 550.58847   535.93139 ];
cc_left = [ 372.44464   229.82414 ];
% Reproject 3D to 2D on Right RGB
RUV_Left = zeros(480, 640);
GUV_Left = zeros(480, 640);
BUV_Left = zeros(480, 640);
fid = fopen('Left_RGB_PC.xyz', 'w');
for x = 1:480
    for y = 1:640
        Point3D = [IRX_RB_Left(x, y) IRY_RB_Left(x, y) IRZ_RB_Left(x, y)]';
        % Point3D = [IRX_Left(x, y) IRY_Left(x, y) IRZ_Left(x, y)]';
        Point2D(1) = Point3D(1) * fc_left(1) / double(Point3D(3)) + cc_left(1);
        Point2D(2) = Point3D(2) * fc_left(2) / double(Point3D(3)) + cc_left(2);
        % PointUV = [(Point2D(1)/Point2D(3)) (Point2D(2)/Point2D(3))];
        PointUV = [Point2D(1) Point2D(2)];
        x_coord = round(PointUV(1));
        y_coord = round(PointUV(2));
        if x_coord <= 0
            x_coord = 1;
        end
        if y_coord <= 0
            y_coord = 1;
        end
        
        if x_coord > 480
            x_coord = 480;
        end
        if y_coord > 640
            y_coord = 640;
        end
        
        RUV_Left(x, y) = RGB_Left(x_coord, y_coord, 1);
        GUV_Left(x, y) = RGB_Left(x_coord, y_coord, 2);
        BUV_Left(x, y) = RGB_Left(x_coord, y_coord, 3);
        
        fprintf(fid, '%f %f %f %f %f %f\n', IRZ_RB_Left(x, y), (-1)*IRY_RB_Left(x, y), (-1)*IRX_RB_Left(x, y), RUV_Left(x, y), GUV_Left(x, y), BUV_Left(x, y));
    end
end
fclose(fid);

