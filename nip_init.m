function status = nip_init()
% status = nip_init()
% This function is under construction, currently, it only adds some
% directories to the path, just call it before doing anything.
%
% Additional Comments:
% Juan S. Castaño C.
% 19 Feb 2013
    addpath(strcat(fileparts(which('nip_init')),'/data'));
    addpath(strcat(fileparts(which('nip_init')),'/external/toolbox_graph'));
    addpath(strcat(fileparts(which('nip_init')),'/external/toolbox_graph/toolbox'));
    %addpath(strcat(fileparts(which('nip_init')),'/external/nway310/ver3.1'));
end
