function Cal()
global P;
global Hxy Hxz Hyz;
%global H;
global a_x a_y a_z;
global vx vy vz;
global Origin;

disp('alpha:');
disp(a_x);
disp(a_y);
disp(a_z);


P = [a_x*vx', -a_y*vy', -a_z*vz', [Origin,1]'];
disp('P:');
disp(P);
size(P)
Hxy = [P(:,1) P(:,2) P(:,4)+P(:,3).*183];
Hxz = [P(:,1) P(:,3) P(:,4)];
Hyz = [P(:,2) P(:,3) P(:,4)];
%H = inv([P(:,1) P(:,2) P(:,4)]);