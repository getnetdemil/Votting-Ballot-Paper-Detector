%  The code finds all the round objects within a given boundary and area.
%  The code calculates the difference between the boundary and area, then uses that value to calculate the perimeter of each round object.
%  Finally, it calculates the radius of each round object using RndObj as its value.
%  The first line in the code declares two variables: boundary and area.
%  The next three lines calculate the difference between these two variables.
%  This calculation is used to determine which round objects are within the given boundary and area.
%  Next, the code calculates the perimeter of each round object using sum(sqrt(sum(delta_sq,2))) .
%  This calculation ensures that allround objects have equal perimeters.
%  Finally, on line 5, the code uses 4*pi*area/perimeter^2 as its value for each round object's radius.
%  The code will find all the round objects within a given boundary and area.
%  The code first calculates the difference between the boundary and area, which is then used to calculate the perimeter of each round object.
%  Finally, using the Pythagorean theorem, the code determines the radius of each round object.

function RndObj = find_round_objects(boundary,area)
 delta_sq = diff(boundary).^2;    
  perimeter = sum(sqrt(sum(delta_sq,2)));
  RndObj = 4*pi*area/perimeter^2;
end



