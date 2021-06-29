function [Human_model]= Foot_TLEM(Human_model,k,Signe,Mass,AttachmentPoint)
%% Fichier de description du mod�le de jambe
% Human_model : partie du mod�le d�j� construite (si il existe)
% attachment_pt : nom du points d'attache (si il existe)
% k : coefficient multiplicateur pour le scaling lin�aire
% Signe : 'R' ou 'L' (Right ou Left)
% Mass : masse du mod�le complet
% scaling_choice  : choix de la m�thode de mise � l'�chelle des donn�es inertielles
% Density : densit� du corps

%% Variables de sortie :
% "enrichissement de la structure "Human_model""

%% Liste des solides
list_solid={'Foot'};

%% Choix jambe droite ou gauche
if Signe == 'R'
    Mirror=[1 0 0; 0 1 0; 0 0 1];
else
    if Signe == 'L'
        Mirror=[1 0 0; 0 1 0; 0 0 -1];
    end
end

%% Incr�mentation du num�ro des groupes
% n_group=0;
% for i=1:numel(Human_model)
%     if size(Human_model(i).Group) ~= [0 0] %#ok<BDSCA>
%         n_group=max(n_group,Human_model(i).Group(1,1));
%     end
% end
% n_group=n_group+1;

%% Incr�mentation de la num�rotation des solides

s=size(Human_model,2)+1;  %#ok<NASGU> % num�ro du premier solide
for i=1:size(list_solid,2)      % num�rotation de chaque solide : s_"nom du solide"
    if i==1
        eval(strcat('s_',list_solid{i},'=s;'))
    else
        eval(strcat('s_',list_solid{i},'=s_',list_solid{i-1},'+1;'))
    end
end

% trouver le num�ro de la m�re � partir du nom du point d'attache : 'attachment_pt'
if numel(Human_model) == 0
    s_mother=0;
    pos_attachment_pt=[0 0 0]';
else
    test=0;
    for i=1:numel(Human_model)
        for j=1:size(Human_model(i).anat_position,1)
            if strcmp(AttachmentPoint,Human_model(i).anat_position{j,1})
                s_mother=i;
                pos_attachment_pt=Human_model(i).anat_position{j,2}+Human_model(s_mother).c;
                test=1;
                break
            end
        end
        if i==numel(Human_model) && test==0
            error([AttachmentPoint ' is no existent'])
        end
    end
    if Human_model(s_mother).child == 0      % si la m�re n'a pas d'enfant
        Human_model(s_mother).child = eval(['s_' list_solid{1}]);    % l'enfant de cette m�re est ce solide
    else
        [Human_model]=sister_actualize(Human_model,Human_model(s_mother).child,eval(['s_' list_solid{1}]));   % recherche de la derni�re soeur
    end
end

%%                      D�finition des noeuds (articulaires)
% TLEM 2.0 � A COMPREHENSIVE MUSCULOSKELETAL GEOMETRY DATASET FOR SUBJECT-SPECIFIC MODELING OF LOWER EXTREMITY
%
%  V. Carbonea*, R. Fluita*, P. Pellikaana, M.M. van der Krogta,b, D. Janssenc, M. Damsgaardd, L. Vignerone, T. Feilkasf, H.F.J.M. Koopmana, N. Verdonschota,c
%
%  aLaboratory of Biomechanical Engineering, MIRA Institute, University of Twente, Enschede, The Netherlands
%  bDepartment of Rehabilitation Medicine, Research Institute MOVE, VU University Medical Center, Amsterdam, The Netherlands
%  cOrthopaedic Research Laboratory, Radboud University Medical Centre, Nijmegen, The Netherlands
%  dAnyBody Technology A/S, Aalborg, Denmark
%  eMaterialise N.V., Leuven, Belgium
%  fBrainlab AG, Munich, Germany
% *The authors Carbone and Fluit contributed equally.
% Journal of Biomechanics, Available online 8 January 2015, http://dx.doi.org/10.1016/j.jbiomech.2014.12.034
%% Adjustement of k
k=k*1.2063; %to fit 50th percentile person of 1.80m height 
% --------------------------- Foot ----------------------------------------

