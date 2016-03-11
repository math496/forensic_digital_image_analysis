function HSVTechnique( imagearg )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

image = imread(imagearg);
[m,n,z] = size(image);

if z == 1
    errordlg('Image must be color for this technique');
else
    image = rgb2hsv(image);
    imshow(image);
end

end

