%  The code first creates an array of size 2*r_max+1, where r_max is the maximum number of points in the Hough transform.
%  The code then uses a for loop to iterate over each pixel in the input image.
%  For each pixel, it checks to see if the input image value at that location is greater than 0.
%  If it is, it calculates the cosine and sine values for that pixel using math functions and stores them in variables r and round respectively.
%  Then it adds 1 to these values so that they will be stored as part of the next row of points in Hough space (i.e., r+r_max+1).
%  Next, the code uses a while loop to keep track of how many rows have been processed so far (i.e., there are currently 2*r_max+1 rows in Hough space).
%  Once all rows have been processed, the code uses a nested for loop to calculate and store the values for each point on those rows using variables H(r+r_max+1,theta) .
%  The code creates a 2D array of values, where each row corresponds to a single image pixel and each column corresponds to a single theta value.
%  The first two lines initialize the variables needed for the calculation.
%  The next three lines calculate the Hough transform for each input image pixel using the given x and y coordinates.
%  The r_max variable is used to determine how many points will be used in the transformation, while r determines which point in the 2D array will be used as the starting point for calculating Hough transform values.
%  The next four lines loop through all of the pixels in the input image and calculate their Hough transform values.
%  For each pixel, its value is increased by 1 if it falls within a certain range of

function [H] = my_hough(input_img)
dim=size(input_img);
r_max=sqrt((dim(1))^2 + (dim(2))^2);
r_max=round(r_max);
theta=180;
H=zeros(2*r_max+1,theta);
for x=1:dim(1)
    for y=1:dim(2)
        if input_img(x,y)>0
            for theta=1:180
                r= x*cosd(theta)+y*sind(theta);
                r=round(r);  
                H(r+r_max+1,theta)= H(r+r_max+1,theta)+1;
            end
        end
    end
end
end
