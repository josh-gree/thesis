pc2 = parcluster('local')
pc2.JobStorageLocation = '/scratch/jdg1g14/pc2'
matlabpool(pc2,12)

mag = linspace(1.5,4.0,10);
detector = 0;
source = 1;
for j = 1:1
    for i = 1:20
        [img,prj] = XCT(mag(j),detector,source);
        filename_vox = strcat('/scratch/jdg1g14/all_resultsextraD0S1/vox_',num2str(mag(j)),'_',num2str(i),'_D',num2str(detector),'_S',num2str(source),'.mat'); %/scratch/jdg1g14 on iridis
        filename_prj = strcat('/scratch/jdg1g14/all_resultsextraD0S1/prj_',num2str(mag(j)),'_',num2str(i),'_D',num2str(detector),'_S',num2str(source),'.mat'); %/scratch/jdg1g14 on iridis
        save(filename_vox,'img','-v7.3');
        save(filename_prj,'prj','-v7.3');
        clear img
        clear prj
    end
end

matlabpool(pc2,'close')
