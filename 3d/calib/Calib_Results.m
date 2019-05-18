% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 597.912817607340910 ; 601.285236162186490 ];

%-- Principal point:
cc = [ 306.743928306264590 ; 209.641187908132760 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.425014924549472 ; -0.441888115238060 ; -0.063008706046885 ; -0.013207941159804 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 14.398883501475465 ; 17.999604341326286 ];

%-- Principal point uncertainty:
cc_error = [ 19.656941139138041 ; 16.821643177192293 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.143142658921549 ; 1.022194447527829 ; 0.018540087030604 ; 0.024698382987545 ; 0.000000000000000 ];

%-- Image size:
nx = 640;
ny = 480;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 10;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ -2.102883e+00 ; -2.074344e+00 ; 7.744047e-01 ];
Tc_1  = [ -4.612658e+00 ; -9.176139e+01 ; 2.169159e+03 ];
omc_error_1 = [ 2.307278e-02 ; 1.700994e-02 ; 3.685114e-02 ];
Tc_error_1  = [ 7.075795e+01 ; 6.030878e+01 ; 5.242797e+01 ];

%-- Image #2:
omc_2 = [ 2.029275e+00 ; 2.065068e+00 ; -3.374893e-01 ];
Tc_2  = [ -8.268005e+01 ; -1.158701e+02 ; 2.073145e+03 ];
omc_error_2 = [ 2.630448e-02 ; 2.126532e-02 ; 4.928660e-02 ];
Tc_error_2  = [ 6.812699e+01 ; 5.771054e+01 ; 4.760046e+01 ];

%-- Image #3:
omc_3 = [ -1.708482e+00 ; -1.512601e+00 ; 1.130764e+00 ];
Tc_3  = [ 7.882390e+01 ; -8.005660e+01 ; 2.215278e+03 ];
omc_error_3 = [ 2.662049e-02 ; 2.411294e-02 ; 3.378535e-02 ];
Tc_error_3  = [ 7.277672e+01 ; 6.195397e+01 ; 4.890985e+01 ];

%-- Image #4:
omc_4 = [ 1.736988e+00 ; 1.972766e+00 ; -1.133046e+00 ];
Tc_4  = [ 4.637035e+01 ; 3.012575e+01 ; 2.330567e+03 ];
omc_error_4 = [ 2.266561e-02 ; 2.552184e-02 ; 3.739515e-02 ];
Tc_error_4  = [ 7.692475e+01 ; 6.522417e+01 ; 5.322928e+01 ];

%-- Image #5:
omc_5 = [ -2.034617e+00 ; -1.886718e+00 ; 4.542965e-01 ];
Tc_5  = [ -7.402222e+01 ; -1.096961e+02 ; 2.050031e+03 ];
omc_error_5 = [ 2.576102e-02 ; 2.649513e-02 ; 3.744904e-02 ];
Tc_error_5  = [ 6.658328e+01 ; 5.706606e+01 ; 4.825357e+01 ];

%-- Image #6:
omc_6 = [ 1.803531e+00 ; 1.996676e+00 ; -1.124525e+00 ];
Tc_6  = [ -9.826226e+01 ; -8.347211e+01 ; 1.835340e+03 ];
omc_error_6 = [ 2.092130e-02 ; 2.614571e-02 ; 3.670120e-02 ];
Tc_error_6  = [ 5.963194e+01 ; 5.093814e+01 ; 4.245917e+01 ];

%-- Image #7:
omc_7 = [ 1.644359e+00 ; 2.077226e+00 ; -1.140159e+00 ];
Tc_7  = [ -1.081466e+02 ; -1.007972e+02 ; 1.932789e+03 ];
omc_error_7 = [ 2.092861e-02 ; 2.679643e-02 ; 3.754772e-02 ];
Tc_error_7  = [ 6.281955e+01 ; 5.372452e+01 ; 4.412222e+01 ];

%-- Image #8:
omc_8 = [ -1.982607e+00 ; -1.733043e+00 ; 9.177604e-03 ];
Tc_8  = [ -3.376050e+02 ; -1.272275e+02 ; 1.591596e+03 ];
omc_error_8 = [ 2.484099e-02 ; 2.909050e-02 ; 4.676609e-02 ];
Tc_error_8  = [ 5.269611e+01 ; 4.433242e+01 ; 3.949053e+01 ];

%-- Image #9:
omc_9 = [ 1.222361e+00 ; 1.742116e+00 ; -1.437523e+00 ];
Tc_9  = [ -7.975689e+01 ; 1.483757e+02 ; 1.848757e+03 ];
omc_error_9 = [ 2.736761e-02 ; 2.769599e-02 ; 3.284690e-02 ];
Tc_error_9  = [ 6.129235e+01 ; 5.158775e+01 ; 3.945767e+01 ];

%-- Image #10:
omc_10 = [ 1.750570e+00 ; 2.239636e+00 ; -9.420304e-01 ];
Tc_10  = [ 3.200645e+01 ; -1.431363e+02 ; 2.330476e+03 ];
omc_error_10 = [ 2.012445e-02 ; 2.577354e-02 ; 3.881225e-02 ];
Tc_error_10  = [ 7.616543e+01 ; 6.500733e+01 ; 5.419239e+01 ];

