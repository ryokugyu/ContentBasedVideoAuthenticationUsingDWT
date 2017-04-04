% This function embedds an input frame with the secret image using DWT

function [emFrame] = embeddingProcedure(frame,secret,x)


% DWT2 is performed.
% Discrete wavelet tranformation is performed using HAAR filter.

% Level 1 DWT
[LL,LH,HL,HH]=dwt2(frame,'haar');

% Level 2 DWT
[LL21,LH21,HL21,HH21] = dwt2(LL,'haar');
[LL22,LH22,HL22,HH22] = dwt2(HL,'haar');
[LL23,LH23,HL23,HH23] = dwt2(LH,'haar');
[LL24,LH24,HL24,HH24] = dwt2(HH,'haar');

[height,width,~] = size(LL21);
%% Secret Image Manipulation
% For the given video, size(LL21) = 72x88... The secret image should be
% broken into 8 blocks of this size. Therefore, the chosen secret image is
% of size 99x512 (This is 8 times the LL21 frame size!). This must be
% changed according to the video size. For example, in the paper, the
% chosen size is said to be 32x32. However, finding a video of this exact
% matching dimension is difficult...

SS = reshape(secret,1,numel(secret));   % Vectorize the secret image
block_size = height*width;                         % Each block size
arrayLocationPointer = 0;                          % array location pointer

W_ims = zeros(height,width,8);                   % Definie

for i = 1:8
    W_ims(:,:,i) = reshape(SS(arrayLocationPointer+1:i*block_size),height,width);  % Allocation
    arrayLocationPointer = i*block_size;                  % Change array pointer
end

newLL21 = LL21 + x*W_ims(:,:,1);   % x is embedding strength
newLL22 = LL22 + x*W_ims(:,:,2);
newLL23 = LL23 + x*W_ims(:,:,3);
newLL24 = LL24 + x*W_ims(:,:,4);
newHH21 = HH21 + x*W_ims(:,:,5);
newHH22 = HH22 + x*W_ims(:,:,6);
newHH23 = HH23 + x*W_ims(:,:,7);
newHH24 = HH24 + x*W_ims(:,:,8);

%% Frame Regeneration using inverse DWT
newLL = idwt2(newLL21,LH21,HL21,newHH21,'haar');
newHL = idwt2(newLL22,LH22,HL22,newHH22,'haar');
newLH = idwt2(newLL23,LH23,HL23,newHH23,'haar');
newHH = idwt2(newLL24,LH24,HL24,newHH24,'haar');

emFrame = idwt2(newLL,newLH,newHL,newHH,'haar');
end