% Position du CoM par rapport au rep�re de r�f�rence
CoM_Foot=k*Mirror*([0.0509	;-0.0161	;0.0139]);

% Position des noeuds
Foot_SubtalarJointNode = (k*Mirror *[0.0000;	0.0000;	0.0000])        - CoM_Foot;
FirstMetatarsalContact=	(k*Mirror *[0.12190;-0.049100;-0.019600])       - CoM_Foot;
SecondMetatarsalContact=	(k*Mirror *[0.11390;-0.049100;-0.0021000])  - CoM_Foot;
FifthMetatarsalContact=	(k*Mirror *[0.097900;-0.049100;0.033000])       - CoM_Foot;
HeelContact=	(k*Mirror *[-0.026100;-0.049100;-0.0021000])            - CoM_Foot;
BigToe=	(k*Mirror *[0.17410;-0.040800;-0.0060000])                      - CoM_Foot;
Cal = k*Mirror*[-0.045 ;  -0.0156  ;  0.0046]                           - CoM_Foot; %measured from stl
TAR = k*Mirror*[105 ;-38.69 ;43]/1000                                   - CoM_Foot; %measured from stl
%% D�finition des positions anatomiques

Foot_position_set= {...
    [Signe 'HEE'], Cal ;... 
    [Signe 'TAR'], TAR; ... 
    [Signe 'TOE'], k*Mirror*[0.1741;-0.035;-0.0080]- CoM_Foot; ... %measured from stl
    [Signe 'TARI'], k*Mirror*[131.7;-29.37;-37]/1000- CoM_Foot; ... % measured from stl
    [Signe 'Foot_SubtalarJointNode'], Foot_SubtalarJointNode; ...
    [Signe 'Foot_ToetipNode'], BigToe; ...
    [Signe 'FirstMetatarsalContact'], FirstMetatarsalContact; ...
    [Signe 'SecondMetatarsalContact'], SecondMetatarsalContact; ...
    [Signe 'FifthMetatarsalContact'], FifthMetatarsalContact; ...
    [Signe 'HeelContact'], HeelContact; ...
    ['ExtensorDigitorumLongus1Via1' Signe 'Foot'],k*Mirror*([0.04651;0.01235;-0.0018])-CoM_Foot;...
    ['ExtensorDigitorumLongus1Via2' Signe 'Foot'],k*Mirror*([0.12646;-0.02591;0.00071])-CoM_Foot;...
    ['ExtensorDigitorumLongus1Insertion3' Signe 'Foot'],k*Mirror*([0.17395;-0.04189;0.01317])-CoM_Foot;...
    ['ExtensorDigitorumLongus2Via1' Signe 'Foot'],k*Mirror*([0.04651;0.01235;-0.0018])-CoM_Foot;...
    ['ExtensorDigitorumLongus2Via2' Signe 'Foot'],k*Mirror*([0.12431;-0.02753;0.01194])-CoM_Foot;...
    ['ExtensorDigitorumLongus2Insertion3' Signe 'Foot'],k*Mirror*([0.16922;-0.04202;0.02498])-CoM_Foot;...
    ['ExtensorDigitorumLongus3Via1' Signe 'Foot'],k*Mirror*([0.04651;0.01235;-0.0018])-CoM_Foot;...
    ['ExtensorDigitorumLongus3Via2' Signe 'Foot'],k*Mirror*([0.11786;-0.03093;0.02267])-CoM_Foot;...
    ['ExtensorDigitorumLongus3Insertion3' Signe 'Foot'],k*Mirror*([0.16016;-0.04209;0.03502])-CoM_Foot;...
    ['ExtensorDigitorumLongus4Via1' Signe 'Foot'],k*Mirror*([0.04651;0.01235;-0.0018])-CoM_Foot;...
    ['ExtensorDigitorumLongus4Via2' Signe 'Foot'],k*Mirror*([0.10859;-0.03239;0.0343])-CoM_Foot;...
    ['ExtensorDigitorumLongus4Insertion3' Signe 'Foot'],k*Mirror*([0.14504;-0.04263;0.0414])-CoM_Foot;...
    ['ExtensorHallucisLongus1Via1' Signe 'Foot'],k*Mirror*([0.05156;0.01481;-0.01398])-CoM_Foot;...
    ['ExtensorHallucisLongus1Insertion2' Signe 'Foot'],k*Mirror*([0.17139;-0.03638;-0.01176])-CoM_Foot;...
    ['ExtensorHallucisLongus2Via1' Signe 'Foot'],k*Mirror*([0.05156;0.01481;-0.01398])-CoM_Foot;...
    ['ExtensorHallucisLongus2Insertion2' Signe 'Foot'],k*Mirror*([0.17139;-0.03638;-0.01176])-CoM_Foot;...
    ['ExtensorHallucisLongus3Via1' Signe 'Foot'],k*Mirror*([0.05156;0.01481;-0.01398])-CoM_Foot;...
    ['ExtensorHallucisLongus3Insertion2' Signe 'Foot'],k*Mirror*([0.17139;-0.03638;-0.01176])-CoM_Foot;...
    ['FlexorDigitorumLongus1Via1' Signe 'Foot'],k*Mirror*([0.01189;-0.00657;-0.02966])-CoM_Foot;...
    ['FlexorDigitorumLongus1Via2' Signe 'Foot'],k*Mirror*([0.01725;-0.00771;-0.02803])-CoM_Foot;...
    ['FlexorDigitorumLongus1Insertion3' Signe 'Foot'],k*Mirror*([0.17072;-0.04781;0.01191])-CoM_Foot;...
    ['FlexorDigitorumLongus2Via1' Signe 'Foot'],k*Mirror*([0.01189;-0.00657;-0.02966])-CoM_Foot;...
    ['FlexorDigitorumLongus2Via2' Signe 'Foot'],k*Mirror*([0.01725;-0.00771;-0.02803])-CoM_Foot;...
    ['FlexorDigitorumLongus2Insertion3' Signe 'Foot'],k*Mirror*([0.16725;-0.04775;0.02419])-CoM_Foot;...
    ['FlexorDigitorumLongus3Via1' Signe 'Foot'],k*Mirror*([0.01189;-0.00657;-0.02966])-CoM_Foot;...
    ['FlexorDigitorumLongus3Via2' Signe 'Foot'],k*Mirror*([0.01725;-0.00771;-0.02803])-CoM_Foot;...
    ['FlexorDigitorumLongus3Insertion3' Signe 'Foot'],k*Mirror*([0.15795;-0.04771;0.03348])-CoM_Foot;...
    ['FlexorDigitorumLongus4Via1' Signe 'Foot'],k*Mirror*([0.01189;-0.00657;-0.02966])-CoM_Foot;...
    ['FlexorDigitorumLongus4Via2' Signe 'Foot'],k*Mirror*([0.01725;-0.00771;-0.02803])-CoM_Foot;...
    ['FlexorDigitorumLongus4Insertion3' Signe 'Foot'],k*Mirror*([0.14244;-0.04648;0.04012])-CoM_Foot;...
    ['FlexorHallucisLongus1Via1' Signe 'Foot'],k*Mirror*([-0.00459;0.00114;-0.02048])-CoM_Foot;...
    ['FlexorHallucisLongus1Insertion2' Signe 'Foot'],k*Mirror*([0.16693;-0.04508;-0.01198])-CoM_Foot;...
    ['FlexorHallucisLongus2Via1' Signe 'Foot'],k*Mirror*([-0.00459;0.00114;-0.02048])-CoM_Foot;...
    ['FlexorHallucisLongus2Insertion2' Signe 'Foot'],k*Mirror*([0.16693;-0.04508;-0.01198])-CoM_Foot;...
    ['FlexorHallucisLongus3Via1' Signe 'Foot'],k*Mirror*([-0.00459;0.00114;-0.02048])-CoM_Foot;...
    ['FlexorHallucisLongus3Insertion2' Signe 'Foot'],k*Mirror*([0.16693;-0.04508;-0.01198])-CoM_Foot;...
    ['GastrocnemiusLateralis1Insertion1' Signe 'Foot'],k*Mirror*([-0.03679;-0.01718;-0.00014])-CoM_Foot;...
    ['GastrocnemiusMedialis1Insertion1' Signe 'Foot'],k*Mirror*([-0.03679;-0.01718;-0.01014])-CoM_Foot;...
    ['PeroneusBrevis1Via1' Signe 'Foot'],k*Mirror*([-0.00411;0.00868;0.01552])-CoM_Foot;...
    ['PeroneusBrevis1Via2' Signe 'Foot'],k*Mirror*([0.03351;-0.01785;0.02532])-CoM_Foot;...
    ['PeroneusBrevis1Insertion3' Signe 'Foot'],k*Mirror*([0.10508;-0.04435;0.03364])-CoM_Foot;...
    ['PeroneusBrevis2Via1' Signe 'Foot'],k*Mirror*([-0.00411;0.00868;0.01552])-CoM_Foot;...
    ['PeroneusBrevis2Via2' Signe 'Foot'],k*Mirror*([0.03351;-0.01785;0.02532])-CoM_Foot;...
    ['PeroneusBrevis2Insertion3' Signe 'Foot'],k*Mirror*([0.10508;-0.04435;0.03364])-CoM_Foot;...
    ['PeroneusBrevis3Via1' Signe 'Foot'],k*Mirror*([-0.00411;0.00868;0.01552])-CoM_Foot;...
    ['PeroneusBrevis3Via2' Signe 'Foot'],k*Mirror*([0.03351;-0.01785;0.02532])-CoM_Foot;...
    ['PeroneusBrevis3Insertion3' Signe 'Foot'],k*Mirror*([0.04494;-0.02783;0.03219])-CoM_Foot;...
    ['PeroneusLongus1Via1' Signe 'Foot'],k*Mirror*([-0.00342;0.00126;0.01741])-CoM_Foot;...
    ['PeroneusLongus1Via2' Signe 'Foot'],k*Mirror*([0.00962;-0.01494;0.02008])-CoM_Foot;...
    ['PeroneusLongus1Via3' Signe 'Foot'],k*Mirror*([0.04096;-0.02919;0.01887])-CoM_Foot;...
    ['PeroneusLongus1Insertion4' Signe 'Foot'],k*Mirror*([0.08292;-0.01936;-0.00997])-CoM_Foot;...
    ['PeroneusLongus2Via1' Signe 'Foot'],k*Mirror*([-0.00342;0.00126;0.01741])-CoM_Foot;...
    ['PeroneusLongus2Via2' Signe 'Foot'],k*Mirror*([0.00962;-0.01494;0.02008])-CoM_Foot;...
    ['PeroneusLongus2Via3' Signe 'Foot'],k*Mirror*([0.04096;-0.02919;0.01887])-CoM_Foot;...
    ['PeroneusLongus2Insertion4' Signe 'Foot'],k*Mirror*([0.08292;-0.01936;-0.00997])-CoM_Foot;...
    ['PeroneusLongus3Via1' Signe 'Foot'],k*Mirror*([-0.00342;0.00126;0.01741])-CoM_Foot;...
    ['PeroneusLongus3Via2' Signe 'Foot'],k*Mirror*([0.00962;-0.01494;0.02008])-CoM_Foot;...
    ['PeroneusLongus3Via3' Signe 'Foot'],k*Mirror*([0.04096;-0.02919;0.01887])-CoM_Foot;...
    ['PeroneusLongus3Insertion4' Signe 'Foot'],k*Mirror*([0.08292;-0.01936;-0.00997])-CoM_Foot;...
    ['Plantaris1Insertion1' Signe 'Foot'],k*Mirror*([-0.03679;-0.01718;-0.00514])-CoM_Foot;...
    ['SoleusLateralis1Insertion1' Signe 'Foot'],k*Mirror*([-0.03679;-0.01718;-0.00014])-CoM_Foot;...
    ['SoleusLateralis2Insertion1' Signe 'Foot'],k*Mirror*([-0.03679;-0.01718;-0.00014])-CoM_Foot;...
    ['SoleusLateralis3Insertion1' Signe 'Foot'],k*Mirror*([-0.03679;-0.01718;-0.00014])-CoM_Foot;...
    ['SoleusMedialis1Insertion1' Signe 'Foot'],k*Mirror*([-0.03679;-0.01718;-0.01014])-CoM_Foot;...
    ['SoleusMedialis2Insertion1' Signe 'Foot'],k*Mirror*([-0.03679;-0.01718;-0.01014])-CoM_Foot;...
    ['SoleusMedialis3Insertion1' Signe 'Foot'],k*Mirror*([-0.03679;-0.01718;-0.01014])-CoM_Foot;...
    ['TibialisAnterior1Via1' Signe 'Foot'],k*Mirror*([0.03967;0.01383;-0.02391])-CoM_Foot;...
    ['TibialisAnterior1Insertion2' Signe 'Foot'],k*Mirror*([0.07628;-0.02512;-0.01172])-CoM_Foot;...
    ['TibialisAnterior2Via1' Signe 'Foot'],k*Mirror*([0.03967;0.01383;-0.02391])-CoM_Foot;...
    ['TibialisAnterior2Insertion2' Signe 'Foot'],k*Mirror*([0.07628;-0.02512;-0.01172])-CoM_Foot;...
    ['TibialisAnterior3Via1' Signe 'Foot'],k*Mirror*([0.03967;0.01383;-0.02391])-CoM_Foot;...
    ['TibialisAnterior3Insertion2' Signe 'Foot'],k*Mirror*([0.06649;-0.02515;-0.02191])-CoM_Foot;...
    ['TibialisPosteriorLateralis1Via1' Signe 'Foot'],k*Mirror*([0.00929;0.01141;-0.03534])-CoM_Foot;...
    ['TibialisPosteriorLateralis1Via2' Signe 'Foot'],k*Mirror*([0.01331;0.00573;-0.03424])-CoM_Foot;...
    ['TibialisPosteriorLateralis1Via3' Signe 'Foot'],k*Mirror*([0.01795;-0.0011;-0.03315])-CoM_Foot;...
    ['TibialisPosteriorLateralis1Insertion4' Signe 'Foot'],k*Mirror*([0.04489;-0.01477;-0.02404])-CoM_Foot;...
    ['TibialisPosteriorLateralis2Via1' Signe 'Foot'],k*Mirror*([0.00929;0.01141;-0.03534])-CoM_Foot;...
    ['TibialisPosteriorLateralis2Via2' Signe 'Foot'],k*Mirror*([0.01331;0.00573;-0.03424])-CoM_Foot;...
    ['TibialisPosteriorLateralis2Via3' Signe 'Foot'],k*Mirror*([0.01795;-0.0011;-0.03315])-CoM_Foot;...
    ['TibialisPosteriorLateralis2Insertion4' Signe 'Foot'],k*Mirror*([0.04489;-0.01477;-0.02404])-CoM_Foot;...
    ['TibialisPosteriorLateralis3Via1' Signe 'Foot'],k*Mirror*([0.00929;0.01141;-0.03534])-CoM_Foot;...
    ['TibialisPosteriorLateralis3Via2' Signe 'Foot'],k*Mirror*([0.01331;0.00573;-0.03424])-CoM_Foot;...
    ['TibialisPosteriorLateralis3Via3' Signe 'Foot'],k*Mirror*([0.01795;-0.0011;-0.03315])-CoM_Foot;...
    ['TibialisPosteriorLateralis3Insertion4' Signe 'Foot'],k*Mirror*([0.04489;-0.01477;-0.02404])-CoM_Foot;...
    ['TibialisPosteriorMedialis1Via1' Signe 'Foot'],k*Mirror*([0.00929;0.01141;-0.03534])-CoM_Foot;...
    ['TibialisPosteriorMedialis1Via2' Signe 'Foot'],k*Mirror*([0.01331;0.00573;-0.03424])-CoM_Foot;...
    ['TibialisPosteriorMedialis1Via3' Signe 'Foot'],k*Mirror*([0.01795;-0.0011;-0.03315])-CoM_Foot;...
    ['TibialisPosteriorMedialis1Insertion4' Signe 'Foot'],k*Mirror*([0.04489;-0.01477;-0.02404])-CoM_Foot;...
    ['TibialisPosteriorMedialis2Via1' Signe 'Foot'],k*Mirror*([0.00929;0.01141;-0.03534])-CoM_Foot;...
    ['TibialisPosteriorMedialis2Via2' Signe 'Foot'],k*Mirror*([0.01331;0.00573;-0.03424])-CoM_Foot;...
    ['TibialisPosteriorMedialis2Via3' Signe 'Foot'],k*Mirror*([0.01795;-0.0011;-0.03315])-CoM_Foot;...
    ['TibialisPosteriorMedialis2Insertion4' Signe 'Foot'],k*Mirror*([0.04489;-0.01477;-0.02404])-CoM_Foot;...
    ['TibialisPosteriorMedialis3Via1' Signe 'Foot'],k*Mirror*([0.00929;0.01141;-0.03534])-CoM_Foot;...
    ['TibialisPosteriorMedialis3Via2' Signe 'Foot'],k*Mirror*([0.01331;0.00573;-0.03424])-CoM_Foot;...
    ['TibialisPosteriorMedialis3Via3' Signe 'Foot'],k*Mirror*([0.01795;-0.0011;-0.03315])-CoM_Foot;...
    [Signe 'FootPrediction1'], k*Mirror*[-0.04;0.1185;-0.03]*0.9359;... % A replacer
    [Signe 'FootPrediction2'], k*Mirror*[-0.04;0.1185;-0.007]*0.9359;...% A replacer
    [Signe 'FootPrediction3'], k*Mirror*[-0.03;0.035;0.015]*0.9359;...% A replacer
    [Signe 'FootPrediction4'], k*Mirror*[-0.025;0.01;-0.04]*0.9359;...% A replacer
    [Signe 'FootPrediction5'], k*Mirror*[-0.04;-0.0525;-0.035]*0.9359;...% A replacer
    [Signe 'FootPrediction6'], k*Mirror*[-0.035;-0.0525;-0.0125]*0.9359;...% A replacer
    [Signe 'FootPrediction7'], k*Mirror*[-0.03;-0.045;0.0015]*0.9359;...% A replacer
    [Signe 'FootPrediction8'], k*Mirror*[-0.04;-0.035;0.015]*0.9359;...% A replacer
    [Signe 'FootPrediction9'], k*Mirror*[-0.04;-0.02;0.025]*0.9359;...% A replacer
    [Signe 'FootPrediction10'], k*Mirror*[-0.04;-0.075;0.04]*0.9359;...% A replacer
    [Signe 'FootPrediction11'], k*Mirror*[-0.045;-0.117;0.002]*0.9359;...% A replacer
    [Signe 'FootPrediction12'], k*Mirror*[-0.04;-0.095;-0.025]*0.9359;...% A replacer
    [Signe 'FootPrediction13'], k*Mirror*[-0.045;-0.1;0.015]*0.9359;...% A replacer
    [Signe 'FootPrediction14'], k*Mirror*[-0.045;-0.09;0.03]*0.9359;...% A replacer
    [Signe 'HEEManutention'], k*Mirror*[0.035 0.12946 -0.02]'; ...% A replacer
    [Signe 'TARManutention'], k*Mirror*[-0.01 -0.04 0.04]'; ...% A replacer
    [Signe 'TARIManutention'], k*Mirror*[-0.01 -0.055 -0.05]'; ...% A replacer
    [Signe 'ANEManutention'], k*Mirror*[0.01 0.05 0.015]'; ...% A replacer
    };

