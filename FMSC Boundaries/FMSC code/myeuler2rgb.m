function rgb = euler2rgb(eulers) 
% converts euler angles to ipf rgb values
% assumes cubic symmetry

% convert to mtex orientation
cs = symmetry('cubic');
ss = symmetry('cubic');
o = orientation('Euler',eulers,cs,ss);
rgb = orientation2color(o,'ipdf','antipodal');

% the colorcoding
%ebsdColorbar(symmetry('cubic'),'colorcoding','ipdf','antipodal',...
%'position',[100 100 400 210])