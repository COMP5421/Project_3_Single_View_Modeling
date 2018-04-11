function SaveWRL()
global setPlanes;
global points;
global textureOrigins;
global transformH;

n = size(setPlanes, 1);
fid = fopen('test.wrl','w');
fprintf(fid,'#VRML V2.0 utf8\n\nCollision {\n	collide FALSE\n children [\n');

for i = 1:n
    fprintf(fid, '\nShape {\n   appearance Appearance {\n       texture ImageTexture {\n            url "');
    filename = strcat(num2str(i),'.jpg');
    fprintf(fid, filename);
    fprintf(fid, '"\n       }\n	}\n geometry IndexedFaceSet {\n      coord Coordinate {\n            point [\n');

    tempH = reshape(transformH(i,:),[3,3]);
    tempH = inv(tempH);
    
    for j = 1:4
        poi = setPlanes(i,j);
        current_point = [points(poi,:) 1.0];
        w = tempH*current_point';
        w = w*183;
        fprintf(fid, '              %9.5f %9.5f %9.5f, \n',w(1),w(2),w(3));
    end
    
    fprintf(fid, '\n            ]\n     }\n     coordIndex [\n             ');
    
    for j = 1:4
        fprintf(fid, '%i,', j-1);
    end
    fprintf(fid, '%i,', -1);
   
    cur_texture = imread(filename);
    cur_height = size(cur_texture, 1);
    cur_width = size(cur_texture, 2);
   
    fprintf(fid, '\n        ]\n     texCoord TextureCoordinate {\n          point [\n');
    
%     for j = 1:4
%         poi = setPlanes(i,j);
%         tempp=double([points(poi,1),points(poi,2),1])*tempH;
%         tempp=tempp./tempp(3);
%         fprintf(fid, '          %3.2f %3.2f,\n', ...
%         double(tempp(1) - textureOrigins(i,1))./double(cur_width), ...
%         double(-tempp(2) + textureOrigins(i,2))./double(cur_height));
% 
%     end
    fprintf(fid, '          %3.2f %3.2f,\n', -0,0);
    fprintf(fid, '          %3.2f %3.2f,\n', 1,0);
    fprintf(fid, '          %3.2f %3.2f,\n',1,1);
    fprintf(fid, '          %3.2f %3.2f,\n',-0,1);
    
    fprintf(fid, '\n            ]\n     }\n     texCoordIndex [\n           ');
    for j = 1:4
        fprintf(fid, '%i,', j-1);
    end   
    fprintf(fid, '%i,', -1);
    
    fprintf(fid, '\n        ]\n     solid FALSE\n	}\n}');
end
fprintf(fid, '\n	] \n}');
fclose(fid);
disp('3D Model Saved');


