% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 550.588471989095410 ; 535.931393692375990 ];

%-- Principal point:
cc = [ 372.444641831136830 ; 229.824138743958400 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.536980414514645 ; -0.788432013160710 ; -0.016051353966462 ; 0.095027609276515 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 30.904237240569145 ; 26.053927990215932 ];

%-- Principal point uncertainty:
cc_error = [ 27.624025013001347 ; 17.498262289926394 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.220233793130613 ; 0.592541469066302 ; 0.014736122943388 ; 0.041643481107534 ; 0.000000000000000 ];

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
omc_1 = [ 1.845725e+00 ; 1.733609e+00 ; -1.706014e-01 ];
Tc_1  = [ -6.151296e+02 ; -2.800001e+02 ; 1.589732e+03 ];
omc_error_1 = [ 1.971262e-02 ; 3.703153e-02 ; 6.837496e-02 ];
Tc_error_1  = [ 8.032333e+01 ; 5.457138e+01 ; 7.661447e+01 ];

%-- Image #2:
omc_2 = [ 1.735744e+00 ; 1.670923e+00 ; 4.976486e-01 ];
Tc_2  = [ -6.422710e+02 ; -3.098496e+02 ; 1.613264e+03 ];
omc_error_2 = [ 2.709168e-02 ; 3.961747e-02 ; 5.740023e-02 ];
Tc_error_2  = [ 8.338207e+01 ; 5.548970e+01 ; 8.599041e+01 ];

%-- Image #3:
omc_3 = [ -2.210439e+00 ; -2.070187e+00 ; 3.929530e-01 ];
Tc_3  = [ -6.334045e+02 ; -2.850371e+02 ; 1.818585e+03 ];
omc_error_3 = [ 3.862166e-02 ; 2.495290e-02 ; 8.865219e-02 ];
Tc_error_3  = [ 9.148200e+01 ; 6.288911e+01 ; 7.812940e+01 ];

%-- Image #4:
omc_4 = [ 1.766523e+00 ; 1.572620e+00 ; -2.737303e-01 ];
Tc_4  = [ -7.297314e+02 ; -1.843309e+02 ; 1.860485e+03 ];
omc_error_4 = [ 2.274089e-02 ; 3.819395e-02 ; 6.407057e-02 ];
Tc_error_4  = [ 9.356190e+01 ; 6.427794e+01 ; 8.826515e+01 ];

%-- Image #5:
omc_5 = [ 2.095114e+00 ; 2.127299e+00 ; 4.328728e-01 ];
Tc_5  = [ -6.222159e+02 ; -3.000049e+02 ; 1.598168e+03 ];
omc_error_5 = [ 4.023208e-02 ; 5.343900e-02 ; 9.880210e-02 ];
Tc_error_5  = [ 8.218847e+01 ; 5.597226e+01 ; 7.984999e+01 ];

%-- Image #6:
omc_6 = [ 1.792780e+00 ; 1.598204e+00 ; -2.250462e-01 ];
Tc_6  = [ -5.006829e+02 ; -2.536005e+02 ; 1.444045e+03 ];
omc_error_6 = [ 2.034991e-02 ; 3.561835e-02 ; 6.344075e-02 ];
Tc_error_6  = [ 7.283632e+01 ; 4.896597e+01 ; 6.752495e+01 ];

%-- Image #7:
omc_7 = [ 1.666167e+00 ; 1.646727e+00 ; -2.725525e-01 ];
Tc_7  = [ -5.629171e+02 ; -2.885887e+02 ; 1.483557e+03 ];
omc_error_7 = [ 1.983622e-02 ; 3.767706e-02 ; 6.070510e-02 ];
Tc_error_7  = [ 7.495288e+01 ; 5.078171e+01 ; 7.073351e+01 ];

%-- Image #8:
omc_8 = [ -1.951380e+00 ; -2.192889e+00 ; -9.472555e-01 ];
Tc_8  = [ -4.879741e+02 ; -2.800485e+02 ; 1.093213e+03 ];
omc_error_8 = [ 2.648843e-02 ; 3.084351e-02 ; 7.031219e-02 ];
Tc_error_8  = [ 5.704739e+01 ; 3.951753e+01 ; 5.744478e+01 ];

%-- Image #9:
omc_9 = [ NaN ; NaN ; NaN ];
Tc_9  = [ NaN ; NaN ; NaN ];
omc_error_9 = [ NaN ; NaN ; NaN ];
Tc_error_9  = [ NaN ; NaN ; NaN ];

%-- Image #10:
omc_10 = [ 1.651250e+00 ; 1.860761e+00 ; -2.337410e-01 ];
Tc_10  = [ -6.900078e+02 ; -3.618239e+02 ; 1.854738e+03 ];
omc_error_10 = [ 1.819006e-02 ; 4.078504e-02 ; 6.587864e-02 ];
Tc_error_10  = [ 9.371630e+01 ; 6.359586e+01 ; 8.899962e+01 ];

