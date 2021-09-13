function [real_markers, nb_frame, Firstframe, Lastframe,f] = Get_real_markers(filename,list_markers, AnalysisParameters)
% Extraction of motion data
%
%   INPUT
%   - filename: name of the file to process (character string)
%   - list_markers: list of the marker names
%   - AnalysisParameters: parameters of the musculoskeletal analysis,
%   automatically generated by the graphic interface 'Analysis' 
%   OUTPUT
%   - real_markers: 3D position of experimental markers
%   - nb_frame: number of frames
%   - Firstframe: number of the first frame
%   - Lastrfame: number of the last frame
%   - f: acquisition frequency
%________________________________________________________
%
% Licence
% Toolbox distributed under GPL 3.0 Licence
%________________________________________________________
%
% Authors : Antoine Muller, Charles Pontonnier, Pierre Puchaud and
% Georges Dumont
%________________________________________________________

% Data extraction
% 
% [real_markers, nb_frame, Firstframe, Lastframe, f] = AnalysisParameters.General.InputData(filename, list_markers, AnalysisParameters.General.InputDataOptions);

list_markers{end+1} = 'SCAPDB';
list_markers{end+1} = 'SCAPDL';
list_markers{end+1} = 'SCAPDH';

[real_markers, nb_frame, Firstframe, Lastframe, f] = AnalysisParameters.General.InputData(filename, list_markers, AnalysisParameters.General.InputDataOptions);

% for i=1:Lastframe-Firstframe+1
%     SCAPDB=real_markers(end-2).position_c3d(i,:);
%     SCAPDL=real_markers(end-1).position_c3d(i,:);
%     SCAPDH=real_markers(end).position_c3d(i,:);
%     O_SCAP = SCAPDB;
%     X_SCAP = (SCAPDL - SCAPDB)/norm(SCAPDL - SCAPDB);
%     yt_SCAP = SCAPDH - SCAPDB;
%     Z_SCAP = (cross(X_SCAP,yt_SCAP))/norm(cross(X_SCAP,yt_SCAP));
%     Y_SCAP = cross(Z_SCAP,X_SCAP);
%     H_epine_vers_monde = [X_SCAP' Y_SCAP' Z_SCAP' O_SCAP'; 0 0 0 1];
%     SCAPLOCB_epine=[-0.101703678794381,-0.074480937500281,-0.085004270484110];
%     SCAPLOCLM_epine=[0.007947969554732,-0.047590640433864,0.047437731393216];
%     SCAPLOCMM_epine=[-0.093198390016067,0.008212636464341,-0.033089747865993];
%     SCAPLOCB=H_epine_vers_monde*[SCAPLOCB_epine';1];
%     SCAPLOCLM=H_epine_vers_monde*[SCAPLOCLM_epine';1];
%     SCAPLOCMM=H_epine_vers_monde*[SCAPLOCMM_epine';1];
%     SCAPLOCB=SCAPLOCB(1:3)';
%     SCAPLOCLM=SCAPLOCLM(1:3)';
%     SCAPLOCMM=SCAPLOCMM(1:3)';
%     real_markers(end-5).position_c3d(i,:)=SCAPLOCLM;
%     real_markers(end-4).position_c3d(i,:)=SCAPLOCMM;
%     real_markers(end-3).position_c3d(i,:)=SCAPLOCB;
% end

for i=1:Lastframe-Firstframe+1
    SCAPDB=real_markers(end-2).position_c3d(i,:);
    SCAPDL=real_markers(end-1).position_c3d(i,:);
    SCAPDH=real_markers(end).position_c3d(i,:);
    O_SCAP = SCAPDB;
    X_SCAP = (SCAPDL - SCAPDB)/norm(SCAPDL - SCAPDB);
    yt_SCAP = SCAPDH - SCAPDB;
    Z_SCAP = (cross(X_SCAP,yt_SCAP))/norm(cross(X_SCAP,yt_SCAP));
    Y_SCAP = cross(Z_SCAP,X_SCAP);
    H_epine_vers_monde = [X_SCAP' Y_SCAP' Z_SCAP' O_SCAP'; 0 0 0 1];
    
    O_SCAP_arr=[0.257816131591797,0.341655364990234,1.167387939453125];
    O_SCAP_av=[0.268450561523438,0.303168792724609,1.199984863281250];
    p=norm(O_SCAP_av-O_SCAP)/norm(O_SCAP_av-O_SCAP_arr);
    
    SCAPLOCMM_SCAPLOC=[0.057781760489578,0.079114354889957,0];
    SCAPLOCLM_SCAPLOC=[0.173844228161935,0,0];
    SCAPLOCB_SCAPLOC=[0,0,0];
    
    PSI_SCAPLOC_vers_epine = (PSI_SCAPLOC_vers_epine_av-PSI_SCAPLOC_vers_epine_ar)*p +PSI_SCAPLOC_vers_epine_ar;
    THETA_SCAPLOC_vers_epine = (THETA_SCAPLOC_vers_epine_av-THETA_SCAPLOC_vers_epine_ar)*p + THETA_SCAPLOC_vers_epine_ar;
    PHI_SCAPLOC_vers_epine = (PHI_SCAPLOC_vers_epine_av-PHI_SCAPLOC_vers_epine_ar)*p + PHI_SCAPLOC_vers_epine_ar;
    O_SCAPLOC_vers_epine = (O_SCAPLOC_vers_epine_av-O_SCAPLOC_vers_epine_ar)*p + O_SCAPLOC_vers_epine_ar;
    R_SCAPLOC_vers_epine=FromEulerAngles2Rotation(PSI_SCAPLOC_vers_epine,THETA_SCAPLOC_vers_epine,PHI_SCAPLOC_vers_epine);
    
    H_SCAPLOC_vers_epine = [R_SCAPLOC_vers_epine O_SCAPLOC_vers_epine; 0 0 0 1];
    
    H_SCAPLOC_vers_monde = H_epine_vers_monde*H_SCAPLOC_vers_epine;
    
    
    SCAPLOCB=H_SCAPLOC_vers_monde*[SCAPLOCB_SCAPLOC';1];
    SCAPLOCLM=H_SCAPLOC_vers_monde*[SCAPLOCLM_SCAPLOC';1];
    SCAPLOCMM=H_SCAPLOC_vers_monde*[SCAPLOCMM_SCAPLOC';1];
    SCAPLOCB=SCAPLOCB(1:3)';
    SCAPLOCLM=SCAPLOCLM(1:3)';
    SCAPLOCMM=SCAPLOCMM(1:3)';
    real_markers(end-5).position_c3d(i,:)=SCAPLOCLM;
    real_markers(end-4).position_c3d(i,:)=SCAPLOCMM;
    real_markers(end-3).position_c3d(i,:)=SCAPLOCB;
end




real_markers(end-2:end)=[];

% Filtrage (Filtering)
if AnalysisParameters.General.FilterActive
    for i=1:numel(real_markers)
    	real_markers(i).position = filt_data(real_markers(i).position_c3d,AnalysisParameters.General.FilterCutOff,f);
    end
else
    for i=1:numel(real_markers)
    	real_markers(i).position = real_markers(i).position_c3d;
    end
end

end