%%                     Mise � l'�chelle des inerties
    %% ["Adjustments to McConville et al. and Young et al. body segment inertial parameters"] R. Dumas
    % --------------------------- Foot ----------------------------------------
    Length_Foot = norm(HeelContact-SecondMetatarsalContact);
    [I_Foot]=rgyration2inertia([37 17 36 13 0 8*1i], Mass.Foot_Mass, [0 0 0], Length_Foot, Signe);

%% Cr�ation de la structure "Human_model"

num_solid=0;
%% Foot
% s_Foot
num_solid=num_solid+1;        % solide num�ro ...
name=list_solid{num_solid}; % nom du solide
eval(['incr_solid=s_' name ';'])  % num�ro du solide dans le mod�le
Human_model(incr_solid).name=[Signe name];
Human_model(incr_solid).sister=0;
Human_model(incr_solid).child=0;
Human_model(incr_solid).mother=s_mother;
Human_model(incr_solid).a=[0.8784	0.4638	0.1152]';
Human_model(incr_solid).joint=1;
Human_model(incr_solid).calib_k_constraint=s_mother;
Human_model(incr_solid).limit_inf=-pi/4;
Human_model(incr_solid).limit_sup=pi/2;
Human_model(incr_solid).ActiveJoint=1;
Human_model(incr_solid).Visual=1;
% Human_model(incr_solid).Group=[n_group 3];
Human_model(incr_solid).m=Mass.Foot_Mass;
Human_model(incr_solid).b=pos_attachment_pt;
Human_model(incr_solid).I=[I_Foot(1) I_Foot(4) I_Foot(5); I_Foot(4) I_Foot(2) I_Foot(6); I_Foot(5) I_Foot(6) I_Foot(3)];
Human_model(incr_solid).c=-Foot_SubtalarJointNode;
Human_model(incr_solid).anat_position=Foot_position_set;
Human_model(incr_solid).L={[Signe 'Foot_SubtalarJointNode'];[Signe 'BigToe']};
Human_model(incr_solid).calib_a=1;
%Calibration de l'axe de rotation
a1=Human_model(incr_solid).a;
[~,Ind]=max(abs(a1));
a2=zeros(3,1);
a2(Ind)=1;
R=Rodrigues_from_two_axes(a2,a1); % recherche des deux axes orthogonaux � l'axe de rotation
Human_model(incr_solid).limit_alpha= [ 20 , -20;... %[limit_sup premier axe, limit_inf premier axe;...
                                        30, -30]; %limit_sup 2nd axe, limit_inf 2nd axe;...
Human_model(incr_solid).v= [ R(:,2) , R(:,3) ];
Human_model(incr_solid).visual_file = ['TLEM/' Signe 'Foot.mat'];
if Signe == 'R'
    Human_model(incr_solid).comment='Subtalar Inversion(-)/Eversion(+)';
else
    Human_model(incr_solid).comment='Subtalar Inversion(+)/Eversion(-)';
end


end
