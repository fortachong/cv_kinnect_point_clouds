% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 417.796301785185510 ; 344.364061253329570 ];

%-- Principal point:
cc = [ 480.600569196148290 ; 358.872786274951470 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.237521793907897 ; 0.094086139232662 ; -0.060369583818072 ; -0.073529626394965 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 16.665884117965962 ; 14.278245694304402 ];

%-- Principal point uncertainty:
cc_error = [ 15.278875888489475 ; 11.256112766253132 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.035959575349692 ; 0.041758999165405 ; 0.010028916170619 ; 0.008097240515612 ; 0.000000000000000 ];

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
omc_1 = [ -1.930189e+00 ; -2.041432e+00 ; 4.604877e-01 ];
Tc_1  = [ -5.205091e+02 ; -6.467683e+02 ; 1.369266e+03 ];
omc_error_1 = [ 2.882415e-02 ; 1.667955e-02 ; 3.163946e-02 ];
Tc_error_1  = [ 4.767664e+01 ; 4.312766e+01 ; 4.742196e+01 ];

%-- Image #2:
omc_2 = [ -1.957750e+00 ; -2.113207e+00 ; 2.211379e-01 ];
Tc_2  = [ -6.060449e+02 ; -6.912643e+02 ; 1.412322e+03 ];
omc_error_2 = [ 2.781788e-02 ; 1.717883e-02 ; 3.342129e-02 ];
Tc_error_2  = [ 4.934087e+01 ; 4.492864e+01 ; 4.935403e+01 ];

%-- Image #3:
omc_3 = [ -1.628197e+00 ; -1.787091e+00 ; 7.444472e-01 ];
Tc_3  = [ -4.631295e+02 ; -6.528746e+02 ; 1.414830e+03 ];
omc_error_3 = [ 3.065680e-02 ; 2.666277e-02 ; 3.387131e-02 ];
Tc_error_3  = [ 4.992616e+01 ; 4.682489e+01 ; 4.268799e+01 ];

%-- Image #4:
omc_4 = [ 2.041946e+00 ; 2.175670e+00 ; -6.610216e-01 ];
Tc_4  = [ -5.628211e+02 ; -6.019054e+02 ; 1.590570e+03 ];
omc_error_4 = [ 1.322295e-02 ; 3.200117e-02 ; 3.635743e-02 ];
Tc_error_4  = [ 5.571361e+01 ; 4.904467e+01 ; 5.642875e+01 ];

%-- Image #5:
omc_5 = [ -1.908127e+00 ; -1.965494e+00 ; 3.562854e-01 ];
Tc_5  = [ -5.578542e+02 ; -6.342856e+02 ; 1.316857e+03 ];
omc_error_5 = [ 2.749282e-02 ; 1.949660e-02 ; 3.184068e-02 ];
Tc_error_5  = [ 4.587142e+01 ; 4.244773e+01 ; 4.453260e+01 ];

%-- Image #6:
omc_6 = [ -2.042902e+00 ; -2.232833e+00 ; 6.795730e-01 ];
Tc_6  = [ -5.406961e+02 ; -5.773607e+02 ; 1.216638e+03 ];
omc_error_6 = [ 3.333192e-02 ; 9.695385e-03 ; 3.490573e-02 ];
Tc_error_6  = [ 4.235970e+01 ; 3.732852e+01 ; 4.396810e+01 ];

%-- Image #7:
omc_7 = [ 1.944417e+00 ; 2.343790e+00 ; -6.565509e-01 ];
Tc_7  = [ -5.902695e+02 ; -6.369323e+02 ; 1.310304e+03 ];
omc_error_7 = [ 9.528367e-03 ; 3.235773e-02 ; 3.650469e-02 ];
Tc_error_7  = [ 4.589841e+01 ; 4.019993e+01 ; 4.761842e+01 ];

%-- Image #8:
omc_8 = [ -2.001043e+00 ; -1.952562e+00 ; 9.156711e-02 ];
Tc_8  = [ -7.205756e+02 ; -5.743010e+02 ; 1.106273e+03 ];
omc_error_8 = [ 2.797146e-02 ; 1.899648e-02 ; 3.840348e-02 ];
Tc_error_8  = [ 3.866748e+01 ; 3.703780e+01 ; 3.928718e+01 ];

%-- Image #9:
omc_9 = [ 1.620299e+00 ; 1.858467e+00 ; -8.774723e-01 ];
Tc_9  = [ -5.971366e+02 ; -3.757797e+02 ; 1.369845e+03 ];
omc_error_9 = [ 2.686322e-02 ; 3.360683e-02 ; 3.655531e-02 ];
Tc_error_9  = [ 4.915993e+01 ; 4.367553e+01 ; 4.409386e+01 ];

%-- Image #10:
omc_10 = [ -1.842752e+00 ; -2.343282e+00 ; 5.442726e-01 ];
Tc_10  = [ -5.423288e+02 ; -7.611361e+02 ; 1.518923e+03 ];
omc_error_10 = [ 3.152066e-02 ; 1.351722e-02 ; 3.244235e-02 ];
Tc_error_10  = [ 5.342946e+01 ; 4.652437e+01 ; 5.494740e+01 ];

