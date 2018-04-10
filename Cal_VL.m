function Cal_VL()
global ParallelLineX ParallelLineY ParallelLineZ;
global vx vy vz vl;
n = size(ParallelLineX, 1);

if n > 1
    m = double(zeros(3,3));
    for i = 1:n
        for p = 1:3
            for q = 1:3
                m(p,q) = m(p,q) + ParallelLineX(i,p)*ParallelLineX(i,q);
            end
        end 
    end
    [~, ~, v] = svd(m);
    vx = v(:, 3)'/v(3,3);
end

n = size(ParallelLineY, 1);
if n > 1
    m = double(zeros(3,3));
    for i = 1:n
        for p = 1:3
            for q = 1:3
                m(p,q) = m(p,q) + ParallelLineY(i,p)*ParallelLineY(i,q);
            end
        end 
    end
    [~, ~, v] = svd(m);
    vy = v(:, 3)'/v(3,3);

end

n = size(ParallelLineZ, 1);
if n > 1
    m = double(zeros(3,3));
    for i = 1:n
        for p = 1:3
            for q = 1:3
                m(p,q) = m(p,q) + ParallelLineZ(i,p)*ParallelLineZ(i,q);
            end
        end 
    end

    [~, ~, v] = svd(m);
    vz = v(:, 3)'/v(3,3);
end

if (size(ParallelLineX,1)>1)&&(size(ParallelLineY,1)>1)
    vl = cross(vx,vy);
    vl = vl./vl(3);
end

end