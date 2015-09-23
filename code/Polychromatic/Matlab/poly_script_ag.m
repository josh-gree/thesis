addpath('new_vxct');
fid = fopen('files.dat');

tline = fgets(fid);

load('agdat.dat');
Es = agdat(:,1);
iin = agdat(:,2);
mus = agdat(:,3);

dir = '/scratch/jdg1g14/all_resultspc1/';
out_dir = '/scratch/jdg1g14/poly_results_ag/';

while ischar(tline)
   fname = strcat(dir,tline);

   fprintf('loading %s...\n',fname)
   load(fname);
   fprintf('done!\n')

   fprintf('calc poly...')
   projections = prj.pm;
   [nh,nw,nv] = size(projections);

   for i = 1:nv
       projections(:,:,i) = poly_projection(projections(:,:,i),mus,iin);
   end
   fprintf('done!\n')

   C = strsplit(tline,'_');
   magnification = str2double(C(2));
   fprintf('Magnification = %f\n',magnification)
   xct = dfxct();

   a = 2000/magnification;
   b = 2000 - a;

   xct.d = a;
   xct.det.X = b;
   xct.views = 1000;

   prj = dfprj();
   prj.pm = projections;

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

   fprintf('reconstructing...!\n')
   matlabpool open
   img = fdk(xct,prj,img);
   matlabpool close

   fprintf('done!\n')

   out = strcat(out_dir,tline);

   fprintf('saving %s...\n',out)
   save(out,'img');
   fprintf('done!\n')

   tline = fgets(fid);
   clear prj;
   clear img;
end
