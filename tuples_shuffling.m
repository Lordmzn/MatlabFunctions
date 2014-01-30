function Xshuffled = tuples_shuffling(X)

% Xshuffled = tuples_shuffling(X)
%
% Function to perform random shuffling of the tuples (rows) in the input
% matrix X. This operation generally improves the performance of the
% Iterative Input Selection algorithm (Galelli and Castelletti, 2013) by
% removing time-dependent correlations.
%
% input: 
%   X           = a dataset of tuples (observations on the rows and
%               variables on the columns)
% output: 
%   Xshuffled   = the same dataset (X) after random shuffling performed on
%               the rows of the matrix
%
% MatteoG 23/1/2014


% dimensions of the input matrix 
[r,c] = size(X);

% random shuffling of the tuples (i.e., rows)
random_idx = randperm(r);

% replacement
Y = nan(r,c);
for j = 1:r
    Y(j,:) = X(random_idx(j),:);
end

Xshuffled = Y;

end




