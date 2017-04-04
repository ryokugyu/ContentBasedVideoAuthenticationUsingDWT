clear all;  % Clear all the local variables stored in memory

close all;  % Close all the other workspaces

clc;        % Clear the current screen

videoName = 'Data/video.mpg';           % Video Location
watermarkOriginal = 'Data/secret.png';  %Image for watermarking purpose
embeddingStrength = 0.1;                % Embedding Strength

display('Video is being processed...')
tic  % Clock counter starts for frame extraction and storing

videoObject = VideoReader(videoName);  % Loading the video object

% Different video parameters are stored in the variables.
numberOfFrames = videoObject.NumberOfFrames;
videoHeight = videoObject.Height;
videoWidth = videoObject.Width;


% Creating empty frames for string the video frames
mov(1:numberOfFrames) = struct('cdata',zeros(videoHeight,videoWidth,3,'uint8'),'colormap',[]);

% Copying the video frames into mov struct data type
for k = 1:numberOfFrames
    mov(k).cdata = read(videoObject,k);
end

display(['Total number of frames loaded are ' num2str(numberOfFrames) '...']);
toc  % Clock counter ends for frame extraction and storing.

% Embedding process starts from here.
display('Embedding process will begin now...')
tic % Clock counter starts

secretImage = imread(watermarkOriginal);
% convert the watermark image into binary for embedding purpose
binaryImage = im2bw(secretImage,0.3); % higher the value, embedding stuff is too increased
                                      % Leading to a distorted image/unmeaningful
[watermarkHeight,watermarkWidth] = size(binaryImage);
imwrite(binaryImage, 'secret.png');
RGB(1:numberOfFrames) = struct('cdata',zeros(videoHeight,videoWidth,3,'uint8'),'colormap',[]);

% Original Y values are stored in it
Yoriginal = zeros(videoHeight,videoWidth,numberOfFrames);

YFrameAfterCoversion = zeros(videoHeight,videoWidth,numberOfFrames);
for i = 1:numberOfFrames
    YUVImage = RGB_to_YUV(mov(i).cdata);
    Yoriginal(:,:,i) = YUVImage(:,:,1);   % Y element is extracted from the YUV

    YFrameAfterConversion(:,:,i) = embeddingProcedure(Yoriginal(:,:,i),binaryImage,embeddingStrength);
    %Read the embedding procedure to know this.
    % Convert embedded frame back into RGB (for viewing purposes)
    RGB(i).cdata = uint8(YUV_to_RGB(cat(3,YFrameAfterConversion(:,:,i),YUVImage(:,:,2),YUVImage(:,:,3))));
end

display(['The number of frames embedded successfully are ' num2str(numberOfFrames) ' .']);
toc  % Clock counter end for the embedding process

% Watermark extraction process
display('Extracting procedure will start now.')
tic   % Clock counter starts for extraction procedure

waterMark(1:numberOfFrames) = struct('cdata',zeros(watermarkHeight,watermarkWidth,1,'uint8'),'colormap',[]);
for i = 1:numberOfFrames
    % Extraction is done using the Y frame of the YUV converted watermarked
    % video. This frame is already saved in the Yf_out variable and
    % therefore used directly. A similar result can be observed by
    % converting RGB variable frames one by one into YUV and taking the Y
    % frame as the watermarked frame. Similarly, the original Y frame is
    % stored in the Yorg variable. Those two are used as inputs to the
    % extractor! Note that the WATERMARK itself is not used at all!

    waterMark(i).cdata = extractionProcedure(YFrameAfterConversion(:,:,i),Yoriginal(:,:,i),embeddingStrength,[watermarkHeight watermarkWidth]);
end

display(['The number of frames extracted successfully are ' num2str(numberOfFrames) ' .']);
toc

%% Result Generation
% Normalized Correlation - Algorithm from the paper

NC = ones(1,numberOfFrames);
NCden = sum(sum(binaryImage.*binaryImage));
for i = 1:numberOfFrames
    NCnum = sum(sum(waterMark(i).cdata.*binaryImage));
    if (NCden~=NCnum)
        NC(i) = NCnum/NCden;
    end
end


% PSNR
% Only the Y frame of the YUV image is considered.
MSE = abs((1/(videoHeight*videoWidth))*(sum(sum(Yoriginal - YFrameAfterCoversion))));
PSNR = 10*log((255*255)/MSE);


% Showing the output on the screen directly via different windows
window1=implay(mov,videoObject.FrameRate);
window2=implay(RGB,videoObject.FrameRate);
window3=implay(waterMark,videoObject.FrameRate);


display('Movie Player will show the results...')

set(window1.Parent, 'position', [150 100 videoWidth+10 videoHeight+10],'Name','Original Video')
set(window2.Parent, 'position', [150+videoWidth+30 100 videoWidth+10 videoHeight+10],'Name','Embedded Video')
set(window3.Parent, 'position', [150+2*videoWidth+60 100 watermarkHeight+10 watermarkWidth+10],'Name','Extracted Watermark')


display('*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*')
display('...........~!Project Complete!~...........')
