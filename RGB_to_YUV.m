% This function converts an RGB frame into YUV

function [YUVImage] = RGB_to_YUV(RGB)

% Error checking purposes
 [~,~,p] = size(RGB);
  if p ~= 3
     error('Input must be of size hxwx3');
 end

% Break frames into individual components for further processing.
RComponent = double(RGB(:,:,1));
GComponent = double(RGB(:,:,2));
BComponent = double(RGB(:,:,3));

% Converting the values
YComponent = 0.299 * RComponent + 0.587 * GComponent + 0.114 * BComponent;
UComponent = -0.14713 * RComponent - 0.28886 * GComponent + 0.436 * BComponent;
VComponent = 0.615 * RComponent - 0.51499 * GComponent - 0.10001 * BComponent;

% Concatenate the matrix back from individual components Y U V respectfully
YUVImage = cat(3,YComponent,UComponent,VComponent);

end
