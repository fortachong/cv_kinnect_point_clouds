% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 515.983725153787190 ; 506.367163421480260 ];

%-- Principal point:
cc = [ 356.826334514997770 ; 223.839748481663610 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.541425387888001 ; -1.025779489046630 ; -0.022512562839990 ; 0.079193404432943 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 32.086293319403076 ; 29.012456616210191 ];

%-- Principal point uncertainty:
cc_error = [ 33.344264924948391 ; 21.787637571849714 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.253890954786714 ; 0.901032531739340 ; 0.022226975306153 ; 0.053481449040412 ; 0.000000000000000 ];

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
omc_1 = [ 1.847158e+00 ; 1.747195e+00 ; -1.920006e-01 ];
Tc_1  = [ -5.689617e+02 ; -2.623023e+02 ; 1.519418e+03 ];
omc_error_1 = [ 2.554311e-02 ; 4.705010e-02 ; 9.174821e-02 ];
Tc_error_1  = [ 9.864354e+01 ; 6.827484e+01 ; 8.935311e+01 ];

%-- Image #2:
omc_2 = [ 1.741244e+00 ; 1.684382e+00 ; 4.802826e-01 ];
Tc_2  = [ -5.931436e+02 ; -2.905238e+02 ; 1.532467e+03 ];
omc_error_2 = [ 3.436527e-02 ; 5.125439e-02 ; 7.828604e-02 ];
Tc_error_2  = [ 1.015593e+02 ; 6.893922e+01 ; 1.004481e+02 ];

%-- Image #3:
omc_3 = [ -2.202669e+00 ; -2.062729e+00 ; 4.228880e-01 ];
Tc_3  = [ -5.819467e+02 ; -2.642682e+02 ; 1.740479e+03 ];
omc_error_3 = [ 4.976220e-02 ; 3.341599e-02 ; 1.167169e-01 ];
Tc_error_3  = [ 1.125174e+02 ; 7.868639e+01 ; 9.024795e+01 ];

%-- Image #4:
omc_4 = [ 1.763802e+00 ; 1.583593e+00 ; -2.994386e-01 ];
Tc_4  = [ -6.752162e+02 ; -1.627391e+02 ; 1.775511e+03 ];
omc_error_4 = [ 3.003131e-02 ; 4.902108e-02 ; 8.594679e-02 ];
Tc_error_4  = [ 1.147732e+02 ; 8.037182e+01 ; 1.022317e+02 ];

%-- Image #5:
omc_5 = [ 2.105386e+00 ; 2.136720e+00 ; 4.042456e-01 ];
Tc_5  = [ -5.749363e+02 ; -2.811849e+02 ; 1.521930e+03 ];
omc_error_5 = [ 5.213735e-02 ; 6.906904e-02 ; 1.335261e-01 ];
Tc_error_5  = [ 1.003208e+02 ; 6.964885e+01 ; 9.320876e+01 ];

%-- Image #6:
omc_6 = [ 1.791518e+00 ; 1.613923e+00 ; -2.510106e-01 ];
Tc_6  = [ -4.587942e+02 ; -2.377669e+02 ; 1.380313e+03 ];
omc_error_6 = [ 2.671299e-02 ; 4.497328e-02 ; 8.516161e-02 ];
Tc_error_6  = [ 8.953881e+01 ; 6.137041e+01 ; 7.836606e+01 ];

%-- Image #7:
omc_7 = [ 1.664719e+00 ; 1.661053e+00 ; -2.948146e-01 ];
Tc_7  = [ -5.198180e+02 ; -2.720607e+02 ; 1.418543e+03 ];
omc_error_7 = [ 2.613286e-02 ; 4.778416e-02 ; 8.138529e-02 ];
Tc_error_7  = [ 9.210472e+01 ; 6.359464e+01 ; 8.248316e+01 ];

%-- Image #8:
omc_8 = [ -1.955846e+00 ; -2.189168e+00 ; -9.175280e-01 ];
Tc_8  = [ -4.542830e+02 ; -2.664569e+02 ; 1.036123e+03 ];
omc_error_8 = [ 3.446166e-02 ; 3.878711e-02 ; 9.355916e-02 ];
Tc_error_8  = [ 6.935814e+01 ; 4.923836e+01 ; 6.640348e+01 ];

%-- Image #9:
omc_9 = [ 1.515821e+00 ; 1.270459e+00 ; -6.690476e-01 ];
Tc_9  = [ -4.960426e+02 ; -1.480874e+01 ; 1.433024e+03 ];
omc_error_9 = [ 3.714539e-02 ; 4.694939e-02 ; 7.103733e-02 ];
Tc_error_9  = [ 9.244480e+01 ; 6.481746e+01 ; 7.475235e+01 ];

%-- Image #10:
omc_10 = [ 1.651606e+00 ; 1.873627e+00 ; -2.534672e-01 ];
Tc_10  = [ -6.358687e+02 ; -3.408335e+02 ; 1.771254e+03 ];
omc_error_10 = [ 2.393200e-02 ; 5.206177e-02 ; 8.855107e-02 ];
Tc_error_10  = [ 1.149794e+02 ; 7.944421e+01 ; 1.037264e+02 ];

