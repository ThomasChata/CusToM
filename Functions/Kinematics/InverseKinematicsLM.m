function [ExperimentalData, InverseKinematicResults] = InverseKinematicsLM(filename,AnalysisParameters,BiomechanicalModel)
% Computation of the inverse kinematics step thanks to a Jacobian matrix
%
%   INPUT
%   - filename: name of the file to process (character string)
%   - AnalysisParameters: parameters of the musculoskeletal analysis, automatically generated by the graphic interface 'Analysis'
%   - BiomechanicalModel: musculoskeletal model
%   OUTPUT
%   - ExperimentalData: motion capture data(see the Documentation for the structure)
%   - InverseKinematicResults: results of the inverse kinematics step (see the Documentation for the structure)
%________________________________________________________
%
% Licence
% Toolbox distributed under GPL 3.0 Licence
%________________________________________________________
%
% Authors : Antoine Muller, Charles Pontonnier, Pierre Puchaud and
% Georges Dumont
%________________________________________________________

%% Loading useful files
if ~exist(filename,'dir')
    mkdir(filename)
end
disp(['Inverse kinematics (' filename ') ...'])
Human_model = BiomechanicalModel.OsteoArticularModel;
Markers_set = BiomechanicalModel.Markers;

%% Symbolic function generation
% Markers position with respects to the joint coordinates
nbClosedLoop = sum(~cellfun('isempty',{Human_model.ClosedLoop})); %#ok<NASGU>

%% List of markers from the model
list_markers={};
for ii=1:numel(Markers_set)
    if Markers_set(ii).exist
        list_markers=[list_markers;Markers_set(ii).name]; %#ok<AGROW>
    end
end
%% Number of solids considered in the Inverse Kinematics
if isfield(BiomechanicalModel,'Generalized_Coordinates')
    nb_solid=length(BiomechanicalModel.Generalized_Coordinates.q_red);
else
    nb_solid=size(Human_model,2);  % Number of solids
end

%% Position of the real markers from the c3d file
[real_markers, nb_frame, Firstframe, Lastframe,f_mocap] = Get_real_markers(filename,list_markers,AnalysisParameters);

%% Root position
Base_position=cell(nb_frame,1);
Base_rotation=cell(nb_frame,1);
for ii=1:nb_frame
    Base_position{ii}=zeros(3,1);
    Base_rotation{ii}=eye(3,3);
end

%% Initializations

% Linear constraints for the inverse kinematics
Aeq_ik=[];  % initialization
beq_ik=[];
for ii=1:nb_solid
    if size(Human_model(ii).linear_constraint) ~= [0 0] %#ok<BDSCA>
        Aeq_ik(ii,ii)=-1;
        Aeq_ik(ii,Human_model(ii).linear_constraint(1,1))=Human_model(ii).linear_constraint(2,1);
    end
end

%% Inverse kinematics frame per frame

options1 = optimoptions(@fmincon,'Algorithm','interior-point','Display','off','TolFun',1e-6,'TolCon',1e-6,'MaxFunEvals',10000000,'MaxIter',10000);
q=zeros(nb_solid,nb_frame);
ceq=zeros(6*nbClosedLoop,nb_frame);

addpath('Symbolic_function')

% Joint limits
if isfield(BiomechanicalModel,'Generalized_Coordinates')
    q_map=BiomechanicalModel.Generalized_Coordinates.q_map;
    l_inf1=[Human_model.limit_inf]';
    l_sup1=[Human_model.limit_sup]';
    % to handle infinity
    ind_infinf=not(isfinite(l_inf1));
    ind_infsup=not(isfinite(l_sup1));
    % tip to handle inflinity with a complex number.
    l_inf1(ind_infinf)=1i;
    l_sup1(ind_infsup)=1i;
    % new indexing
    l_inf1=q_map'*l_inf1;
    l_sup1=q_map'*l_sup1;
    %find 1i to replay by inf
    l_inf1(l_inf1==1i)=-inf;
    l_sup1(l_sup1==1i)=+inf;
else
    l_inf1=[Human_model.limit_inf]';
    l_sup1=[Human_model.limit_sup]';
end

if isfield(AnalysisParameters.IK,'weigths')
    
    weights = AnalysisParameters.IK.weights';

else
    
    weights = ones(1,length(real_markers));
end

h = waitbar(0,['Inverse Kinematics (' filename ')']);
% 1st frame : classical optimization

if ~isempty([BiomechanicalModel.OsteoArticularModel.ClosedLoop])
    q0=zeros(nb_solid,1);
    positions = zeros(3, length(real_markers));
    % Precomputation of markers positions at each frame
    for m=1:length(real_markers)
        positions(:,m) = real_markers(m).position(1,:)';
    end
    
    ik_function_objective=@(qvar)CostFunctionSymbolicIK2(qvar,positions(:),weights);
    [q(:,1)] = fmincon(ik_function_objective,q0,[],[],Aeq_ik,beq_ik,l_inf1,l_sup1,[],options1);
    
    if ~isempty(Aeq_ik)
        
        hclosedloophandle = {@(qvar)ClosedLoopceq(qvar);  @(x) Aeq_ik*x - beq_ik} ;
        
    else
        hclosedloophandle = {@(qvar)ClosedLoopceq(qvar)} ;
        
    end
