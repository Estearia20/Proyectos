## Copyright (C) 2020-2023 Pablo Alvarado
##
## Este archivo forma parte del material del Proyecto 1 del curso:
## EL5857 Aprendizaje Automático
## Escuela de Ingeniería Electrónica
## Tecnológico de Costa Rica


## usage [X,Y] = create_data(numSamples,numClasses=3,shape)
## 
## This function creates random examples in the two-dimensional
## space from -1 to 1 in each coordinate.  The output Y is arranged
## in numClasses outputs, such that they can be used as outputs of
## artificial neurons (or units) directly (i.e., one-hot encoded).
## 
## Inputs:
##   numSamples: total number of samples in the training set
##   numClasses: total number of classes in the training set
##   shape: distribution of the samples in the input space:
##          'radial' rings of clases,
##          'pie' angular pieces for each class
##          'vertical' vertical bands
##          'horizontal' horizontal bands
##          'curved' curved pies
##          'spirals' interlaced spirals
##          'voronoi' random voronoi cells.
##          'laidar' the rings cut in quarters
##
## Outputs:
##   X: Design matrix, with only the two coordinates on each row 
##      (no 1 prepended).  Its size is numSamples x 2
##   Y: Corresponding class to each training sample.  Its size is
##      numSamples x numClasses.  It is one-hot encoded.
function [X,Y]=create_data(numSamples,numClasses=3,shape="radial")

  warning('off','Octave:shadowed-function');
  pkg load statistics;
  
  switch(shape)
    case "radial"
      [X,Y]=create_radial(numSamples,numClasses);
    case "laidar"
      [X,Y]=create_laidar(numSamples,numClasses);
    case "pie"
      [X,Y]=create_pie(numSamples,numClasses);
    case "vertical"
      [X,Y]=create_vertical(numSamples,numClasses);
    case "horizontal"
      [X,Y]=create_horizontal(numSamples,numClasses);
    case "curved"
      [X,Y]=create_curved(numSamples,numClasses);
    case "spirals"
      [X,Y]=create_spirals(numSamples,numClasses);
    case "voronoi"
      [X,Y]=create_voronoi(numSamples,numClasses);
    otherwise
      printf("Unknown shape '%s'\n",shape);
  endswitch

endfunction;

function [X,Y]=create_radial(numSamples,numClasses)
  angles=unifrnd(0,2*pi,numSamples,1);
  radii =unifrnd(0,1   ,numSamples,1).^0.5;
  idx   =floor(radii*numClasses)+1;
  X     =[radii.*cos(angles) radii.*sin(angles)];

  # Reserve the space for the Y matrix
  Y=zeros(numSamples,numClasses);

  # A little trickier: we want to set to 1 the element of the column
  # indicated in the index
  
  # Use the idx as the column for each sample that needs to be set 
  Y(sub2ind(size(Y),(1:numSamples)',idx))=1;
endfunction;

function [X,Y]=create_laidar(numSamples,numClasses)
  [X,Y] = create_radial(numSamples,numClasses);

  X+=[1 1];
  
  X(:,1) -= (X(:,1)>1)*2;
  X(:,2) -= (X(:,2)>1)*2;
  
endfunction;

function [X,Y]=create_pie(numSamples,numClasses)
  angles=unifrnd(0,2*pi,numSamples,1);
  # For the radii we need a triangular distribution, or there will
  # be more points towards the center
  radii =unifrnd(0,1   ,numSamples,1).^0.5;
  idx   =floor(angles*numClasses/(2*pi))+1;
  X     =[radii.*cos(angles) radii.*sin(angles)];

  # Reserve the space for the Y matrix
  Y=zeros(numSamples,numClasses);

  # A little trickier: we want to set to 1 the element of the column
  # indicated in the index
  
  # Use the idx as the column for each sample that needs to be set 
  Y(sub2ind(size(Y),(1:numSamples)',idx))=1;
endfunction;


function [X,Y]=create_curved(numSamples,numClasses)
  angles=unifrnd(0,2*pi,numSamples,1);
  # For the radii we need a triangular distribution, or there will
  # be more points towards the center. (^0.5 does the trick!)
  radii =unifrnd(0,1   ,numSamples,1).^0.5;
  idx   =floor(angles*numClasses/(2*pi))+1;
  angleoffset = (2*pi/numClasses)*radii.^2;
  X     =[radii.*cos(angles+angleoffset) radii.*sin(angles+angleoffset)];

  # Reserve the space for the Y matrix
  Y=zeros(numSamples,numClasses);

  # A little trickier: we want to set to 1 the element of the column
  # indicated in the index
  
  # Use the idx as the column for each sample that needs to be set 
  Y(sub2ind(size(Y),(1:numSamples)',idx))=1;
endfunction;

function [X,Y]=create_spirals(numSamples,numClasses)
  angles=unifrnd(0,2*pi,numSamples,1);
  # For the radii we need a triangular distribution, or there will
  # be more points towards the center. (^0.5 does the trick!)
  radii =unifrnd(0,1   ,numSamples,1).^0.5;
  idx   =floor(angles*numClasses/(2*pi))+1;
  angleoffset = 2*pi*radii.^1;
  X     =[radii.*cos(angles+angleoffset) radii.*sin(angles+angleoffset)];

  # Reserve the space for the Y matrix
  Y=zeros(numSamples,numClasses);

  # A little trickier: we want to set to 1 the element of the column
  # indicated in the index
  
  # Use the idx as the column for each sample that needs to be set 
  Y(sub2ind(size(Y),(1:numSamples)',idx))=1;
endfunction;

function [X,Y]=create_vertical(numSamples,numClasses)
  X = unifrnd(-1,1,numSamples,2);
  idx = floor((X(:,1)+1)*0.5*numClasses)+1;

    # Reserve the space for the Y matrix
  Y=zeros(numSamples,numClasses);

  # A little trickier: we want to set to 1 the element of the column
  # indicated in the index
  
  # Use the idx as the column for each sample that needs to be set 
  Y(sub2ind(size(Y),(1:numSamples)',idx))=1;

endfunction;

function [X,Y]=create_horizontal(numSamples,numClasses)
  X = unifrnd(-1,1,numSamples,2);
  idx = floor((X(:,2)+1)*0.5*numClasses)+1;

  # Reserve the space for the Y matrix
  Y=zeros(numSamples,numClasses);

  # A little trickier: we want to set to 1 the element of the column
  # indicated in the index
  
  # Use the idx as the column for each sample that needs to be set 
  Y(sub2ind(size(Y),(1:numSamples)',idx))=1;
endfunction;

function [X,Y]=create_voronoi(numSamples,numClasses)
  X = unifrnd(-1,1,numSamples,2);

  %% Initialize centroids randomly, choosing them from the available data
  centroids = X(randperm(rows(X), numClasses), :);
  
  idx = zeros(rows(X), 1);
  old_idx = ones(rows(X), 1);
  iter = 0;

  max_iter=1000;
  
  %% Run a k-means clustering until convergence or maximum iterations reached
  while (any(idx ~= old_idx) && iter < max_iter)
    old_idx = idx;
    iter += 1;

    %% Assign each point to the nearest centroid
    dists = pdist2(X, centroids);
    [min_dists, idx] = min(dists, [], 2);

    %% Update centroids
    for i = 1:rows(centroids)
      centroids(i,:) = mean(X(idx == i,:), 1);
    end
  end 

  Y=eye(numClasses,numClasses)(idx,:);
endfunction;
