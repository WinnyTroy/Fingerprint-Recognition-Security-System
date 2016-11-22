function PORE_NUMBER = BIO_PAD_FG_HOWTO(IMAGE)

% BIO_PAD_FG_HOWTO is a tutorial program demonstrating how to build a 
%  simple fingerprint liveness detection method based on sweat pores 
%  detection.
%
%  This program IS NOT a solution. It gives you only the guidelines
%  how to use components of this liveness method to build your own 
%  solution.

% ___________________________________________________________________
% Adam Czajka, Warsaw University of Technology, Poland
% v.11.14.2014
%
% This software was prepared for the Biometrics course (CSE 40537|60537)
% organized at the University of Notre Dame, IN, USA, and can be used
% solely for the purpose of this course.

% clear all
% close all

%% Read an example fingerprint image
% IMAGE = imread('liveExample.bmp');
% IMAGE = imread('../data-raw/authentic/dpham1_LI01.bmp');
% figure; imshow(IMAGE)
% title('Original image')


%% Filter the image and binarize the filtering result to find rough set of
% candidate positions of the sweat pores
CANDIDATES = BIO_PAD_FG_CANDIDATES(IMAGE);
% figure; imshow(CANDIDATES)
% title('Candidates (localized within the entire image)')


%% Create a binary image
BINARY = BIO_PAD_FG_BINARY(IMAGE);
% figure; imshow(BINARY)
% title('Binary image')


%% Create an eroded version of the binary image
ERODED_BINARY = BIO_PAD_FG_ERODE(BINARY);
% figure; imshow(ERODED_BINARY)
% title('Binary image after morphological erosion')


%% Create an eroded version of the skeleton image
% ERODED_SKELETON = BIO_PAD_FG_ERODED(SKELETON); 

%% Apply the mask (eroded binary image) to remove sweat pores localized
% outside the fingerprint ridges

VERIFIED_CANDIDATES = BIO_PAD_FG_VERIFY_CANDIDATES(CANDIDATES,ERODED_BINARY);

% VERIFIED_CANDIDATES = BIO_PAD_FG_VERIFY_CANDIDATES(CANDIDATES,ERODED_SKELETON);

% figure; imshow(VERIFIED_CANDIDATES)
% title('Candidates (localized within the fingerprint ridges)')


%% Remove constellations of sweat pores and calculate the list of final
% candidates for sweat pores
FINAL_CANDIDATES = BIO_PAD_FG_REMOVE_DUPLICATIONS(VERIFIED_CANDIDATES);

PORE_NUMBER = length(FINAL_CANDIDATES); 
% The length of the list equals to the number of the localized sweat pores
disp(['Number of sweat pores localized: ' num2str(length(FINAL_CANDIDATES))])

% figure
% hold on
% set(gca,'YDir','reverse')
% axis equal off
% imagesc(IMAGE)
% colormap gray
% plot(FINAL_CANDIDATES(1,:),FINAL_CANDIDATES(2,:),'go')
% title('Final result')
% hold off

end