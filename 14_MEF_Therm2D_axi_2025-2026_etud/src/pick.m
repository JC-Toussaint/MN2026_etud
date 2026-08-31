% interpolation de l'inconnue et du gradient en un point x0, y0
% a partir de la solution stockee dans la structure fem
% [val,grad_val_x,grad_val_y, err]=pick(fem, x0, y0);

function [val,grad_val_x,grad_val_y, err]=pick(fem, x0, y0)

NV=9;
[neighborIds neighborDistances] = smallkNearestNeighbors(fem.bary, [x0 y0], NV);

val=0;
grad_val_x=0;
grad_val_y=0;

err=1;
for nv=1:NV
    ne=neighborIds(nv);
    e=fem.elt(ne);
    if (e.TYP==1)
        stop
       continue;
    end;

% recherche des polynomes et des gradients au point (x0,y0)
    [gauss, err]=ai_gradai_T3(fem, ne, x0, y0);
    if (err==0) break;
    end;
end;
    
if (err==1) return;
end;

% calcul de l inconnue et des gradients au point (x0,y0)
for ie=1:3
    alphai = gauss.alpha(ie,1);
    dalphai_dx = gauss.dalpha_dx(ie,1);
    dalphai_dy = gauss.dalpha_dy(ie,1);

    i=e.ind(ie);
    val=val+alphai*fem.sol(i);
    grad_val_x=grad_val_x+dalphai_dx*fem.sol(i);
    grad_val_y=grad_val_y+dalphai_dy*fem.sol(i);
end;
   
err=0;

function [neighborIds neighborDistances] = smallkNearestNeighbors(dataMatrix, queryMatrix, k)
%--------------------------------------------------------------------------
% Program to find the k - nearest neighbors (kNN) within a set of points. 
% Distance metric used: Euclidean distance
% 
% Usage:
% [neighbors distances] = kNearestNeighbors(dataMatrix, queryMatrix, k);
% dataMatrix  (N x D) - N vectors with dimensionality D (within which we search for the nearest neighbors)
% queryMatrix (M x D) - M query vectors with dimensionality D
% k           (1 x 1) - Number of nearest neighbors desired
% 
% Example:
% a = [1 1; 2 2; 3 2; 4 4; 5 6];
% b = [1 1; 2 1; 6 2];
% [neighbors distances] = kNearestNeighbors(a,b,2);
% 
% Output:
% neighbors =
%      1     2
%      1     2
%      4     3
% 
% distances =
%          0    1.4142
%     1.0000    1.0000
%     2.8284    3.0000
%--------------------------------------------------------------------------

neighborIds = zeros(size(queryMatrix,1),k);
neighborDistances = neighborIds;

numDataVectors = size(dataMatrix,1);
numQueryVectors = size(queryMatrix,1);

for i=1:numQueryVectors,
    dist = sum((repmat(queryMatrix(i,:),numDataVectors,1)-dataMatrix).^2,2);
    sortval=zeros(1, k);
    for j=1:k,
        [sortval(j),ind] = min(dist);
        sortpos(j)=ind;
        dist(ind) = +Inf ;
    end
    neighborIds(i,:) = sortpos(1:k);
    neighborDistances(i,:) = sqrt(sortval(1:k));
end


function [neighborIds neighborDistances] = kNearestNeighbors(dataMatrix, queryMatrix, k)
%--------------------------------------------------------------------------
% Program to find the k - nearest neighbors (kNN) within a set of points. 
% Distance metric used: Euclidean distance
% 
% Usage:
% [neighbors distances] = kNearestNeighbors(dataMatrix, queryMatrix, k);
% dataMatrix  (N x D) - N vectors with dimensionality D (within which we search for the nearest neighbors)
% queryMatrix (M x D) - M query vectors with dimensionality D
% k           (1 x 1) - Number of nearest neighbors desired
% 
% Example:
% a = [1 1; 2 2; 3 2; 4 4; 5 6];
% b = [1 1; 2 1; 6 2];
% [neighbors distances] = kNearestNeighbors(a,b,2);
% 
% Output:
% neighbors =
%      1     2
%      1     2
%      4     3
% 
% distances =
%          0    1.4142
%     1.0000    1.0000
%     2.8284    3.0000
%--------------------------------------------------------------------------

neighborIds = zeros(size(queryMatrix,1),k);
neighborDistances = neighborIds;

numDataVectors = size(dataMatrix,1);
numQueryVectors = size(queryMatrix,1);
for i=1:numQueryVectors,
    dist = sum((repmat(queryMatrix(i,:),numDataVectors,1)-dataMatrix).^2,2);
    [sortval sortpos] = sort(dist,'ascend');
    neighborIds(i,:) = sortpos(1:k);
    neighborDistances(i,:) = sqrt(sortval(1:k));
end
