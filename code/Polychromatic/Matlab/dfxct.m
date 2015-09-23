function xct = dfxct
% xct = dfxct
%
% Default xct structure
%
% xct.d ............ distance of source from iso-centre
% xct.views ........ number of views (equally spaced angles)
% xct.info ......... user information
% xct.fspot.mY ..... mean Y-coordinate of focal spot
% xct.fspot.mZ ..... mean Z-coordinate of focal spot
% xct.fspot.wY ..... focal spot width in Y-direction (uniform distribution)
% xct.fspot.wZ ..... focal spot width in Z-direction
% xct.fspot.sY ..... standard deviation of focal spot in Y-direction
%                    (normal distribution)
% xct.fspot.sZ ..... standard deviation of focal spot in Z-direction
% xct.det.X ........ distance of detector from iso-centre
% xct.det.width .... width of detector
% xct.det.height ... height of detector
% xct.det.nY ....... number of columns in detector
% xct.det.nZ ....... number of rows in detector
% xct.det.ap ....... fraction of total dectector cell area (aperture) over
%                    which x-rays are detected (uniform distribution)
% xct.det.sY ....... standard deviation of Y-coordinate of random point
%                    where x-rays are received (normal distribution)
% xct.det.sZ ....... standard deviation of Z-coordinate
% xct.det.snrdb .... detector cell SNR in dB
%
xct.d = 1000;
xct.views = 96;
xct.info = 'Reasonable values assuming length is expressed in mm';
xct.fspot.mY = 0;
xct.fspot.mZ = 0;
xct.fspot.wY = 1;
xct.fspot.wZ = 1;
xct.fspot.sY = 1;
xct.fspot.sZ = 1;
xct.det.X = 0;
xct.det.width = 400;
xct.det.height = 400;
xct.det.nY = 301; % how do these relate to voxels?!?!
xct.det.nZ = 301; % DITTO!??
xct.det.ap = 0.8;
xct.det.sY = 1;
xct.det.sZ = 1;
xct.det.snrdb = 100;
