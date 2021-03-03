function options=OptionsChoices(BiomechanicalModel,AnimateParameters)
% Extraction of choices for the animation
%
%   INPUT
%   - BiomechanicalModel :  complete model (see the Documentation for the
%   structure)
%   - AnimateParameters : parameters of the animation, automatically
%   generated by the graphic interface 'GenerateAnimate'
%
%   OUTPUT
%   - options : structure of options ticked in the interface
%________________________________________________________
%
% Licence
% Toolbox distributed under GPL 3.0 Licence
%________________________________________________________
%
% Authors : Antoine Muller, Charles Pontonnier, Pierre Puchaud and
% Georges Dumont
%________________________________________________________

%   OUTPUT
%________________________________________________________
%
% Licence
% Toolbox distributed under GPL 3.0 Licence
%________________________________________________________
%
% Authors : Antoine Muller, Charles Pontonnier, Pierre Puchaud and
% Georges Dumont
%________________________________________________________






if isfield(AnimateParameters, 'seg_anim')
    options.seg_anim = AnimateParameters.seg_anim;
else
    options.seg_anim = 0;
end
if isfield(AnimateParameters, 'bone_anim')
    options.bone_anim = AnimateParameters.bone_anim;
else
    options.bone_anim = 0;
end
if isfield(AnimateParameters, 'mass_centers_anim')
    options.mass_centers_anim = AnimateParameters.mass_centers_anim;
else
    options.mass_centers_anim = 0;
end
if isfield(AnimateParameters, 'Global_mass_center_anim')
    options.Global_mass_center_anim = AnimateParameters.Global_mass_center_anim;
else
    options.Global_mass_center_anim = 0;
end
if isfield(AnimateParameters, 'Force_Prediction_points')
    options.Force_Prediction_points = AnimateParameters.Force_Prediction_points;
else
    options.Force_Prediction_points = 0;
end
if isfield(AnimateParameters, 'muscles_anim')
    options.muscles_anim = AnimateParameters.muscles_anim;
else
    options.muscles_anim = 0;
end
% if isfield(AnimateParameters, 'ellipsoid')
%     ellipsoid_anim = AnimateParameters.ellipsoid;
% else
options.ellipsoid_anim = 0;
% end
if isfield(AnimateParameters, 'wrap')
    options.wrap_anim = AnimateParameters.wrap;
else
    options.wrap_anim = 0;
end
if isfield(AnimateParameters, 'mod_marker_anim')
    options.mod_marker_anim = AnimateParameters.mod_marker_anim;
else
    options.mod_marker_anim = 0;
end
if isfield(AnimateParameters, 'exp_marker_anim')
    options.exp_marker_anim = AnimateParameters.exp_marker_anim;
else
    options.exp_marker_anim = 0;
end
if isfield(AnimateParameters, 'external_forces_anim')
    options.external_forces_anim = AnimateParameters.external_forces_anim;
else
    options.external_forces_anim = 0;
end
if isfield(AnimateParameters, 'external_forces_pred')
    options.external_forces_p = AnimateParameters.external_forces_pred;
else
    options.external_forces_p = 0;
end
if isfield(AnimateParameters, 'forceplate')
    options.forceplate = AnimateParameters.forceplate;
else
    options.forceplate = 0;
end
if isfield(AnimateParameters, 'BoS')
    options.BoS = AnimateParameters.BoS;
else
    options.BoS = 0;
end
if isfield(AnimateParameters,'AnatLandmark_names')
    options.AnatLandmark_names=AnimateParameters.AnatLandmark_names;
else
    options.AnatLandmark_names=0;
end

if isfield(AnimateParameters,'AnatLandmark')
    options.AnatLandmark=AnimateParameters.AnatLandmark;
else
    options.AnatLandmark=0;
end

if isfield(AnimateParameters,'Segment')
    options.Segment=AnimateParameters.Segment;
else
    options.Segment=[];
end

if isfield(AnimateParameters,'AnatLandmarknum')
    options.AnatLandmarknum=AnimateParameters.AnatLandmarknum;
else
    options.AnatLandmarknum=[];
end

if isfield(AnimateParameters,'Muscles') && ~isempty(AnimateParameters.Muscles)
    [~,num_mus]=intersect({BiomechanicalModel.Muscles.name},AnimateParameters.Muscles);
    options.num_mus=num_mus';
end


end