% List of open inputs
nrun = X; % enter the number of runs here
jobfile = {'/Users/brendancullen/Desktop/REV/REV_scripts/fMRI/fx/React/matlabbatch_react_filter_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(0, nrun);
for crun = 1:nrun
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
