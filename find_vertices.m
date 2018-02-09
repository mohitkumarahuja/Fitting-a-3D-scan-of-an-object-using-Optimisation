function corners = find_vertices(shape1x, shape1y, buffer)

c = 0;


    x = [shape1x(1,end-buffer+1:end) shape1x(1,:) shape1x(1,1:buffer)] ;
    y = [shape1y(1,end-buffer+1:end) shape1y(1,:) shape1y(1,1:buffer)] ;
    x = filter(0.2*ones(1,3),1,x);
    y = filter(0.2*ones(1,3),1,y);

    corners = [];

    for i = 1+buffer:size(x,2)-buffer
        m1 = 0;
        m2 = 0;
        for shift = 1:buffer
            th1 = atan2d((y(i+shift) - y(i)),(x(i+shift) - x(i)));
            th2 = atan2d((y(i-shift) - y(i)),(x(i-shift) - x(i)));
            th1 = ((th1<0)*360) + th1;
            th2 = ((th2<0)*360) + th2;
            m1 = [m1 th1];
            m2 = [m2 th2];
                
        end 
        m1M = median(m1);
        m2M = median(m2);

    %%    
        if (abs(m1M-m2M) > 10 && abs(m1M-m2M) < 150 || abs(m1M-m2M) > 220 && abs(m1M-m2M) < 350)
            c = c + 1;
        else
            if(c>1)
                corners = [corners (i-round(c/2))];
                c = 0;

            end
        end
    end
    corners = corners - buffer-1;
end