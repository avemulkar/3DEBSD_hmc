function [hkl uvw] = myeuler2hkl(p1, p, p2)

for i = 1:length(p1)
u = cos(p1(i))*cos(p2(i)) -sin(p1(i))*sin(p2(i))*cos(p(i));
v = -cos(p1(i))*sin(p2(i))-sin(p1(i))*cos(p2(i))*cos(p(i));
w = sin(p1(i))*sin(p(i));
rot(1,2) = sin(p1(i))*cos(p2(i)) +cos(p1(i))*sin(p2(i))*cos(p(i));
rot(2,2) = -sin(p1(i))*sin(p2(i))+cos(p1(i))*cos(p2(i))*cos(p(i));
rot(3,2) = -cos(p1(i))*sin(p(i));
h = sin(p2(i))*sin(p(i));
k = cos(p2(i))*sin(p(i));
L = cos(p(i));


rot(1,1) = u;
rot(2,1) = v;
rot(3,1) = w;

rot(1,3) = h;
rot(2,3) = k;
rot(3,3) = L;

rot;
rot*rot';
hkl(i,:) = [ h k L];
uvw(i,:) = [u v w];


end 

end