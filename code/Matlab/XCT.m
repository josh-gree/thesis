function [img,prj] = XCT(magnification,detector,source)
% Forms the projections and computes the reconstructed volume at a given
% magnification (detector = T/F, source = T/F)

  % use detector offsets or not
  if detector
      Fd = 2;
  else
      Fd = 0;
  end

  % use source offsets or not
  if source
      Fs = 2;
  else
      Fs = 0;
  end

  % imaged object - sphere centred at origin, radius 30mm
  ball = dfball();
  ball.radius = 30.0;
  ball.centre = [0;0;0];

  xct = dfxct();

  % set source2iso and iso2det distances based on magnification
  % constant source2det distance of 2000mm
  a = 2000/magnification;
  b = 2000 - a;

  xct.d = a;
  xct.det.X = b;

  % set source and detector variation to 1mm
  sigma = 1;
  xct.fspot.sY = sigma;
  xct.fspot.sZ = sigma;
  xct.det.sY = sigma;
  xct.det.sZ = sigma;
  xct.views = 1000; % This is the number of projections

  # set up projection structure
  prj = dfprj();
  prj.ns = 100; % This is for the number of samples
  prj.fvw = 1;
  prj.fs = Fs;
  prj.fd = Fd;

  % form projections
  prj = projections(xct, ball, prj);

  % set up reconstruction structure
  img = dfimg(xct);
  img.xmin = -35.0;
  img.xmax = 35.0;
  img.ymin = -35.0;
  img.ymax = 35.0;
  img.zmin = -35.0;
  img.zmax = 35.0;

  img.resx = 301;
  img.resy = 301;
  img.resz = 301;

  % form reconstruction
  img = fdk(xct,prj,img);

end
