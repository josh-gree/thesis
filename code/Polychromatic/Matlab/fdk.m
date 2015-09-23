function img = fdk(xct, prj, img)
% img = fdk(xct, prj, img)
% img = fdk(xct, prj)
%
% FDK reconstruction algorithm
%
% xct ... xct structure. See help on dfxct() for details.
% prj ... projections structure. See help on dfprj() for details.
% img ... (input variable) imgage structure. See help on dfimg() for
%         details. Provides the parameters img.resx, img.xmin etc. needed
%         to compute the image voxels. A default imgage structure is
%         created when not supplied as an input.
% img ... (output variable) imgage structure. This function (fdk) computes
%          the image voxels img.vox using the parameters supplied in the
%          input variable (or default parameters).
%

tic();
if nargin <= 2
    img = dfimg(xct);
end
%
disp('Running FDK reconstruction algorithm ...')
%
d = xct.d;
SX = d + xct.det.X;
width = d/SX * xct.det.width;
height = d/SX * xct.det.height;
NY = xct.det.nY;
NZ = xct.det.nZ;
Nv = xct.views;
DY = width / (NY - 1);
DZ = height / (NZ - 1);
Phi = 2*pi/Nv*(0 : Nv-1);
DPhi = 2*pi/Nv;
Y = DY*((0 : NY - 1) - (NY - 1)/2);
Z = DZ*((0 : NZ - 1) - (NZ - 1)/2);
wY = pi/DY;
wZ = pi/DZ;
%
% Compute the parameters (11).
%
for j = 1 : NY
    for k = 1 : NZ
        cth(j, k) = d / sqrt(d^2 + Y(j)^2 + Z(k)^2);
    end
end
%
% Compute the integral parameters (12).
%
gy = @(t) wY^2*sinc(wY/pi*t) + (cos(wY*t) - 1)./t.^2;
GY = zeros(2*NY - 1, 1);
for j = 1 - NY : NY - 1;
    Yj = j*DY;
    GY(j + NY) = integral(gy, Yj - DY/2, Yj + DY/2);
end
%
gZ = @(t) wZ/pi*sinc(wZ/pi*t);
GZ = zeros(1, 2*NZ - 1);
for k = 1 - NZ : NZ - 1;
    Zk = k*DY;
    GZ(k + NZ) = integral(gZ, Zk - DZ/2, Zk + DZ/2);
end
%
% Compute the 3D matrix (13) using (12).
%
G = GY * GZ;

% Parallel for loop - projection filters
parfor i = 1 : Nv
    disp(['Convolving: iteration ',num2str(i),' of ',num2str(Nv)])
    F = prj.pm(:, :, i) .* cth;
    H(:, :, i) = conv2(F, G, 'same');
end
%
% Compute the image voxels using (16)
%
rx = linspace(img.xmin, img.xmax, img.resx);
ry = linspace(img.ymin, img.ymax, img.resy);
rz = linspace(img.zmin, img.zmax, img.resz);
% [xx, yy] = meshgrid(rx, ry);
[yy, xx] = meshgrid(ry, rx);
nx = img.resx;
ny = img.resy;
nz = img.resz;
% [YY, ZZ] = meshgrid(Y, Z);
[ZZ, YY] = meshgrid(Z, Y);
vox = zeros(nx, ny, nz);

% Parallel for loop - independent z-slices
parfor k = 1 : nz
    disp(['Reconstructing slice ',num2str(k),' of ',num2str(nz)])
    % zz = ones(ny, nx);
    zz = rz(k) * ones(nx, ny);
    for i = 1 : Nv
        % disp(['Reconstruction: iteration ',num2str(i),' of ',num2str(Nv)])
        phi = double(Phi(i));
        % m0 = [cos(phi), sin(phi)];
        % nn = [-sin(phi), cos(phi)];
        m0x = cos(phi); m0y = sin(phi);
        nnx = -sin(phi); nny = cos(phi);
        denom = m0x*xx + m0y*yy + d;
        YYr = d*(nnx*xx + nny*yy) ./ denom;
        % [size(zz); size(denom)]
        ZZr = d*zz ./ denom;
        % [size(ZZ); size(YY); size(H(:, :, i)); size(ZZr); size(YYr)]
        % P = interp2(YY, ZZ, H(:, :, i), YYr, ZZr);
        P = interp2(ZZ, YY, H(:, :, i), ZZr, YYr);
        % [size(vox); size(P); size(denom)]
        vox(:, :, k) = vox(:, :, k) + P ./ denom.^2;
    end
end
DPhi = double(DPhi);
vox = d^2*DPhi * vox / (4*pi^2);
img.vox = vox;
img.time = toc();
