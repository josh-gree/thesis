pc2 = parcluster('local')
pc2.JobStorageLocation = '/scratch/jdg1g14/pc2'
mag = linspace(1.5,4.0,10);
matlabpool(pc2,12) % start parallel pool

% detector T/F
for detector = 0:1

    % source T/F
    for source = 0:1

        % loop over magnifications
        for j = 1:10

            % 5 repetitions at each magnification
            for i = 6:10

                [img,prj] = XCT(mag(j),detector,source);
                filename_vox = strcat('/scratch/jdg1g14/all_resultspc2/vox_',num2str(mag(j)),'_',num2str(i),'_D',num2str(detector),'_S',num2str(source),'.mat'); %/scratch/jdg1g14 on iridis
                filename_prj = strcat('/scratch/jdg1g14/all_resultspc2/prj_',num2str(mag(j)),'_',num2str(i),'_D',num2str(detector),'_S',num2str(source),'.mat'); %/scratch/jdg1g14 on iridis
                save(filename_vox,'img','-v7.3');
                save(filename_prj,'prj','-v7.3');
                clear img
                clear prj

            end

        end

    end

end
matlabpool(pc2,'close')
