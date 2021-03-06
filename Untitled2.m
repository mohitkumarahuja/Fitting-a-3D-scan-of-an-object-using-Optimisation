clear all;
close all;
clc;

% Load entire mat file contents into a structure.
% The structure has a member "I" that is a double 512x512 array.
storedStructure1 = load('HK-233_a_09-Sep-2015_ver1_XYZ+_newZ_nb_clean.mat');
storedStructure2 = load('HK-233_b_09-Sep-2015_ver1_XYZ+_newZ_nb_clean.mat');
storedStructure3 = load('HK-233_c_09-Sep-2015_ver1_XYZ+_newZ_nb_clean.mat');

ptCloud = pointCloud([storedStructure2.Xclean;storedStructure2.Yclean;storedStructure2.Zclean]');
ptCloudB = pcdenoise(ptCloud);
X = ptCloudB.Location(:,1)';
Y = ptCloudB.Location(:,2)';
Z = ptCloudB.Location(:,3)';

% Display the image in a brand new figure window.
figure(1);
% Display double image, scaled appropriately.
% No need to cast to uint8 - could even be bad
% if your double numbers don't span the 0-255 range nicely.

subplot(3,3,1)
plot3(storedStructure1.Xclean, storedStructure1.Yclean, storedStructure1.Zclean, '.r');

subplot(3,3,2)
plot3(storedStructure2.Xclean, storedStructure2.Yclean, storedStructure2.Zclean, '.g');

subplot(3,3,3)
plot3(storedStructure3.Xclean, storedStructure3.Yclean, storedStructure3.Zclean, '.b');

% x = storedStructure1.Xclean((abs(storedStructure1.Zclean) > 2) & (storedStructure1.Zclean < 2.1));
% y = storedStructure1.Yclean((abs(storedStructure1.Zclean) > 2) & (storedStructure1.Zclean < 2.1));
% z = storedStructure1.Zclean((abs(storedStructure1.Zclean) > 2) & (storedStructure1.Zclean < 2.1));

j1 = boundary(storedStructure1.Xclean', storedStructure1.Yclean');
x1 = storedStructure1.Xclean(j1);
y1 = storedStructure1.Yclean(j1);
c1 = find_vertices(x1,y1,5);

j2 = boundary(X', Y');
x2 = storedStructure2.Xclean(j2);
y2 = storedStructure2.Yclean(j2);
c2 = find_vertices(x2,y2,5);

j3 = boundary(storedStructure3.Xclean', storedStructure3.Yclean');
x3 = storedStructure3.Xclean(j3);
y3 = storedStructure3.Yclean(j3);
c3 = find_vertices(x3,y3,5);

% % for i = 1:length(c1)
% %     for j = 1:length(c3)
% %         A = [x1(c1(i)), y1(c1(i))];
% %         B = [x3(c3(j)), y3(c3(j))];
% %         [RotMat,TransVec,dataOut]=icp(x1, x2);  
% %         figure()
% %         plot(dataOut(1,:),dataOut(2,:), '.b');
% %     end
% % end
% 
% % figure()
% % plot(dataOut(1,:),dataOut(2,:),'b.'), axis equal
% 
% edge1x = [x1(c1(1)):x1(c1(2))]';
% edge1y = [y1(c1(1)):y1(c1(2))]';
% % edge1(2,1) = x1(c1(2)):x1(c1(3));
% % edge1(2,2) = y1(c1(2)):y1(c1(3));
% % edge1(3,1) = x1(c1(3)):x1(c1(4));
% % edge1(3,2) = y1(c1(3)):y1(c1(4));
% % edge1(4,1) = x1(c1(4)):x1(c1(1));
% % edge1(4,2) = y1(c1(4)):y1(c1(1));
% 
% % edge2(1,1) = x3(c3(1)):x3(c3(2));
% % edge2(1,2) = y3(c3(1)):y3(c3(2));
% % 
% % edge2(2) = x3(c3(2)):x3(c3(3));
% % edge2(3) = x3(c3(3)):x3(c3(4));
% % edge2(4) = x3(c3(4)):x3(c3(5));
% % edge2(5) = x3(c3(5)):x3(c3(6));
% % edge2(6) = x3(c3(6)):x3(c3(1));
% 
% % [RotMat,TransVec,dataOut]=icp([edge1x, edge1y], [x3, y3]);
% 
% ptCloud1 = pointCloud([x3;y3;zeros(size(x3))]');
% ptCloudedge = pointCloud([edge1x;edge1y;zeros(size(edge1x))]');
% 
% %trans = pcregrigid([edge1x, edge1y], [x3, y3]);
% 
% % for i = 1:length(c3)
% %     [RotMat,TransVec,dataOut]=icp(edge1(i), [x3, y3]);
% % end

X1 = x1(c1(4));
Y1 = y1(c1(4));
X2 = x3(c3(2));
Y2 = y3(c3(2));

figure()
plot3(storedStructure1.Xclean-X1,storedStructure1.Yclean-Y1,storedStructure1.Zclean, '.r');
axis equal;
hold on
plot3(storedStructure3.Xclean-X2,storedStructure3.Yclean-Y2,storedStructure3.Zclean, '.b');
plot(x1(c1),y1(c1),'*g','LineWidth',2);
for i = 1:length(c1)
text(x1(c1(i)),y1(c1(i)),num2str(c1(i)))
end
figure()
plot(x2,y2, '.r');
axis equal;
hold on
plot(x2(c2),y2(c2),'*g','LineWidth',2);
for i = 1:length(c2)
text(x2(c2(i)),y2(c2(i)),num2str(c2(i)))
end
figure()
plot(x3,y3, '.r');
axis equal;
hold on
plot(x3(c3),y3(c3),'*g','LineWidth',2);
for i = 1:length(c3)
text(x3(c3(i)),y3(c3(i)),num2str(c3(i)))
end
% 
% subplot(3,3,5)
% plot(x2,y2, '.r');
% axis equal;
% 
% subplot(3,3,6)
% plot(x3,y3, '.r');
% axis equal;
% X1 = x1(c1(4)); Y1 = y1(c1(4));
% X2 = x3(c3(2)); Y2 = y3(c3(2));
