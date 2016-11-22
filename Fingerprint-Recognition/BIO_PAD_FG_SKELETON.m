function SKELETON = BIO_PAD_FG_SKELETON(IMAGE)

level = graythresh(IMAGE);

SKELETON = bwmorph(IMAGE, 'remove');
% SKELETON = bwmorph(IMAGE, 'skel', Inf); 

end