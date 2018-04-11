function [ p ] = Cal_VP( point )

img = imread('sony.bmp');
%imshow(img);
%pt = [168 234 1; 174 366 1; 392 541 1; 392 401 1; 606 429 1; 613 286 1; 387 144 1; 384 269 1];
pt = [162 227 1; 174 366 1; 391 542 1; 393 399 1; 606 431 1; 618 290 1; 379 139 1; 382 277 1];

line21=cross(pt(2,:), pt(1,:));
line34=cross(pt(3,:), pt(4,:));
line56=cross(pt(5,:), pt(6,:));

line32=cross(pt(3,:), pt(2,:));
line41=cross(pt(4,:), pt(1,:));
line67=cross(pt(6,:), pt(7,:));

line17=cross(pt(1,:), pt(7,:));
line46=cross(pt(4,:), pt(6,:));
line35=cross(pt(3,:), pt(5,:));

%line([point(2, 1) point(1, 1)], [point(2, 2) point(1, 2)], 'Color', 'red', 'LineWidth', 2);
%line([point(3, 1) point(4, 1)], [point(3, 2) point(4, 2)], 'Color', 'red', 'LineWidth', 2);
%line([point(5, 1) point(6, 1)], [point(5, 2) point(6, 2)], 'Color', 'red', 'LineWidth', 2);

M1 = line21'*line21 + line34'*line34 + line56'*line56;
[~, ~, v] = svd(M1);
vz = v(:, 3)'/v(3,3);

M2 = line32'*line32 + line41'*line41 + line67'*line67;
[~, ~, v] = svd(M2);
vy = v(:, 3)'/v(3,3);

M3 = line17'*line17 + line46'*line46 + line35'*line35;
[~, ~, v] = svd(M3);
vx = v(:, 3)'/v(3,3);

%o = pt(3,:);
o = [391 542 1];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ax = (pt(5,:)-o)/(vx-pt(5,:))/300;
ay = (pt(2,:)-o)/(vy-pt(2,:))/400;
az = (pt(4,:)-o)/(vz-pt(4,:))/183;
P = [ax*vx' -ay*vy' -az*vz' o'];
%P = [P(:,1) -P(:,2) -P(:,3) P(:,4)];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Hxy = [P(:,1:2),P(:,4)];
Hxz = [P(:,1),P(:,3:4)];
Hyz = P(:,2:4);

% Calculate Texture
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tform = projective2d(inv(Hxy)');
B = imwarp(img, tform);

tform = projective2d(inv(Hxz)');
B = imwarp(img, tform);

tform = projective2d(inv(Hyz)');
B = imwarp(img, tform);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Measure Height
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b0 = o;
t0 = pt(4,:);
b = pt(5,:);
r = pt(6,:);
v = cross(cross(b,b0),cross(vx,vy));
v = v/v(3);
t = cross(cross(v,t0),cross(r,b));
H = 183;
t = t/t(3);
R = H*norm(r-b)*norm(vz-t)/norm(t-b)/norm(vz-r);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calculate transposed coordinates
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Hz = [ax*vx' ay*vy' az*183*vz'+o'];
w = Hz\r';  %w = inv(Hz)*r';
w = w/w(3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

