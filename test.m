addpath(genpath('pointCloud'));
pc = pointCloud('Final.xyz', 'Attributes', {'r' 'g' 'b'});
% pc = pointCloud('Final.xyz', 'Attributes', {'r' 'g' 'b'});
% pc = pointCloud('RigthIRPC.xyz');
% pc = pointCloud('LeftIRPC.xyz');

%pc = pointCloud('Left2Rigth.xyz', 'Attributes', {'r' 'g' 'b'});
pc.plot;