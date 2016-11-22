function FINAL_CANDIDATES = BIO_PAD_FG_REMOVE_DUPLICATIONS(VERIFIED_CANDIDATES)

% BIO_PAD_FG_REMOVE_DUPLICATIONS replaces each constellation of sweat pores
%   with its centroid. Number of centroids equals to the number of
%   localized sweat pores within the image.
% 
% Input parameters:
%   VERIFIED_CANDIDATES - sweat pore candidates located on fingerprint
%                         ridges.
% 
% Output parameter:
%   FINAL_CANDIDATES    - list of the final sweat pores (centroids):
%                         FINAL_CANDIDATES(1,i) is the X coordinate
%                         FINAL_CANDIDATES(2,i) is the Y coordinate
%                         and the length of FINAL_CANDIDATES corresponds 
%                         to the final number of localized sweat pores.


% ___________________________________________________________________
% Adam Czajka, Warsaw University of Technology, Poland
% v.11.14.2014
%
% This software was prepared for the Biometrics course (CSE 40537|60537)
% organized at the University of Notre Dame, IN, USA, and can be used
% solely for the purpose of this course.


% Replace each coherent area (i.e., constellations of candidates) with a
% single, white pixel. To do this, calculate the centroid for each
% constellation using 'regionprops' from Image Processing Toolbox.
CENTROIDS = regionprops(logical(VERIFIED_CANDIDATES), 'centroid');

% Number of identified sweat pores is just the number of localized 
% centroids
NUMBER_OF_PORES = length(CENTROIDS);

for i=1:NUMBER_OF_PORES
    FINAL_CANDIDATES(1,i) = CENTROIDS(i).Centroid(1);
    FINAL_CANDIDATES(2,i) = CENTROIDS(i).Centroid(2);
end