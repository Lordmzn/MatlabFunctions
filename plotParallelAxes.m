function fig = plotParallelAxes( X, id, map )

% fig = plotParallelAxes( X, id )
%
% This function draws a parallel-axes plot (Inselberg, 1997), where each
% element is a line crossing the N-axes at their corresponding values. In
% the plot, the elements values are normalized between their minimum and
% maximum values and the axes are oriented from the bottom to the top.
%
% Input:    X   = data matrix, where each element is a row and the
%               N-dimensions are represented on the columns
%           id  = dimension with respect to which the elements are ordered
%               and colored
%           map = colormap (default is jet) 
%
% Copyright 2014 Matteo Giuliani, Post-doc Research Fellow, Politecnico di Milano
% Email:    matteo.giuliani@polimi.it
% Wesite:   http://home.deib.polimi.it/giuliani/
% Last Update 5/11/2014



% check inputs
[r,c] = size(X);
if(id>c)
    error('wrong dimension id! id must be lower than the number of columns of the matrix X');
end

if(nargin<2)
    id = 1 ; % default color assigned to first axis
elseif(nargin<3)
    map = jet(r) ; % default colormap is jet
end

if(nargin>3)
    error('too many inputs! please use: plotParallelAxes( X, id, map ) ');
end

% normalization
m = min(X);
M = max(X);
Z = ( X - repmat( m,r,1 ) ) ./ ( repmat( M,r,1 ) - repmat( m,r,1 ) ) ;

% alternatives are ordered with respect to the id-th dimension (column) of
% the matrix
Y = sortrows( Z,id ) ; 
%c = colormap( jet(r) ) ;


% parallel-axes plot
for i=1:r
    hold on; parallelcoords( Y( i,: ), 'Color', map( i,: ) ) ; 
end
set(gca,'xtick',[1:1:size(X,2)]); grid on;
fig=1;
end

% This code has been written by Matteo Giuliani (matteo.giuliani@polimi.it)