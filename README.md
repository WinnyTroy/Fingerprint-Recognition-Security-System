# Fingerprint-Recognition-Security-System  

The  main  technologies  used  to  capture  the  fingerprint  image with sufficient detail are optical, silicon, and ultrasound. There are two main algorithm families to recognize fingerprints: 

1.  Minutia   matching   compares   specific   details   within   the fingerprint  ridges.  At  registration  (also  called  enrollment),  the minutia   points   are   located,   together   with   their   relative positions  to  each  other  and  their  directions.  At  the  matching stage,  the fingerprint image is processed to extract  its  minutia points, which are then compared with the registered template.   

2.  Pattern  matching  compares  the  overall  characteristics  of  the fingerprints,     not     only     individual     points.     Fingerprint characteristics   can   include   sub-areas   of   certain   interest including   ridge   thickness,   curvature,   or   density.   During enrollment,  small  sections  of  the  fingerprint  and  their  relative distances  are  extracted  from  the  fingerprint.  Areas  of  interest are  the  area  around  a  minutia  point,  areas  with  low  curvature radius, and areas with unusual combinations of ridges.

The two main functions of a biometrics system are storing and comparing.   The   storing   process   differs   between   different systems, as some  systems  store  a  great deal  more  information and will digitize and compress the information. 

Once the print information is stored in an accessible database, a  user's  prints  can  be  compared  whenever  the   system  is accessed.  You  are  authenticated  when  both  the  stored  and user's  print  match.  Finger  print  readers  use  this  uniqueness  to generate  a  code   

- rarely  do  they  actually  use  the  full  print  for identification 

- based  on areas  where  print  lines  merge,  form, or loop like  the round "whirl" that  you can  find in the  middle 

of all finger prints.  
- Fingerprint recognition is one of the best known and most widely used biometric technologies. Automated systems have been commercially available since the early 1970s, and at the time of our study, we found there were more than 75 fingerprint
recognition technology companies. Until recently, fingerprint recognition was used primarily in law enforcement applications.
Fingerprint recognition technology extracts features from impressions made by the distinct ridges on the fingertips. The 
fingerprints can be either flat or rolled. A flat print captures only an impression of the central area between the fingertip and the first knuckle; a rolled print captures ridges on both sides of the finger.

## FLOW CHART OF COMMANDS USED:  
Following were the commands being used:


# I=imread(‘f.jpg’)
Description:  it  reads  a  grayscale  or  color  image  from  the  file specified by the string filename. If the file is not in the current folder,  or  in  a  folder  on  the  MATLAB  path,  specify  the  full pathname.   
# Imwrite(a,filename,fmt)   
Description:  it  writes  the  image  A  to  the  file  specified  by filename in the format specified by format. Filename is a string that specifies the name of the output file.  
# Imhist(i)  
Description:  it  displays  a  histogram  for  the  image  I  above  a grayscale  color  bar.  The  number  of  bins  in  the  histogram  is specified  by  the  image  type.  If  I  is  a  grayscale  image,  imhist uses a default value of 256 bins. If I is a binary image, imhist uses  two  bins.imhist  (I,  n)  displays  a  histogram  where  n specifies  the  number  of  bins  used  in  the  histogram.  N  also specifies  the  length  of  the  color  bar.  If  I  is  a  binary  image,  n can only have the value 2.   
# J=rgb2gray(i)   
Description:   converts   the   true   color   image   RGB   to   the grayscale intensity image I. Rgb2gray converts RGB images to grayscale  by  eliminating  the  hue  and  saturation  information while retaining the luminance.  
# Imshow(i)  
Description:  It displays  the  grayscale  image I,  specifying  the display range for Iin [low high]. The value low(and any value less than low) displays as black; the value high(and any value greater  than high)  displays  as  white.  Values  in  between  are displayed  as  intermediate  shades  of  gray,  using  the  default number of gray levels. If you use an empty matrix ([]) for [low high], imshow uses [min(I(:)) max(I(:))]; that is, the minimum value  in Iis  displayed  as  black,  and the  maximum  value  is displayed as white.

