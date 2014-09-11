function out = plotIIS( filename, Nv, Nr ) 

% [X, R2] = plotIIS( filename, Nrun ) 
%
% Function to plot the results of the Iterative Input Selection algorithm
% (Galelli and Castelletti, 2013) and analyze the variability of the
% results over multiple runs.
% It requires the 'plotParallelAxes' matlab function.
%
% input:
%   filename    = string specifying the name of the files containing the
%               summary of IIS results
%   Nv          = number of candidate input variables
%   Nr          = number of IIS runs
%
% output:
%   out         = structure containing the selected input variables and the 
%               corresponding model performance across the runs, along wiht
%               some metrics supporting the analysis of the results (i.e.,
%               selection frequency, average position, absolute and
%               relative contribution, total average model performance)
%   fig.1       = colormap showing the selected variables
%   fig.2       = colormap showing the corresponding model performance
%   fig.3       = parallel axes plot showing selection frequency, average
%               position and average relative contribution
%
% Last Update 11/9/2014

% check number of inputs
if(nargin<2) 
  error(  'too few arguments'  ) ;
  error(  'usage: plotIIS_selectedInput( filename, Nrun )'  );
end


% read resuls
X = nan(Nvar,Nrun);     % selected variables
R2 = nan(Nvar,Nrun);    % cumulated R2
for i = 1:Nrun
    s1 = ['load -ascii ', filename, '_', num2str(i), '_summary.txt'];
    eval(s1);
    s2 = ['v = ', filename, '_', num2str(i),'_summary;'];
    eval(s2);
    XX(1:length(v)-1,i) = v(1:end-1,1);
    R2(1:length(v)-1,i) = v(1:end-1,2);
end

% selected variables and model performance over multiple runs
X1 = XX;
X1(isnan(X1)) = Nvar+1;
figure; imagesc(X1); colormap(hot); title('var selection');
xlabel('IIS run'); ylabel('selection position');

R1 = R2;
R1(isnan(R1)) = 0;
figure; imagesc(R1); colormap(jet); title('model performance');
xlabel('IIS run'); ylabel('R2');


% analysis of frequency, position and relative contribution
vars = [0:Nv];
freq = nan(Nv,1);    % frequency
avg_pos = nan(Nv,1); % position

for v = 1:length(vars)
    count = sum( XX == vars(v) ) ;
    freq( v ) = sum(count) / Nr;
    [r,c] = find( XX == vars(v) ) ;
    avg_pos( v ) = mean(r) ;
end

for j = 1:Nr
    for v = 1:Nv
        x(v,1) = XX(v,j);
        x(v,2) = R2(v,j);
        if ~isnan(x(v,1))
            if v == 1
                Y(x(v,1)+1,j) = x(v,2);
            else
                Y(x(v,1)+1,j) = x(v,2)-x(v-1,2) ;
            end
        end
    end
end
AC = mean(Y,2); % average absolute contribution
RC = mean( Y./repmat(sum(Y),Nv,1), 2 ); % average relative contribution
MP = mean( sum(Y) ); % average model performance

% output structure
out.sel_var = X ;
out.model_perf = R2 ;
out.frequency = freq ;
out.position = avg_pos ;
out.abs_contribution = AC ;
out.rel_contribution = RC ;
out.avg_R2 = MP ;

% parallel plot
MM = [ vars', freq, avg_pos, RC ] ;
MM(:,1) = -MM(:,1);
MM(:,3) = -MM(:,3);
figure; plotParallelAxes( MM, 1 );

end

% This code has been written by Matteo Giuliani (matteo.giuliani@polimi.it)