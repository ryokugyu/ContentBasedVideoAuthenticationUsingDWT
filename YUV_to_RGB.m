% This function converts an YUV frame into RGB

function [RGB] = YUV_to_RGB(YUVImage)

% For error checking purposes
[~,~,p] = size(YUVImage);
 if p ~= 3
     error('Input must be of size hxwx3');
 end

% Break frames into individual components
YComponent = YUVImage(:,:,1);
UComponent = YUVImage(:,:,2);
VComponent = YUVImage(:,:,3);

% Converting the values
RComponent = YComponent               +  1.13983 * VComponent;
GComponent = YComponent - 0.39465 * UComponent -  0.58060 * VComponent;
BComponent = YComponent + 2.03211 * UComponent               ;

% Concatenate the matrix back from individual components
RGB = cat(3,RComponent,GComponent,BComponent);

end
