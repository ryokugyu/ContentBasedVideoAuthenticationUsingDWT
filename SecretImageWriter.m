% This function converts the video frame into the Watermark base image.
clc;
close all;
a = VideoReader('Data/video.mpg'); % Creating the video object

filename=strcat('Data/secret.png');  % to give the extracted name to frames
b = read(a,50); % Read the individual frame
b = imresize(b, [198 256]);
imwrite(b,filename); % The frame is written into the image file
display('The base watermark is being saved in the /Data directory.')
clear all;
