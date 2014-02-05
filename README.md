MatlabFunctions
===============

`plotPareto4D.m` creates a 4-dimensional (i.e., x,y,z,w) representation where 'x' and 'y' are plotted on the primary axes, the dimension of the circles is proportional to 'z' and the colors represent 'w'. Examples can be found in [Castelletti et al. (2013)](http://ascelibrary.org/doi/abs/10.1061/(ASCE)WR.1943-5452.0000348?mi=3d26f5&af=R&filter=multiple&text1=progressive+collapse&field4=all&field3=all&field2=all&field1=articletitle&startPage=0&pageSize=20&displaySummary=true).

`tuples_shuffling.m` performs a random shuffling of the tuples (rows) of the input dataset. This operation has been demonstrated to enhance the performance of the Iterative Input Selection algorithm [Galelli and Castelletti, 2013](http://onlinelibrary.wiley.com/doi/10.1002/wrcr.20339/abstract).

`plotIIS_selectedInput.m` creates a mesh-plot to represent the set of input (on the rows) selected over multiple runs (on the columns) of the Iterative Input Selection algorithm [Galelli and Castelletti, 2013](http://onlinelibrary.wiley.com/doi/10.1002/wrcr.20339/abstract).


Copyright (C) 2013 Matteo Giuliani.

The functions in this repository are free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License. This code is distributed WITHOUT ANY WARRANTY. See the GNU Lesser General Public License for more details.