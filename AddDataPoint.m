function AddDataPoint(x,y)
global DataType;
global ParallelPointX ParallelPointY ParallelPointZ;
global ParallelLineX ParallelLineY ParallelLineZ;
global vx vy vz;
global Direction;
global Origin;
global hpoint;
global points;
global a_x;
global a_y;
global a_z;
global rpoints;

switch DataType
    case 'Parallel_Lines'
        disp(x);disp(y);
        switch Direction
            case 'X'
                ParallelPointX = [ParallelPointX; [x,y]];
                num_of_points = size(ParallelPointX, 1);
                if mod(num_of_points,2) == 0
                    p1 = double([ParallelPointX(num_of_points,:),1]);
                    p2 = double([ParallelPointX(num_of_points-1,:),1]);
                    line = cross(p1, p2);
                    line = line./line(3);
                    ParallelLineX = [ParallelLineX; line];
                    disp(line);
                end
            case 'Y'
                ParallelPointY = [ParallelPointY; [x,y]]; 
                num_of_points = size(ParallelPointY, 1);
                if mod(num_of_points,2) == 0
                    p1 = double([ParallelPointY(num_of_points,:),1]);
                    p2 = double([ParallelPointY(num_of_points-1,:),1]);
                    line = cross(p1,p2);
                    line = line./line(3);
                    ParallelLineY = [ParallelLineY; line];
                    disp(line);
                end
            case 'Z'
                ParallelPointZ = [ParallelPointZ; [x,y]];
                num_of_points = size(ParallelPointZ,1);
                if mod(num_of_points,2) == 0
                    p1 = double([ParallelPointZ(num_of_points,:),1]);
                    p2 = double([ParallelPointZ(num_of_points-1,:),1]);
                    line = cross(p1,p2);
                    line = line./line(3);
                    ParallelLineZ = [ParallelLineZ; line];
                    disp(line);
                end
        end    
        
    case 'Origin'
        num_of_points = size(Origin,1);
        if num_of_points == 0
            Origin = [x,y];
            disp(Origin);
        end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
    case 'Reference_Point'
        Input_Length = inputdlg({'Length'}, 'Input Length', 1, {'0'});
        len = str2double(Input_Length{1});
        switch Direction
            case 'X'
                a_x = (sum(vx - [x; y; 1.0]) \ sum([x, y, 1.0] - double([Origin, 1]))) / len;
                rpoints(1,:) = [x, y, len, 0, 0];
            case 'Y'
                a_y = (sum(vy - [x; y; 1.0]) \ sum([x, y, 1.0] - double([Origin, 1]))) / len;
                rpoints(2,:) = [x, y, 0, len, 0];
            case 'Z'
                a_z = (sum(vz - [x; y; 1.0]) \ sum([x, y, 1.0] - double([Origin, 1]))) / len;
                rpoints(3,:) = [x, y, 0, 0, len];
                hpoint = [x,y,0,0,len];
        end
        disp(x);disp(y);
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
    case 'Measuring_Points'
        points = [points; x y];
        disp(x);disp(y);
%         if mod(size(points, 1), 2) == 0
%             an = double(H)*double([x; y; 1.0]);
%             an = an./an(3);
%             a = an(1);
%             b = an(2);
%             c = 0;
%         else
%             num_of_points = size(points,1);
%             a = points(num_of_points, 3);
%             b = points(num_of_points, 4);
%             bm = double([points(num_of_points,1), points(num_of_points,2), 1]);
%             o = double([Origin,1]);
%             t = [x, y, 1];
%             c = -dot(o',vl')*norm(cross(bm',t'))/dot(bm',vl')/norm(cross(vz',t'))/a_z;
%         end
%         points = [points; x y a b c];
%         disp(x);disp(y);


    
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
end