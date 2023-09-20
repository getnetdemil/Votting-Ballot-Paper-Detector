%  The code begins by creating two arrays, r_vect and t_vect.
%  The first array will store the results of the non-maxima function applied to each element in the input array, A.
%  The second array will store the results of applying the function to every other element in A.
%  Next, the size() function is used to determine how many elements are in A.
%  This information is used later when calculating the maximum value for r_max.
%  The while loop begins by checking to see if k is greater than 0.
%  If it is, then ind2sub() is called to find the indices of every element in A that falls between 1 and 2 less than k - 1 (inclusive).
%  These indices are stored in row and column variables.
%  Next, r_vect and t_vect are initialized with these values.
%  Next, x_1 and x_2 are set to be equal to max(row-p,1) and min(row+p,size(A,1)), respectively.
%  Similarly, y_1 and y_2 are set to be equal to max(column-p,1) and min(column+p,size(A,2)).
%  Finally,
%  The code calculates the non-maximal supremum of a matrix A using the k-th row and column as the pivot.
%  The r_vect array will store the results of this calculation, while t_vect will store the transpose of this array.
%  The dimensions of A must be specified in order for the code to work correctly.
%  In this case, A has three rows and two columns, so r_max=2 and t_max=1.
%  The first line of code sets up some variables that will be used throughout the snippet.
%  dim() returns the size of A in terms of number of elements, while ind2sub() returns a subset of size(A) consisting only of those elements within ind given as an

function [r_vect, t_vect] = non_max_sup(A, k, p)
r_vect=[];
t_vect=[];

dim=size(A);
r_max=(dim(1)-1)/2;

while k>0
    [~,ind]=max(A(:));
    [row, column]=ind2sub(size(A),ind);
    r_vect=[r_vect,row];
    t_vect=[t_vect,column];
    x_1=max(row-p,1);
    x_2=min(row+p,size(A,1));
    y_1=max(column-p,1);
    y_2=min(column+p,size(A,2));
    A(x_1:x_2,y_1:y_2)=0;
    k=k-1;
end
r_vect=r_vect-r_max;
end
