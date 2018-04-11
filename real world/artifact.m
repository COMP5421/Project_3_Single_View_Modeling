%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate R from H
base = [1957 2705 1];
base0 = pt(1,:);
t0 = pt(3,:);
r = [1993 1531 1];
v = cross(cross(base,base0),cross(vx,vy));
v = v/v(3);
t = cross(cross(v,t0),cross(r,base));
t = t/t(3);
R = 1800*norm(r-base)*norm(vz-t)/(norm(t-base)*norm(vz-r));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extract texture
p = [86 455 1; 85 414 1; 352 388 1; 350 316 1];
X = [p(1,1) p(2,1) p(3,1) p(4,1)];
Y = [p(1,2) p(2,2) p(3,2) p(4,2)];
X_ = [0 0 1500 1500];
Y_ = [0 150 0 150];                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   

A = zeros(8, 8);
b = zeros(8, 1);
for i=1:4        
    A(2*i-1,1:3) = [X(i) Y(i) 1];
    A(2*i-1,7:8) = -X_(i)*[X(i) Y(i)];
    A(2*i,4:6) = [X(i) Y(i) 1];
    A(2*i,7:8) = -Y_(i)*[X(i) Y(i)];
    b(2*i-1) = X_(i);
    b(2*i) = Y_(i);
end

x = A\b;
H = [x(1:3,:)'; x(4:6,:)'; x(7:8,:)' 1];
Ho = inv(H);
Ho = Ho/Ho(3,3);
tform = projective2d(inv(Ho)');
B = imwarp(crop, tform);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pt = [1346 1291 1; 1350 725 1; 1493 1297 1; 1500 727 1; 1314 1217 1; 1319 731 1];

Mx = cross(pt(1,:), pt(3,:))'*cross(pt(1,:), pt(3,:)) + cross(pt(2,:), pt(4,:))'*cross(pt(2,:), pt(4,:));
[~, ~, v] = svd(Mx);
vx = v(:, 3)'/v(3,3);
My = cross(pt(1,:), pt(5,:))'*cross(pt(1,:), pt(5,:)) + cross(pt(2,:), pt(6,:))'*cross(pt(2,:), pt(6,:));
[~, ~, v] = svd(My);
vy = v(:, 3)'/v(3,3);
Mz = cross(pt(1,:), pt(2,:))'*cross(pt(1,:), pt(2,:)) + cross(pt(3,:), pt(4,:))'*cross(pt(3,:), pt(4,:));
[~, ~, v] = svd(Mz);
vz = v(:, 3)'/v(3,3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%