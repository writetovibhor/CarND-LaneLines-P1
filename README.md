#**Finding Lane Lines on the Road** 

The goals / steps of this project are the following:
* Make a pipeline that finds lane lines on the road
* Reflect on your work in a written report

---

### 1. Reflection

My pipeline consisted of common 5 steps, grayscale > gaussian blur > canny > region of interest > hough lines.

In order to draw a single line on the left and right lanes, I initially implemented following.

Approach 1

First of all I split the output image from hough_lines into two sections left and right by setting region_of_interest. Then for each half I wanted to reduce/merge the number of lines coming out of hough_lines so I performed second round of hough transform by setting minLineLength to a low value and maxLineGap to a high value, this seeemed to help. I then used numpy.mean to get single x1, y1, x2, y2. Now I had single line for the lane, I just increased the length of the line so that it goes upto top and bottom of my left/right region. The result of this was a single line drawn on each lane and gave good result for still images but when I ran it on the video I saw a lot of jumping in the lines. The problem occured when bottom section of the dashed lane was not visible in the frame, the mean caused the output line to change slope and it would appear as jumping.

Approach 2

I realized that second hough transform was not necessary and I can just modify draw_lines to properly separate and merge lines. I modified the draw_lines() function by first calculating slope for each line and separating out left and right lines based on slope and x co-ordinates. If slope is positive and x co-ordinates are in the right half of the image then the line is on the right lane. If slope is negative and x co-ordinates are in the left half of the image then the line is on the left lane. I then performed line fitting on the left and right line co-ordinates using numpy.polyfit and got single line for each lane. The result is now much better than first approach.


###2. Potential shortcomings

Current approach does not work for optional challenge video. The problem is due to different region of interest, changes in lighting and shadows and curve in lanes. 

One potential shortcoming would be what would happen when lanes curve earlier as seen in challenge video. The marker lines do not match with the curve. 

Another shortcoming could be due to changes in lighting and shadows, again seen in challenge video. This may create unnecessary edges which will need to be filtered out.


###3. Possible improvements

A possible improvement would be to perform better curve fitting rather than just straight line.

Another potential improvement could be to do some more pre-processing on the image to handle changes in lighting and shadows.
