addpath(genpath('pointCloud'));
%pc = pointCloud('Final_D3_Right_to_Left_test.xyz', 'Attributes', {'r' 'g' 'b'});
%pc.plot;
clc; clear; close; % clear everything

% Contruct an object of class globalICP (=initialization)
icp = globalICP;

% Add point clouds to object from plain text files
% (Added point clouds are saved as mat files, e.g. LionScan1Approx.mat)
icp.addPC('Final_D3_Right.xyz');
icp.addPC('Final_D3_Left_to_Right.xyz');


% Plot all point clouds BEFORE ICP (each in a different random color)
icp.plot('Color', 'by PC');
title('BEFORE ICP', 'Color', 'w'); view(0,0); set(gcf, 'Name', 'BEFORE ICP');

% Run ICP!
icp.runICP('UniformSamplingDistance', 2, 'PlaneSearchRadius', 2);

% Plot all point clouds AFTER ICP
icp.plot('Color', 'by PC');
title('AFTER ICP', 'Color', 'w'); view(0,0); set(gcf, 'Name', 'AFTER ICP');
