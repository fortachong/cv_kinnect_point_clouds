% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 515.596961597050610 ; 507.751246285908340 ];

%-- Principal point:
cc = [ 351.519286537772870 ; 222.522009305130840 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.546982532498474 ; -1.118983096192411 ; -0.024743287975367 ; 0.072536196931538 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 7.128120584531807 ; 6.606704420596381 ];

%-- Principal point uncertainty:
cc_error = [ 7.774012533386167 ; 5.120699472332603 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.057864810566032 ; 0.228088032796671 ; 0.005498516182257 ; 0.012578433057200 ; 0.000000000000000 ];

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
omc_1 = [ 1.848001e+00 ; 1.753847e+00 ; -2.020284e-01 ];
Tc_1  = [ -5.533666e+02 ; -2.585409e+02 ; 1.530889e+03 ];
omc_error_1 = [ 5.904450e-03 ; 1.075475e-02 ; 2.135403e-02 ];
Tc_error_1  = [ 2.318549e+01 ; 1.604851e+01 ; 2.039282e+01 ];

%-- Image #2:
omc_2 = [ 1.744659e+00 ; 1.690924e+00 ; 4.701102e-01 ];
Tc_2  = [ -5.769842e+02 ; -2.862148e+02 ; 1.542808e+03 ];
omc_error_2 = [ 7.863117e-03 ; 1.173624e-02 ; 1.841422e-02 ];
Tc_error_2  = [ 2.380588e+01 ; 1.619495e+01 ; 2.291723e+01 ];

%-- Image #3:
omc_3 = [ -2.195084e+00 ; -2.056479e+00 ; 4.364713e-01 ];
Tc_3  = [ -5.635216e+02 ; -2.597792e+02 ; 1.752037e+03 ];
omc_error_3 = [ 1.148448e-02 ; 7.801101e-03 ; 2.677913e-02 ];
Tc_error_3  = [ 2.639394e+01 ; 1.846558e+01 ; 2.058569e+01 ];

%-- Image #4:
omc_4 = [ 1.761810e+00 ; 1.587901e+00 ; -3.122614e-01 ];
Tc_4  = [ -6.569945e+02 ; -1.578313e+02 ; 1.789205e+03 ];
omc_error_4 = [ 6.973561e-03 ; 1.123495e-02 ; 1.997458e-02 ];
Tc_error_4  = [ 2.699530e+01 ; 1.889409e+01 ; 2.331009e+01 ];

%-- Image #5:
omc_5 = [ 2.109724e+00 ; 2.139808e+00 ; 3.936411e-01 ];
Tc_5  = [ -5.588618e+02 ; -2.771345e+02 ; 1.531935e+03 ];
omc_error_5 = [ 1.188957e-02 ; 1.555827e-02 ; 3.080624e-02 ];
Tc_error_5  = [ 2.350833e+01 ; 1.634025e+01 ; 2.129107e+01 ];

%-- Image #6:
omc_6 = [ 1.790877e+00 ; 1.619283e+00 ; -2.632984e-01 ];
Tc_6  = [ -4.446170e+02 ; -2.341381e+02 ; 1.391515e+03 ];
omc_error_6 = [ 6.265589e-03 ; 1.032909e-02 ; 1.984718e-02 ];
Tc_error_6  = [ 2.106158e+01 ; 1.444197e+01 ; 1.787936e+01 ];

%-- Image #7:
omc_7 = [ 1.662800e+00 ; 1.667636e+00 ; -3.053450e-01 ];
Tc_7  = [ -5.049874e+02 ; -2.684940e+02 ; 1.428323e+03 ];
omc_error_7 = [ 6.122623e-03 ; 1.098566e-02 ; 1.897797e-02 ];
Tc_error_7  = [ 2.163399e+01 ; 1.494007e+01 ; 1.881345e+01 ];

%-- Image #8:
omc_8 = [ -1.957920e+00 ; -2.187495e+00 ; -9.060740e-01 ];
Tc_8  = [ -4.430985e+02 ; -2.637200e+02 ; 1.044063e+03 ];
omc_error_8 = [ 7.845278e-03 ; 8.939461e-03 ; 2.205127e-02 ];
Tc_error_8  = [ 1.623921e+01 ; 1.154437e+01 ; 1.518053e+01 ];

%-- Image #9:
omc_9 = [ 1.512924e+00 ; 1.278853e+00 ; -6.792653e-01 ];
Tc_9  = [ -4.813262e+02 ; -1.115369e+01 ; 1.443046e+03 ];
omc_error_9 = [ 8.764378e-03 ; 1.086248e-02 ; 1.653355e-02 ];
Tc_error_9  = [ 2.173803e+01 ; 1.522613e+01 ; 1.702638e+01 ];

%-- Image #10:
omc_10 = [ 1.651582e+00 ; 1.881346e+00 ; -2.646690e-01 ];
Tc_10  = [ -6.174995e+02 ; -3.364191e+02 ; 1.784520e+03 ];
omc_error_10 = [ 5.541609e-03 ; 1.190091e-02 ; 2.064061e-02 ];
Tc_error_10  = [ 2.701961e+01 ; 1.867448e+01 ; 2.366909e+01 ];

