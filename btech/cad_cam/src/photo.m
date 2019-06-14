% clear all
% clc
% a=imread('e:\wallpaper\horror\hell (2).jpg');
% imshow(a);
% pause(1);
% for i=1:600
%     for j=1:800
%         if a(i,j)=32
%             a(i,j)=50;
%         end
%     end
% end
% imshow(a);
% pause(1);
% background = imopen(a,strel('disk',15));
% a1 = imsubtract(a,background);
% imshow(a1);
% pause(1);
% a2=imadjust(a1);
% imshow(a2,[0.3 0.5;0.6 0.1],[],09);
%*****************************************************************
clc;
clear all;
t=imread('e:\Wallpaper\automobiles\car1.jpg');
imshow(t);
xlabel('original photo');
t1=t;
pause(1);
for i=1:20:800          %change the colour tone
    t1(:,:,3)=100;
    %t1(:,:,2)=80;
    t1(:,:,1)=70;
end
imshow(t1);
pause(1);
for k=1:3               %makes the grid
    for i=1:10:600
        for j=1:10:800
            t1(i,:,k)=j;
            t1(:,j,k)=i;
        end
    end
end
% pause(2);
% for k=1:1:3
%     for i=1:1:600
%         for j=1:1:800
%             if t1(i,j,k)=50
%                 t1(i,j,k)=0;
%             end
%         end
%     end
% end
imshow(t1);
pause(1);
zoom(20);
bk=t1(1,:,:);
t1=t1-bk;
xlabel('processed photo');