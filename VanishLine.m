sample = imread('sample.png');
imshow(sample);
point = [168 234 1; 174 366 1; 392 541 1; 392 401 1; 606 429 1; 613 286 1; 387 144 1];

line21=cross(point(2,:), point(1,:));
line34=cross(point(3,:), point(4,:));
line56=cross(point(5,:), point(6,:));

line32=cross(point(3,:), point(2,:));
line41=cross(point(4,:), point(1,:));
line67=cross(point(6,:), point(7,:));

line17=cross(point(1,:), point(7,:));
line46=cross(point(4,:), point(6,:));
line35=cross(point(3,:), point(5,:));

%line([point(2, 1) point(1, 1)], [point(2, 2) point(1, 2)], 'Color', 'red', 'LineWidth', 2);
%line([point(3, 1) point(4, 1)], [point(3, 2) point(4, 2)], 'Color', 'red', 'LineWidth', 2);
%line([point(5, 1) point(6, 1)], [point(5, 2) point(6, 2)], 'Color', 'red', 'LineWidth', 2);

M1 = line21'*line21 + line34'*line34 + line56'*line56;
[~, ~, v] = svd(M1);
vx = v(:, 3)'/v(3,3);

M2 = line32'*line32 + line41'*line41 + line67'*line67;
[~, ~, v] = svd(M2);
vy = v(:, 3)'/v(3,3);

M3 = line17'*line17 + line46'*line46 + line35'*line35;
[~, ~, v] = svd(M3);
vz = v(:, 3)'/v(3,3);

l = cross(vx, vy)/norm(cross(vx, vy));

ax = -1/300*norm(cross(point(3,:),point(5,:)))/norm(cross(vx,point(5,:)))/(l*point(3,:)');
ay = -1/400*norm(cross(point(3,:),point(2,:)))/norm(cross(vy,point(2,:)))/(l*point(3,:)');
az = -1/183*norm(cross(point(3,:),point(4,:)))/norm(cross(vz,point(4,:)))/(l*point(3,:)');
P = [ax*vx' ay*vy' az*vz' l'];