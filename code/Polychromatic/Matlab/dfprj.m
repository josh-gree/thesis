function prj = dfprj()
% prj = dfprj()
%
% Default projection sturcture
%
% prj.Phi ... angle(s) of view
% prj.fvw ... flag. 1 = use xct parameters to select viewing angles
% prj.fs .... flag. 0 = ideal source
%                   1 = uniform focal spot
%                   2 = gaussian focal spot
% prj.fd .... flag. 0 = ideal point-like detector cell
%                   1 = uniform detector cell
%                   2 = gaussian detector cell
% prj.ns .... number of sample projections (sample size) at each viewing
%             angle when prj.fs or prj.fd is non-zero
% prj.pm .... Becomes an nY x nZ x n matrix upon running projections()
%             consisting of an nY x nZ data matrix (mean values) for each
%             of the n = length(prj.Phi) views. Empty by default to save
%             memory.
% prj.ps .... stores the standard deviations in the same format as prj.pm
%
prj.Phi = 0;
prj.fvw = 0;
prj.fs = 0;
prj.fd = 0;
prj.ns = 1;
prj.pm = [];
prj.ps = [];
