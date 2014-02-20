function [X, R2] = plotIIS_selectedInput( filename, Nvar, Nrun ) 

% [X, R2] = plotIIS_selectedInput( filename, Nrun ) 
%
% Function to plot the results of the Iterative Input Selection algorithm
% (Galelli and Castelletti, 2013) and analyze the variability of the
% selected inputs' set (on the rows) over multiple runs (on the columns).
%
% input:
%   filename    = string specifying the name of the files containing the
%               summary of IIS results
%   Nvar        = number of candidate input variables
%   Nrun        = number of IIS runs
%
% output:
%   X           = matrix containing the indices of the selected input for
%               each run (on the columns)
%   R2          = corresponding model performance
%
% MatteoG 4/2/2014

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
    X(1:length(v),i) = v(:,1);
    R2(1:length(v),i) = v(:,2);
end

% selected variables and model performance over multiple runs
X1 = X;
X1(isnan(X1)) = -5;

figure; 
subplot(2,1,1); imagesc(X1); 
ylabel('selected input');
subplot(2,1,2); plot(max(R2)); grid on;
axis([1 Nrun fix(min(max(R2))*100)/100 fix(max(max(R2))*100+1)/100]);
ylabel('model performance R2');
xlabel('IIS run');

end
