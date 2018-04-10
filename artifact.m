img = imread('indoor.jpg');
%imshow(img);
pt = [1572 1341 1; 2704 1393 1; 1569 488 1; 2710 440 1; 814 1878 1; 617 61 1; 3178 2138 1; 3109 120 1];

Mx = cross(pt(1,:), pt(2,:))'*cross(pt(1,:), pt(2,:)) + cross(pt(5,:), pt(7,:))'*cross(pt(5,:), pt(7,:));
[~, ~, v] = svd(Mx);
vx = v(:, 3)'/v(3,3);
My = cross(pt(1,:), pt(5,:))'*cross(pt(1,:), pt(5,:)) + cross(pt(2,:), pt(7,:))'*cross(pt(2,:), pt(7,:));
[~, ~, v] = svd(My);
vy = v(:, 3)'/v(3,3);
Mz = cross(pt(1,:), pt(3,:))'*cross(pt(1,:), pt(3,:)) + cross(pt(2,:), pt(4,:))'*cross(pt(2,:), pt(4,:));
[~, ~, v] = svd(Mz);
vz = v(:, 3)'/v(3,3);

X = [pt(1,1) pt(2,1) pt(5,1) pt(7,1)];
Y = [pt(1,2) pt(2,2) pt(5,2) pt(7,2)];
X_ = [0 1000 0 1000];
Y_ = [0 0 1000 1000];                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   

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
H = [x(1:3,:)'; x(4:6,:)'; x(7:8,:)' 1]; % Homography matrix (from image to scene)
Ho = inv(H);
Ho = Ho/Ho(3,3);
b_ = pt(2,:)';
t_ = pt(4,:)';
o = Ho(:,3);
%az = -norm(cross(b_,t_))/(o'*b_*norm(cross(vz',t_)));
pcp = cross(Ho(1,:)',Ho(2,:)'); % cross product of P1 and P2
gamma = -(pcp'*o)*norm(cross(b_,t_))/1000/(pcp'*b_*norm(cross(vz,t_)));

P = [Ho(:,1) Ho(:,2) -gamma*vz' Ho(:,3)];
Hxy = [P(:,1:2),P(:,4)];
Hxz = [P(:,1),P(:,3:4)];
Hyz = P(:,2:4);

tform = projective2d(inv(Hxy)');
floor = imwarp(img, tform);

tform = projective2d(inv(Hxz)');
window = imwarp(img, tform);

tform = projective2d(inv(Hyz)');
left = imwarp(img, tform);

% ax = (pt(1,:)-pt(2,:))/(vx-pt(1,:))/1000;
% ay = (pt(7,:)-pt(2,:))/(vy-pt(7,:))/1000;
% az = (pt(4,:)-pt(2,:))/(vz-pt(4,:))/1000;
% P = [ax*vx' -ay*vy' -az*vz' pt(2,:)'];
% Hyz = P(:,2:4);
% tform = projective2d(inv(Hyz)');
% right = imwarp(img, tform);

base = [2585 1388 1];
base0 = pt(1,:);
t0 = pt(3,:);
r = [2591 232 1];
v = cross(cross(base,base0),cross(vx,vy));
v = v/v(3);
t = cross(cross(v,t0),cross(r,base));
t = t/t(3);
R = 1000*norm(r-base)*norm(vz-t)/(norm(t-base)*norm(vz-r));

Hz = [P(:,1) P(:,3) P(:,2)*200+o];
tform = projective2d(inv(Hz)');
chairfront = imwarp(img, tform);

p=[74 1 1; 125 53 1; 41 78 1; 76 115 1];
X = [p(1,1) p(2,1) p(3,1) p(4,1)];
Y = [p(1,2) p(2,2) p(3,2) p(4,2)];
X_ = [0 800 0 800];
Y_ = [0 0 100 100];                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   

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
H = [x(1:3,:)'; x(4:6,:)'; x(7:8,:)' 1]; % Homography matrix (from image to scene)
Ho = inv(H);
Ho = Ho/Ho(3,3);
vx=cross(cross(pt(1,:),pt(2,:)),cross(pt(3,:),pt(4,:)));
vy=cross(cross(pt(1,:),pt(3,:)),cross(pt(2,:),pt(4,:)));
ax=(pt(2,:)-pt(1,:))/(vx-pt(2,:))/200;
ay=(pt(3,:)-pt(1,:))/(vx-pt(3,:))/120;
Hz=[ax*vx' ay*vy' pt(1,:)'];
tform = projective2d(inv(Hz)');
B = imwarp(img, tform);

% [2697 1 1] [2843 158 1] [2591 232 1] [2701 344 1]