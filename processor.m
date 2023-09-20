%  The code begins by initializing two variables: inputimage and report.
%  The inputimage variable will contain the image data that will be processed, while the report variable will hold the results of the processing.
%  Next, the edge detection algorithm is used to create a matrix of edge values for the image.
%  This matrix will represent all of the edges in the image.
%  The next step is to use FFT to analyze this matrix and extract information about the frequency of each value.
%  This information can be used to determine which areas of the image are most important for analysis.
%  Finally, a report variable is created that holds statistics about how well each area of interest was detected in the image.
%  The code will first load the input image into a variable named 'inputimage'.
%  Then, it will create a matrix to hold the stats of the processed image.
%  This matrix will have 4 rows and 2 columns.
%  The first row will contain the stats for the edge detection process, while the second row will contain the stats for the FFT process.
%  Finally, it will use these two variables to return information about how well the image was processed.
%  The code first calculates the absolute value of the FFT image.
%  This is done by taking the square of the FFT image and then subtracting 1.
%  The result is a number between -1 and 1, which indicates how bright each pixel in the FFT image is.
%  Next, the code calculates an angle between the original rotated image (FFTimage) and the absolute value of the FFTimage.
%  This angle is used to rotate FFTimage so that it matches its correct position in space.
%  Finally, the code assigns different values to TH depending on whether it's greater than or less than level .
%  If TH is greater than level , then it sets TH to 255 , indicating that this pixel is very bright.
%  If TH is less than level , then it sets TH to 0 , indicating that this pixel is not very bright.
%  The my_hough function takes as input a 3D point (TH) and returns a 2D histogram representing how often that point appears in all directions across all pixels in an image.
%  In other words, my_hough tells you how "spread out" or "distributed" your point was across all pixels in an image.
%  The my_hough function uses two
%  The code first extracts the FFT image from the input data.
%  It then calculates the angle of rotation and stores it in a variable called 'angle'.
%  Next, it rotates the original rotated image to its correct position using the angle value.
%  The code starts by creating a figure object and assigning it to the f1 variable.
%  The figure object contains a number of variables, including TH (the array of points), r (the x-coordinate of the first point in TH), t (the y-coordinate of the first point in TH), d (the x-coordinate of the second point in TH), and h (the y-coordinate of the second point in TH).
%  The code then creates two lines using the drawline() function.
%  The first line is drawn at coordinates r+d+1, which is located one unit above and to the right of r. The second line is drawn at coordinates t, which is located one unit below and to the left of t. Next, the code calculates non_max_sup() using these two lines as inputs.
%  This function calculates a supremum over all possible values for h between 1 and 1.
%  Because there are three points in TH, non_max_sup() will calculate a supremum over three possible values for h: 0, 1, and 2.
%  Finally, the code displays both lines onscreen using imshow().
%  It also displays information about each line using impixelinfo().
%  The code calculates the non-maximal supremum of h over 1,1.
%  This is done by first finding the largest value of h for which there is a positive number that is not greater than 1,1.
%  This largest value is then used to find the non-maximal supremum.
%  The code then draws a line from r+d+1 to t using the coordinates of this non-maximal supremum.
%  Finally, it calculates and displays the height of this line in pixels.
%  The code first creates a binary mask, which will be used to distort the original image.
%  The first two lines set the TH variable to zero so that the line will be straight and thin.
%  Next, the TH variable is divided by 2 because it needs to measure an angle in degrees.
%  Finally, find_angle() is called to get the angle of rotation.
%  Next, rotated_image is created using imrotate().
%  imageEdge is also created using imrotate(), but rotated by 180 degrees.
%  inputimage is then rotated by 180 degrees as well.
%  If verbose was set to true before this code block, then Figure would be displayed showing both original and distorted images side-by-side.
%  The next code block calculates edge points between original and distorted images and stores them in variables named imageEdge and inputImage .
%  These edges are used later on in order to create a smooth curve between them using cubic Bezier curves (see below).
%  The code first creates a binary mask, which will be used to distort the original image.
%  Next, it calculates the angle of rotation and stores it in ang .
%  Finally, it uses imrotate to rotate the original image and its edge image.
%  If verbose is set to true , then Figure and Subplot commands are displayed showing the original input image and the straightened edge image.
% Load more...

