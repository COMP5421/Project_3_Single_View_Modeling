function GetTexture(img_width,img_length)
global transformH;
global setPlanes;
global points;
global picture;
global textureOrigins;
global Hxy Hxz Hyz;

transformH = rand(0,9);
textureOrigins = rand(0,2);

n = size(setPlanes, 1);
for t = 1:n
    switch t
        case 1
            tform = projective2d(inv(Hyz)');
            
    
            B = imwarp(picture, tform);  
            imwrite(B,strcat(num2str(t),'.jpg'));
            transformH = [transformH; reshape(Hyz,[1,9])];
        case 2
            tform = projective2d(inv(Hxz)');
            
           
            B = imwarp(picture, tform); 
            imwrite(B,strcat(num2str(t),'.jpg'));
            transformH = [transformH; reshape(Hxz,[1,9])];
        case 3
            tform = projective2d(inv(Hxy)');
            
           
            B = imwarp(picture, tform); 
            imwrite(B,strcat(num2str(t),'.jpg'));
            transformH = [transformH; reshape(Hxy,[1,9])];
    end
    
end
end