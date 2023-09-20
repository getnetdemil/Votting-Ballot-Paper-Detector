Problem formulation

You have to write a custom data processing (optical pattern / data recognition) program that can straighten a rotated page of text, can identify optical markers in the page and can digitize the handwritten data

**Input:**  an image showing a possibly rotated page of a questionnaire **Output:**  the digitized data


Tasks to do

Write a script that…

1. loops through the input folder and processes each image as follows:
1. applies histogram operations (e.g. stretching) to enhance quality
1. applies Fourier transform to get the phase and magnitude matrices
1. uses the frequency domain data to restore the rotation of the image
1. applies a Hough-like transformation to find the circles in the image
1. examines the histogram inside the circles
1. decides for each circle whether it contains a cross (an X) or not
1. stores the digitized value in an accumulator (an array)
1. after each image is processed, returns the statistics of the votes.


Key results to be presented:

You may code freely, as there are not so many restrictions on what to use. However, please create the followings:

1) A function named processor which takes and argument (image matrix) and returns the digitized data (a 4×2 matrix containing ones at places where the corresponding circles contained an X)
1) A script that iterates through all images in the input folder, applies the processor function to each of them and summarizes the results.


Key results to be presented:

Further details of the processor function:

It should have an optional second argument (verbose) which is False by default. If set to True, the function should raise 3 figures as follows:

Figure 1 shows the input image and the rotated, binarized, “edge” one Figure 2 shows the found circles and the corresponding Hough space Figure 3 shows the cropped image of every circle with a title saying

whether this circle contains a cross or not


Figure 1

![](Aspose.Words.15f83814-b7ae-4230-9234-5b5ad2783846.001.jpeg)


Figure 2

![](Aspose.Words.15f83814-b7ae-4230-9234-5b5ad2783846.002.png)


Figure 3

![](Aspose.Words.15f83814-b7ae-4230-9234-5b5ad2783846.003.png)



Console output after the processing is complete

![](Aspose.Words.15f83814-b7ae-4230-9234-5b5ad2783846.004.png)



There is no code package for this assignment.

All scripts and functions must be written entirely by you.

Download the image to be processed from here: <https://beta.dev.itk.ppke.hu/bipa/assignment_02>



Submission & hints

You should create a script named a02\_NEPTUN.m where the NEPTUN part is your Neptun ID. This has to be the main script; running that must be able to solve the problem. Please also create the processor.m function.

You are allowed to create other files (e.g. additional functions) too, if necessary.

Please submit ALL files (including the input folder as well) in a **ZIP** file via the Moodle system.

**Check the upcoming slides for hints!**


Hint 1

Start by applying an RGB to grayscale operation and then an edge finding operation. You may consider using the built-in edge function with an appropriate method and additional parameters.

To straighten the image you may use the magnitude of the DFT of this edge-image which has maxima values along a line crossing the center.

The angle of this line is the same as the rotation of the image. See the figure in the next slide!


Hint 1

![](Aspose.Words.15f83814-b7ae-4230-9234-5b5ad2783846.005.jpeg)


Hint 3

The Hough method can be modified in order to find circles instead of lines. Use the equation of the circle:

![](Aspose.Words.15f83814-b7ae-4230-9234-5b5ad2783846.006.png)

Also, it might be beneficial to read the following article: <https://en.wikipedia.org/wiki/Circle_Hough_Transform>

In this Assignment, the radius of the circle can be considered known, so the Hough space can (and should) be 2D.


Hint 4

Identify the relationship between the circles by the position of their centers. Use this info to identify which circle corresponds to which answer option.

To detect the cross in the circle you may use the histogram of the cropped circle and / or anything else that comes to your mind.

E.g. a Laws-like filter (or a simple convolution) can be used to detect whether the content looks like an X or not. Any other methods (e.g. Fourier based) can be good too.


