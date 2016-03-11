function [  ] = JPEGBlockTechnique( imagearg, thresh )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

image = imread(imagearg);
[m,n,z] = size(image);

if z == 3
    image = double( rgb2gray(image) );
else
    image = double( image );
end

j = 1;
w = waitbar(0);
while 8*j < m
    waitbar( 8*j/(3*m), w, 'Wait...' );
    i = 1;
    while 8*i < n
        value = image( 8*j, 8*i     ) - ...
                image( 8*j, 8*i + 1 ) - ...
                image( 8*j + 1, 8*i ) + ...
                image( 8*j + 1, 8*i + 1 );
        
            % Resets 64 px block to calculated val
            a = 8*(j-1) + 1;
            while a <= 8*i
                b = 8*(i-1) + 1;
                while b <= 8*i
                    image( a, b ) = value;
                    b = b + 1;
                end
                a = a + 1;
            end
            i = i + 1;
    end
    j = j + 1;
end

cnt = 8*j;

j = 1;
while 8*j < m
    waitbar( (cnt + 8*j)/3*m, w, 'Wait...');
    i = 1;
    while 8*i < n
        % Difference between...
        %   Left - Right
        difflr = abs( image( 8*j, 8*i ) - ...
                      image( 8*j, 8*i + 1 ));
        %   Up - Down
        diffud = abs( image( 8*j, 8*i ) - ...
                      image( 8*i + 1, 8*i ));
        
        if difflr >= thresh || diffud >= thresh
            
            % set all px to white
            a = 8*(j-1) + 1;
            while a <= 8*j
                b = 8*(i-1) + 1;
                while b <= 8*i
                    image( a, b ) = 255
                    b = b + 1;
                end
                a = a + 1;
            end
        end
        i = i + 1;
    end
    j = j + 1;
end

cnt = 16*j;

% Sets nonwhite blocks to 0.
j = 1;
while  8*j < m
    waitbar( ( cnt + 8*j )/3*m, w, 'Almost there...');
    
    i = 1;
    while 8*i < n
        if ( image( 8*j, 8*i ) ~= 255 )
            a = 8*(j-1) + 1;
            while a <= 8*j
                b = 8*(i-1) + 1;
                while b <= 8*i
                    image( a, b ) = 0;
                    b = b + 1;
                end
                a = a + 1;
            end
        end
        i = i + 1;
    end
    j = j + 1;
end

i = 1; 
while 8*i < n
    i = i + 1;
end
i = i - 1;

a = 1;

while a <= m
    b = 1; 
    while 8*(i-1) + b <= n
        image( a, 8*(i-1) + b ) = 0;
        b = b + 1;
    end
    a = a + 1
end

% Clean up next to last row
a = 1;
while a <= n
    b = 1;
    while 8*(j-2) + b  <= m
        image( 8*(j-2) + b, a ) = 0;
        b = b + 1;
    end
    a = a + 1;
end

close(w);

image = uint8( image );

imshow( image );

end