else
    %    q0=BiomechanicalModel.ClosedLoopData.startingq0 ;
    q0=zeros(nb_solid,1);
    
    positions = zeros(3, length(real_markers));
    % Precomputation of markers positions at each frame
    for m=1:length(real_markers)
        positions(:,m) = real_markers(m).position(1,:)';
    end
    
    ik_function_objective=@(qvar)CostFunctionSymbolicIK2(qvar, positions(:),weights);
    nonlcon=@(qvar)ClosedLoop(qvar);
    [q(:,1)] = fmincon(ik_function_objective,q0,[],[],Aeq_ik,beq_ik,l_inf1,l_sup1,nonlcon,options1);
    %hclosedloophandle = {BiomechanicalModel.ClosedLoopData.ConstraintEq;  @(x) Aeq_ik*x - beq_ik} ;
    
    
    if ~isempty(Aeq_ik)
        
        hclosedloophandle = {@(qvar)ClosedLoopceq(qvar);  @(x) Aeq_ik*x - beq_ik} ;
        
    else
        hclosedloophandle = {@(qvar)ClosedLoopceq(qvar)} ;
        
    end
end

buteehandle = @(q)  Limits(q,l_inf1,l_sup1);
gamma = 100;
zeta = 20;

waitbar(1/nb_frame)

optionsLM = optimset('Algorithm','Levenberg-Marquardt','Display','off','MaxIter',4e6,'MaxFunEval',5e6);
positions = zeros(3, length(real_markers));
for f = 2:nb_frame
    
    % Precomputation of markers positions at each frame
    for m=1:length(real_markers)
        positions(:,m) = real_markers(m).position(f,:)';
    end
    
    fun = @(q) CostFunctionLM(q,positions(:),gamma,hclosedloophandle,zeta,buteehandle,weights);
    q(:,f)= lsqnonlin(fun,q(:,f-1),[],[],optionsLM);
    
    waitbar(f/nb_frame)
    
end
close(h)
%% Data processing
if AnalysisParameters.IK.FilterActive
    % data filtering
    q=filt_data(q',AnalysisParameters.IK.FilterCutOff,f_mocap)';
end

% Error computation
KinematicsError=zeros(length(real_markers),nb_frame);

if nbClosedLoop == 0
    for f=1:nb_frame
        positions = zeros(3, length(real_markers));
        % Precomputation of markers positions at each frame
        for m=1:length(real_markers)
            positions(:,m) = real_markers(m).position(f,:)';
        end
        
        [KinematicsError(:,f)] = ErrorMarkersIK(q(:,f),positions(:));
    end
else
    nonlcon=@(qvar)ClosedLoop(qvar);
    
    for f=1:nb_frame
        positions = zeros(3, length(real_markers));
        % Precomputation of markers positions at each frame
        for m=1:length(real_markers)
            positions(:,m) = real_markers(m).position(f,:)';
        end
        [KinematicsError(:,f)] = ErrorMarkersIK(q(:,f),positions(:));
        [~,ceq(:,f)]=nonlcon(q(:,f));
    end
end

% Reaffect coordinates
if isfield(BiomechanicalModel,'Generalized_Coordinates')
    q_complet=q_map*q; % real_coordinates
    fq_dep=BiomechanicalModel.Generalized_Coordinates.fq_dep;
    q_dep_map=BiomechanicalModel.Generalized_Coordinates.q_dep_map;
    for ii=1:size(q,2)
        q_complet(:,ii)=q_complet(:,ii)+q_dep_map*fq_dep(q(:,ii)); % add dependancies
    end
    
    q6dof=[q_complet(end-4:end,:);q_complet(1,:)];
    q=q_complet(1:end-6,:);
    q(1,:)=0;
else
    q6dof=[q(end-4:end,:);q(1,:)];
    q=q(1:end-6,:);
    q(1,:)=0;
end

time=real_markers(1).time';

%% Save data
ExperimentalData.FirstFrame = Firstframe;
ExperimentalData.LastFrame = Lastframe;
ExperimentalData.MarkerPositions = real_markers;
ExperimentalData.Time = time;

InverseKinematicResults.JointCoordinates = q;
InverseKinematicResults.FreeJointCoordinates = q6dof;
InverseKinematicResults.ReconstructionError = KinematicsError;
InverseKinematicResults.NonLinearConstraint = ceq;

disp(['... Inverse kinematics (' filename ') done'])

%% We delete the folder to the path
rmpath('Symbolic_function')
end
