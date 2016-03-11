function [  ] = CustomHighPassFiltering( imagearg )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

image = imread(imagearg);
[m,n,z] = size(image);

if z == 3
    image = double( rgb2gray(image) );
else
    image = double(image);
end

imageResult = image;

j = 0;
w = waitbar(0);
while j < m
    % Wait to know ETA
    waitbar(j/m, w, 'Wait...');
    while i < n
        % Counter in spec. cases where mask
        % is not with 9px => edges
        counter = 0;
        
        % Subscripts to check if within bounds
        j_minus_1 = j-1;
        i_minus_1 = i-1;
        j_plus_1  = j+1;
        i_plus_1  = i+1;
        
        % Top left px
        if ( j_minus_1 < 1 || i_minus_1 < 1)
            image1 = 0;
        else
            image1 = ( -1*image( j-1, i-1 ) );
            counter = counter + 1;
        end
        
        % Top px
        if ( j_minus_1 < 1 || i_plus_1 < 1 )
            image2 = 0;
        else
            image2 = -2*image( j-1, i );
            counter = counter + 1;
        end
        
        % Top-right px
        if ( j_minus_1 < 1 || i_plus_1 < 1 )
            image3 = 0; 
        else
            image3 = -1*image( j-1, i+1 );
            counter = counter + 1;
        end
        
        % Left pixel
        if ( i_minus_1 < 1 )
            image4 = 0;
        else
            image4 = -2*image( j, i-1 );
            counter = counter + 1;
        end
        
        % Center pixel
        image5 = -2*image( j, i );
        counter = counter + 1;
        
        % Right pixel
        if i_plus_1 < 1
            image6 = 0;
        else
            image6 = -2*image( j, i+1 );
            counter = counter + 1;
        end
        
        % Bottom left pixel
        if ( j_plus_1 < 1 || i_minus_1 < 1 )
            image7 = 0;
        else
            image7 = -1*image( j+1, i-1 );
            counter = counter + 1;
        end
        
        % Bottom pixel
        if j_plus_1 < 1
            image8 = 0;
        else
            image8 = -2*image( j+1, i);
            counter = counter + 1;
        end
        
        % Bottom right pixel
        if j_plus_1 < 1 || i_plus_1 < 1 
            image9 = 0;
        else
            image9 = -1*image( j+1, i+1 );
            counter = counter + 1;
        end
        
        value = (image1 + image2 + image3 + ...
                 image4 + image5 + image6 + ...
                 image7 + image8 + image9)/counter;
        
        imageResult( j, i ) = value;
        i = i + 1;
    end
    j = j + 1;
end

close(w);
imageResult = uint8( imageResult );
imshow( imageResult );

end

