%Karhunen–Loève Theorem)
clear all;
clc
%Read Input Image for Karhuen-Loeve` transform
%I1=imread('C:\Users\HP\Pictures\test-image3.png');
%I1=imread('C:\Users\HP\Pictures\003.bmp');
I1=imread('C:\Users\HP\Pictures\CompoundData\llya\llya_4.jpg');

I1=rgb2gray(I1(1:fix(size(I1,1)/8)*8,1:fix(size(I1,2)/8)*8,:));  
I=double(I1)/255;
I2 = imresize(I, [64,64]);
%figure(1),subplot(121),
figure(1),imshow(I2);
%Calculate Covariance matrix of image
f=im2col(I2,[8 8],'distinct');% Rearrange each distinct 16-by-16 block in imageI into column of f  
mf=mean(f);%Calculate the mean
x= f - mf';%zero mean variable
Cx=cov(x);
%I is an Image
[rows, columns, numberOfColorChannels]=size(I2);
%submatrix= I2(row1:row2,column1:column);
%Calculate Eigen value and eigen vector 
[eig_vect, eig_val]=eig(Cx);
[img_rec]=(eig_vect).*(eig_val).*(eig_vect');
figure;
imshow(img_rec); 
%[T,B]=normalize(Cx);

f1 = eig_vect'.*x;

eig_vect_nor=norm(eig_vect).*norm(inv(eig_vect));
T1=transpose(Cx);
%figure(1),subplot(121),

%% Restore
f2 = eig_vect'.*f1;
x2 = f2 + mf';
F1=T1.*x;
F2=T1.*x2;
F=F1+F2;
%col2im(F,[8 8],[8 8],'distinct');
%figure(1),subplot(122)
figure(2),imagesc(col2im(F,[8 8],[fix(size(I2,1)/8)*8 fix(size(I2,2)/8)*8],'distinct'));
colormap gray; axis image
title('Compressed');
% Calculate Covariance of F
CF=T1.*Cx.*T1';

