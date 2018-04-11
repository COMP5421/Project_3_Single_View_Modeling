function GetTexture2(img_width,img_length)
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
            
            tl = points(setPlanes(1,1),:);
            bl = points(setPlanes(1,2),:);
            br = points(setPlanes(1,3),:);
            tr = points(setPlanes(1,4),:);
            xmin = min([tl(1) bl(1) br(1) tr(1)]);
            xmax = max([tl(1) bl(1) br(1) tr(1)]);
            ymin = min([tl(2) bl(2) br(2) tr(2)]);
            ymax = max([tl(2) bl(2) br(2) tr(2)]);
            
            x = [tl(1) bl(1) br(1) tr(1)];
            y = [tl(2) bl(2) br(2) tr(2)];
            ROI = poly2mask(x,y,img_width,img_length);
            Image_Cutted = bsxfun(@times, picture, cast(ROI, class(picture)));
            Image_Cutted = Image_Cutted(round(ymin):round(ymax),round(xmin):round(xmax),:);
            
            B = imwarp(Image_Cutted, tform);  
            imwrite(B,strcat(num2str(t),'.jpg'));
            transformH = [transformH; reshape(Hyz,[1,9])];
        case 2
            tform = projective2d(inv(Hxz)');
            
            tl = points(setPlanes(2,1),:);
            bl = points(setPlanes(2,2),:);
            br = points(setPlanes(2,3),:);
            tr = points(setPlanes(2,4),:);
            xmin = min([tl(1) bl(1) br(1) tr(1)]);
            xmax = max([tl(1) bl(1) br(1) tr(1)]);
            ymin = min([tl(2) bl(2) br(2) tr(2)]);
            ymax = max([tl(2) bl(2) br(2) tr(2)]);
            
            x = [tl(1) bl(1) br(1) tr(1)];
            y = [tl(2) bl(2) br(2) tr(2)];
            ROI = poly2mask(x,y,img_width,img_length);
            Image_Cutted = bsxfun(@times, picture, cast(ROI, class(picture)));
            Image_Cutted = Image_Cutted(round(ymin):round(ymax),round(xmin):round(xmax),:);
            B = imwarp(Image_Cutted, tform); 
            imwrite(B,strcat(num2str(t),'.jpg'));
            transformH = [transformH; reshape(Hxz,[1,9])];
        case 3
            tform = projective2d(inv(Hxy)');
            
            tl = points(setPlanes(3,1),:);
            bl = points(setPlanes(3,2),:);
            br = points(setPlanes(3,3),:);
            tr = points(setPlanes(3,4),:);
            xmin = min([tl(1) bl(1) br(1) tr(1)]);
            xmax = max([tl(1) bl(1) br(1) tr(1)]);
            ymin = min([tl(2) bl(2) br(2) tr(2)]);
            ymax = max([tl(2) bl(2) br(2) tr(2)]);
            
            x = [tl(1) bl(1) br(1) tr(1)];
            y = [tl(2) bl(2) br(2) tr(2)];
            ROI = poly2mask(x,y,img_width,img_length);
            Image_Cutted = bsxfun(@times, picture, cast(ROI, class(picture)));
            Image_Cutted = Image_Cutted(round(ymin):round(ymax),round(xmin):round(xmax),:);
            B = imwarp(Image_Cutted, tform); 
            imwrite(B,strcat(num2str(t),'.jpg'));
            transformH = [transformH; reshape(Hxy,[1,9])];
    end
    
end
end
