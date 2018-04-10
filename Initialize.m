function Initialize()

global picture;
picture = 0;

global DataType;
DataType = 'Parallel_Lines';

global Direction;
Direction = 'X';

global Origin;
Origin = int64(rand(0,2));

global ParallelPointX ParallelPointY ParallelPointZ;
global ParallelLineX ParallelLineY ParallelLineZ;
ParallelPointX = int64(rand(0,2));
ParallelPointY = int64(rand(0,2));
ParallelPointZ = int64(rand(0,2));
ParallelLineX = rand(0,3);
ParallelLineY = rand(0,3);
ParallelLineZ = rand(0,3);

global vx vy vz vl;
vx=double([0 0 0]);
vy=double([0 0 0]);
vz=double([0 0 0]);
vl=double([0 0 0]);

global afa;
afa=0;
global rpoints;
rpoints = rand(3,5);
global hpoint;
hpoint = rand(0,5);
global Hxy Hxz Hyz;
Hxy = double(rand(3,3));
Hxz = double(rand(3,3));
Hyz = double(rand(3,3));
global points;
points = double(rand(0,2));
global setPlanes;
setPlanes = rand(0,4);
global Transform_H;
Transform_H = rand(0,9);
global textureOrigins;
textureOrigins = rand(0,2);
end

