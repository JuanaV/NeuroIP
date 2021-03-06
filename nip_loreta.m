function [J_rec, extras] = nip_loreta(y, L, Q)
% [J_rec, extras] = nip_loreta(y, L, Q) 
% Calculate the inverse problem solution using the minimum norm approach
% Input:
%       y -> NcxNt. Matrix containing the data,
%       L -> NcxNd. Lead Field matrix
%       Q -> NdxNd Covariance matrix of the sources (structure, it gets scaled in the algorithm).
% Output:
%       J_rec -> NdxNt. Reconstructed activity (solution)
%       extras.regpar -> Scalar. Optimum regularization parameter
%
% Additional comments: The optimum regularization parameter is calculated
% using the general cross validation function (GCV). See Grech et al. 2008
% for further information.
%
% Juan S. Castano C. 
% jscastanoc@gmail.com
% 26 Jan 2013


warning off % The inv_Lap calculation generates an RCOND problem. Why? don't know. FIX!

% Pre calculation of some constants to speed up the optimization process.
% inv_Lap = inv(Laplacian'*Laplacian);
inv_Lap = Q;
eye_Nc = speye(size(L,1));
iLAP_LT = inv_Lap*L';

% Get the optimal regularization parameter
gcv_fun = @(alpha) gcv(y,L,alpha, inv_Lap, iLAP_LT, eye_Nc);
% options = optimset('Display','iter','tolX',1e-6);
options = optimset('tolX',1e-6);
alpha = fminsearch(gcv_fun, 0,options);

% Solution
J_rec = iLAP_LT/(L*iLAP_LT+alpha*eye_Nc)*y;
extras.regpar = alpha;
end


function gcv_val = gcv(y,L,alpha, inv_Lap, iLAP_LT, eye_Nc)

T = iLAP_LT/(L*iLAP_LT+alpha*eye_Nc);
x_est = T*y;
gcv_val = norm(L*x_est - y,2)^2/trace(eye_Nc-L*T)^2;

end
