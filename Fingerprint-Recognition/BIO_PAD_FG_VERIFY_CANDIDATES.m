function VERIFIED_CANDIDATES = BIO_PAD_FG_VERIFY_CANDIDATES(CANDIDATES,MASK)

% BIO_PAD_FG_VERIFY_CANDIDATES applies the binary mask 'MASK' to remove 
%   candidates mistakenly localized outside the fingerprint ridges.
% 
% Input parameters:
%   CANDIDATES - candidate positions of the sweat pores (white pixel 
%                denotes a candidate pore, black is the background).
%   MASK       - binary mask: 'zeros' correspond to the background and 
%                'ones' correspond to the fingerprint ridges.
% 
% Output parameter:
%   VERIFIED_CANDIDATES - sweat pore candidates located on fingerprint
%                         ridges.

% ___________________________________________________________________
% Adam Czajka, Warsaw University of Technology, Poland
% v.11.14.2014
%
% This software was prepared for the Biometrics course (CSE 40537|60537)
% organized at the University of Notre Dame, IN, USA, and can be used
% solely for the purpose of this course.


% Simply multiply the binary fingerprint image (original or eroded) by the 
% thresholded (binary) filtering result
VERIFIED_CANDIDATES = logical(MASK.*CANDIDATES);