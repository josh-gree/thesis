function img = dfimg(xct)
% img = dfimg(xct)
%
% Default image structure
%
% xct ........ xct sturcture. See help on dfxct() for details.
% img ........ img structure.
% img.resx ... number of voxels in the x-direction
% img.resy ... number of voxels in the y-direction
% img.resz ... number of voxels in the z-direction
% img.xmin ... minimum x-coordinate
% img.xmax ... maximum x-coordinate
% img.ymin ... minimum y-coordinate
% img.ymax ... maximum y-coordinate
% img.zmin ... minimum z-coordinate
% img.zmax ... maximum z-coordinate
% img.vox .... 3D matrix to hold voxels computed by reconstruction
%              algorithm. Empty by default so save memory.

img.resx = xct.det.nY;
img.resy = xct.det.nY;
img.resz = xct.det.nZ;
% img.resz = 1;
%
LX = xct.d + xct.det.X;
width = xct.d / LX * xct.det.width;
height = xct.d / LX * xct.det.height;
%
img.xmin = -width/2;
img.xmax = width/2;
img.ymin = -width/2;
img.ymax = width/2;
img.zmin = -height/2;
img.zmax = height/2;
% img.zmin = 0;
% img.zmax = 0;
%
img.vox = [];
img.time = 0.0;
