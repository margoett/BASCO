% betaseries analysis definition for BASCO
basco_path = fileparts(which('BASCO'));
AnaDef.Img                  = 'nii';
AnaDef.Img4D                = true;      % true: 4D Nifti
AnaDef.NumCond              = 5;         % number of conditions
AnaDef.Cond                 = { 'EMOT-TWO' , 'NEUT-TWO' , 'EMOT-ONE' , 'NEUT-ONE' , 'OBJ' }; % names of conditions
AnaDef.units                = 'scans';    % unit 'scans' or 'secs'
AnaDef.RT                   = 2;          % repetition time in seconds
AnaDef.fmri_t               = 16; % micro time resolution (see SPM manual: level 1 analysis)
AnaDef.fmri_t0              = 9; % micro time onset (see SPM manual: level 1 analysis)
AnaDef.OutDir               = 'betaseries';  % output directory
AnaDef.Prefix               = 'f4D';
AnaDef.OnsetModifier        = 0; % Subtract this number from the onset-matrix (unit: scans). Should be zero is most cases! Use this only if onsets do not match the scans (missing volumes in data).

AnaDef.VoxelAnalysis        = true;  
AnaDef.ROIAnalysis          = true; % ROI level analysis (estimate model on ROIs for network analysis)
AnaDef.ROIDir               = fullfile(basco_path,'rois','AALROI90'); % select all ROIs in this directory
AnaDef.ROIPrefix            = 'MNI_';
AnaDef.ROINames             = fullfile(basco_path,'rois','AALROI90','AALROINAMES.txt'); % txt.-file containing ROI names
AnaDef.ROISummaryFunction   = 'mean'; % 'mean' or 'median'

AnaDef.HRFDERIVS            = [0 0];  % temporal and disperion derivatives: [0 0] or [1 0] or [1 1]

% regressors to include into design
AnaDef.MotionReg            = true;
AnaDef.GlobalMeanReg        = false; % Should be 'false' in most cases. Allows you to regress out use the global mean signal.

% name of output-file (analysis objects)
AnaDef.Outfile              = fullfile(basco_path,'tutorial','empathy4D','out_estimated.mat');

cSubj = 0; % subject counter

vp = {'N04_12' , 'N04_24'};

data_dir = fullfile(basco_path,'tutorial','empathy4D'); % directory containing all subject folders

% all subjects
for i=1:length(vp)
    cSubj = cSubj+1;
    AnaDef.Subj{cSubj}.DataPath = fullfile(data_dir,vp{i}); 
    AnaDef.Subj{cSubj}.NumRuns  = 3;
    AnaDef.Subj{cSubj}.RunDirs  = {'run1','run2','run3'};
    AnaDef.Subj{cSubj}.Onsets   = {'onsets1.txt','onsets2.txt','onsets3.txt'};
    
    AnaDef.Subj{cSubj}.Duration = [3 3 3 3 3];   % durations for the different conditions (same duration for trials of a given condition)
    AnaDef.Subj{cSubj}.DurationsFromFile = true; % Set to true if you want to use durations read in from a text-file 
    AnaDef.Subj{cSubj}.DurationFiles = {'durations1.txt','durations2.txt','durations3.txt'}; % specify the durations for each trial individually (should match the number of onsets)

end

%
AnaDef.NumSubjects = cSubj;