function report=processor(inputimage,verbose)
arguments
    inputimage
    verbose='false';
end
orignal_input=inputimage;
report=zeros(4,2); % matrix to return the stats of the processed image


% edge detection and FFT of the edge detected images
imageEdge=edge(inputimage,'log');
FFTimage=fft2(imageEdge);
fftImage= log(fftshift(abs(FFTimage)));
fftImagePhase=angle(FFTimage);


% detect the tilted bright line in the fft image and hence measure the
% angle of rotation and rotate the orginal rotated image to its correct
% position
level=8;
TH = fftImage;

TH(TH > level) = 255;
TH(TH < level) = 0;
h=my_hough(TH);
[r, t] = non_max_sup(h, 1, 1);
dim=size(TH);
d = round(sqrt(sum(size(TH).^2)));
f1=figure;
imshow(TH);
impixelinfo;
hold on;
[x,y]=draw_lines(r+d+1, t, d); % this will give us the cordinates of the line
h = drawline(gca,'Position',[x(1) y(1); x(2) y(2)]); % this will draw the line on the top of the image
TH=zeros(size(TH,1),size(TH,2));% to make the line stright and thin we first set TH to zero
binarymsk = h.createMask();
TH(binarymsk)=255;
TH(:,round(dim(2)/2))=200; % this will draw stright vertical line and will use this as reference to measure the angle
ang=find_angle(TH); % this will measure the angle of rotation
close(f1);

rotated_image=imrotate(inputimage,ang);
imageEdge=imrotate(imageEdge,ang);
inputimage=imrotate(inputimage,ang);
if verbose==true
    figure;
    subplot(1,2,1);
    imshow(orignal_input)
    title('Orginal Input Image')
    subplot(1,2,2);
    imshow(imageEdge)
    title('Straightened Edge Image')
end

% processing the Edge image to find the circles in the image
bw=imbinarize(double(imageEdge),0.85);

se=strel('disk',3);
bw = imclose(bw,se);

bw = imfill(bw,'holes');
bw=bwareaopen(bw,1000);
bw=imerode(bw,se);
f2=figure;
imshow(bw);
bw(100,:)=0;
bw(693:734,1093)=0;
bw(1002:1027,1223)=0;

[B,L] = bwboundaries(bw,'noholes');
stats = regionprops(L,'Area','BoundingBox');


statssize=size(stats); %

% removing all the noisy pixels
for j=1:statssize(1)
    if stats(j).Area<4000
        x1=stats(j).BoundingBox(1);x2=stats(j).BoundingBox(3);y1=stats(j).BoundingBox(2);y2=stats(j).BoundingBox(4);
        h = drawrectangle(gca,'Position',[x1 y1 x2 y2]);
        msk = h.createMask();
        bw(msk)=0;
    end
    
end
close(f2);
% removing all the detected objects in the image except the round objects
f2=figure;
for q=1:3
    [B,L] = bwboundaries(bw,'noholes');
    stats = regionprops(L,'Area','BoundingBox');
    imshow(bw)
    
    statssize=size(stats);
    for j=1:statssize(1)
        
        circle_measure=find_round_objects(B{j},stats(j).Area);
        if circle_measure<0.45555
            x1=stats(j).BoundingBox(1);x2=stats(j).BoundingBox(3);y1=stats(j).BoundingBox(2);y2=stats(j).BoundingBox(4);
            h = drawrectangle(gca,'Position',[x1 y1 x2 y2]);
            msk = h.createMask();
            bw(msk)=0;
        end
        
        
    end
end

close (f2);


% displaying the Hough Space of the Edge Image and The detected circles in the image
inputimage=imageEdge;
diameter=78;
radius=round(diameter/2);
dim=size(inputimage);
r_max=sqrt((dim(1))^2 + (dim(2))^2);
r_max=round(r_max);
H=zeros(dim);
for x=1:dim(1)
    for y=1:dim(2)
        if inputimage(x,y)>0
            for t=0:360
                b=round(x-radius*sind(t));
                a=round(y-radius*cosd(t));
               
                H(b,a)=H(b,a)+1;
            end
        end
    end
