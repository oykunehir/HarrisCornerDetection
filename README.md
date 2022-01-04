
# Harris Corner Detection Algorithm Implementation 

This code is prepared to find the corners in the input image using the algorithm suggested in the article A Combined Corner And Edge Detector by Chris Harris & Mike Stephens.
## Used Technologies

**Software Language:** Matlab

  
## Algorithm

First we need to calculate the second moment matrix.

Here M is the second moment matrix, w is the weight function, Ix is the horizontal slope value at the corresponding pixel, Iy is the vertical slope value at the corresponding pixel. I uses [-1 0 +1] to find horizontal slopes on the first scale and [-1 0 +1]T to find verticals.

After calculating the M matrix for a pixel, the corner response of that pixel can be calculated with the following formula.

M = ∑ w(x,y) [IxIx IxIy ; IxIy IyIy]

Here det(M) is the determinant of M, K is a constant (could be a value from 0.04 to 0.15), trace2(M) is the square of the trace of M. 

Finally, by applying a predetermined threshold value to the Mc value, it is decided whether the given pixel is a corner pixel or not.
All corner pixels are determined by finding each pixel separately in the image for which the Mc value is given. Since the Harris corner detection algorithm works with the sliding window method, it is normal to have more than one answer for a corner. In order to prevent this situation, after all the corners in the image are detected, non-maximum suppression is applied to ensure that the most dominant corners remain.

After performing the process outlined above, you are asked to repeat this process for different scales and show the vertices you find in each scale separately and together.

  