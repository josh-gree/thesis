fileID = fopen('results.dat','w');
files = dir('vox*.mat');
fprintf(fileID,'R,x,y,z,name\n');
for file = files'

    current_file = load(file.name);
    current_file = current_file.img;

    sz = size(current_file.vox);
    delta = 70/sz(1);

    thresh = 0.5;

    current_file.vox = current_file.vox > thresh;

    for i = 1:sz(1)
        current_file.vox(:,:,i) = edge(current_file.vox(:,:,i));
    end

    idx = find(current_file.vox);
    [rr,cc,pp] = ind2sub(size(current_file.vox),idx);
    [cent,radius] = sphereFit([rr,cc,pp]);

    fprintf(fileID,'%.15f,%.15f,%.15f,%.15f,%s\n',radius,cent(1),cent(2),cent(3),file.name);

end
