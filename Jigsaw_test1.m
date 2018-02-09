clc
clear all;
close all;
c=0;
v = {};
u = 1;

for elem = 1:1;
    
    s = strcat('element',num2str(elem),'.mat');
    shape1 = load(s);


    buffer = 15;

    x = [shape1.x(1,end-buffer+1:end) shape1.x(1,:) shape1.x(1,1:buffer)] ;
    y = [shape1.y(1,end-buffer+1:end) shape1.y(1,:) shape1.y(1,1:buffer)] ;
    %x = filter(0.2*ones(1,5),1,x);
    %y = filter(0.2*ones(1,5),1,y);

    corners = [];
    %subplot(2,3,elem)
    
    h = plot(x(buffer+1:end-buffer-1),y(buffer+1:end-buffer-1),'.b');
    axis equal
    hold on
    r=100;
    pause()
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
        k1 = quiver(x(i),y(i),50*cosd(m1M),50*sind(m1M),'LineWidth',2);
        k2 = quiver(x(i),y(i),50*cosd(m2M),50*sind(m2M),'LineWidth',2);
                pause(0.01);

    %%    
        if (abs(m1M-m2M) > 10 && abs(m1M-m2M) < 150 || abs(m1M-m2M) > 220 && abs(m1M-m2M) < 350)
            c = c + 1;
        else
            if(c>1)
                corners = [corners (i-round(c/2))];
                c = 0;
                plot(x(corners(end)),y(corners(end)),'*r','LineWidth',2);
            end
        end
        delete(k1)
        delete(k2)
    end
end
%     plot(x(corners),y(corners),'*r');
%     u = 1;
%     for f = 1:length(corners)
%         if (f == length(corners))
%             edge_x = [x(corners(f)+1:end - buffer) x(1+buffer:corners(1)-1)];
%             edge_y = [y(corners(f)+1:end - buffer) y(1+buffer:corners(1)-1)];
%             v{elem,1,u} = [edge_x - mean(edge_x);edge_y - mean(edge_y)];
%         else
%             edge_x = x(corners(f)+1:corners(f+1)-1);
%             edge_y = y(corners(f)+1:corners(f+1)-1);
%             v{elem,1,u} = [edge_x - mean(edge_x);edge_y - mean(edge_y)];
%         end
%         a = 90;
%         b = -90;
%         epsilon=0.001;               % accuracy value
%         iter= 50;
%         k = 0;
%         tau=double((sqrt(5)-1)/2);
%         edge = v{elem,1,u};
%         %plot(edge(1,:),edge(2,:),'.r');
%         x1=a+(1-tau)*(b-a);             
%         x2=a+tau*(b-a);
%         
%         [func,edgef,f_x1]=fitpoly(edge,x1);                     % computing values in x points
%         [func,edgef,f_x2]=fitpoly(edge,x2);
%         
%         while((abs(b-a) > epsilon) && (k < iter))
%             k = k + 1;
%             if(f_x1 < f_x2)
%                 b=x2;
%                 x2=x1;
%                 x1=a+(1-tau)*(b-a);
%                 [func,edgef,f_x1]=fitpoly(edge,x1);
%                 [func,edgef,f_x2]=fitpoly(edge,x2);
%             else
%                 a=x1;
%                 x1=x2;
%                 x2=a+tau*(b-a);
%                 [func,edgef,f_x1]=fitpoly(edge,x1);
%                 [func,edgef,f_x2]=fitpoly(edge,x2);
%             end
%         end
%          v{elem,2,u} = func;
%          text(mean(edge_x),mean(edge_y),num2str(u));
%          u = u+1;
%          plot(edgef(1,:),edgef(2,:),'.g');
% %         hold off
%     end       
% end
% 
% [el,~,ed] = size(v);
% % 
% % 
% %  for elem = 1:el
% %      for e_ref = 1:ed
%          
%     
% 
% 
% 
% 
% 