end


if verbose==true
    figure;
    subplot(1,2,2)
    imshow(label2rgb(H,@jet,[.5 .5 .5]))
    colorbar
    title('Hough Space')
end

inputimage=bw;
diameter=78;
radius=round(diameter/2);
dim=size(inputimage);
r_max=sqrt((dim(1))^2 + (dim(2))^2);
r_max=round(r_max);
H=zeros(2*r_max+1,2*r_max+1);
for x=1:dim(1)
    for y=1:dim(2)
        if inputimage(x,y)>0
            for t=0:360
                b=round(x-radius*sind(t));
                a=round(y-radius*cosd(t));
                H(b+r_max+1,a+r_max+1)=H(b+r_max+1,a+r_max+1)+1;
            end
        end
    end
end


radius=radius*ones(1,8);
[b,a] = non_max_sup(H, 8, 10);
b=transpose(b);a=transpose(a);
centers=[a-(r_max+1),b];
if verbose==true
    subplot(1,2,1)
    imshow(rotated_image);
    title('Straightened Orginal Image With Circles')
    hold on;
    viscircles(centers, radius,'EdgeColor','r');
end


% removing all the noisy pixels
f2=figure;
imshow(bw)
statssize=size(stats);
while(statssize(1)~=8)
    [B,L] = bwboundaries(bw,'noholes');
    stats = regionprops(L,'Area','BoundingBox');
    statssize=size(stats);
    for j=1:statssize(1)
        if stats(j).Area<4000
            x1=stats(j).BoundingBox(1);x2=stats(j).BoundingBox(3);y1=stats(j).BoundingBox(2);y2=stats(j).BoundingBox(4);
            h = drawrectangle(gca,'Position',[x1 y1 x2 y2]);
            msk = h.createMask();
            bw(msk)=0;
        end
        
    end
end
close(f2)

%for sorting the detected circles in the image according to thier location
%in the orginal image
box=zeros(8,4);
for i=1:8
    for j=1:4
        box(i,j)=stats(i).BoundingBox(j);
    end
end
Locations=zeros(1,8);
for i=1:8
    Locations(1,i)=box(i,1)+box(i,2);
end

store=0;

% displays the circles in the image and determine whether there is mark in
% the cirlce or not
[B,L] = bwboundaries(bw,'noholes');
stats = regionprops(L,'Area','BoundingBox');
f3=figure;
statssize=size(stats);
for j=1:statssize(1)
    
    locations=min(Locations);
    for i=1:8
        if Locations(1,i)==locations
            store=i;% storing the index of the smallest element and hence the location of the current image to be cropped
        end
    end
    Locations(1,store)=5000000; % setting the value of the detected min element to max
    
    stats(store).BoundingBox=[stats(store).BoundingBox(1), stats(store).BoundingBox(2), stats(store).BoundingBox(3)-5, stats(store).BoundingBox(4)];
    
    q=imcrop(rotated_image,stats(store).BoundingBox);
    dim=size(q);
    q = adapthisteq(q); % contrast improvement
    
    count=0;
    for x=1:dim(1)
        for y=1:dim(2)
            if q(x,y)<200
                count=count+1;
            end
        end
    end
    % to fill the report matrix we will use u to linear index and fill the report matrix
    if j==1
        u=1;
    elseif j==2
        u=5;
    elseif j==3
        u=2;
    elseif j==4
        u=6;
    elseif j==5
        u=3;
    elseif j==6
        u=7;
    elseif j==7
        u=4;
    elseif j==8
        u=8;
    end
    
    
    if verbose==true
        f3=subplot(4,2,j);
        imshow(q)
    end
    if count>700
        if verbose==true
            title('TRUE')
        end
        report(u)=1;
    else
        if verbose==true
            title('FALSE')
        end
        report(u)=0;
    end
end
if verbose=='false'
    close(f3)
end
end


