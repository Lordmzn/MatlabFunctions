function fig = pareto4D(x, y, z, w, a, b, labs, map) 
% fig = PlotParetoFront(x, y, z, w, a, b, labs, BW, map) 
%
% Function to plot a 4D pareto front in 2D assigning the remaining
% objectives to the dimension of the circles and to the color (summer
% colormap). The scaling of circles dimension may require ad-hoc tuning.
%
% input:
%   x, y, z, w  = vectors of objectives (to be minimized)
%   a, b        = circles dimension scaling: d = a * z + b
%   labs        = cell array containing the labels of the objectives
%   map         = string to set the colormap (default is Jet), use 'BW' for
%               grey-scale 
%
% MatteoG 19/3/2012

% check number of inputs
if(nargin<3) 
  error(  'too few arguments'  )
  error(  'usage: PlotParetoFront(x, y, z, w, labs) '  )
end;

if(nargin>8)
  error(  'too many arguments'  )
  error(  'usage: PlotParetoFront(x, y, z, w, labs) '  )
end;

% default labels J^i (i=1...4)
if(nargin<6)
    a = 35 ;
    b = 4  ;
    labs = {'J^1', 'J^2', 'J^3', 'J^4'} ;
end

if(nargin<7 || isempty(labs))
    labs = {'J^1', 'J^2', 'J^3', 'J^4'} ;
end
    
if(nargin<8)
    map = 'jet' ;
end


% the sign of the objective z is changed in order to plot the
% biggest points for the best alternatives
z = -z ; 
z_min = min(z) ;
z_max = max(z) ;
zz = ( z - z_min )/( z_max - z_min ) ;
    

% Pareto front plot
if(isempty(w))
    % there are only 3 objectives: 2D Pareto front + circles dimensions
    figure; hold on
    for i=1:length(z)
        plot(x(i),y(i),'ko','MarkerSize',zz(i)*a+b)
    end
    xlabel(labs{1}) ; ylabel(labs{2}) ;
    legend(labs{3}) ; grid on ;
    axis([min(x)-std(x)/2,max(x)+std(x)/2,min(y)-std(y)/2,max(y)+std(y)/2]) ;
else
    % there are 4 objectives: 2D Pareto front + circles dimensions + colorbar
    if(strcmp(map, 'BW'))
        w_min = min(w) ;
        w_max = max(w) ;
        ww = ( w - w_min )/( w_max - w_min ) ;
        mymap = repmat(ww,1,3);
        M = [x, y, zz, w, mymap] ;
        M = sortrows(M, 4) ;
        mymap = M(:,end-2:end);
    else
        M = [x, y, zz, w] ;
        M = sortrows(M, 4) ;
        str = ['mymap =',map,'(length(w));'] ; eval(str) ;
    end
    % 2D Pareto front
    colormap(mymap); 
    lcolorbar(num2str(M(:,4)),'YLabelString', labs{4}); hold on;
    for i=1:length(z)
        plot(M(i,1),M(i,2),'ko','MarkerSize',M(i,3)*a+b,'MarkerFaceColor',mymap(i,:))
    end
    xlabel(labs{1}) ; ylabel(labs{2}) ;
    legend(labs{3}) ; grid on ;
    axis([min(x)-std(x)/2,max(x)+std(x)/2,min(y)-std(y)/2,max(y)+std(y)/2]) ;
    
end


fig = 1;
end