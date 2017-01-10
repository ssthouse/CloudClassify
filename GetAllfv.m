%**************************************************************************
%提取多个颜色空间的均值和标准差特征
%function: Z = GetAllfv(Image)
%Image: 输入图像数据
%Z: 返回一个30维的特征向量，其中依次为RGB,HSV,YCbCr,Lab,CIE各个通道的均值和方差
%**************************************************************************

function Z = GetAllfv(Image)
%Image = imread('C:\Users\l1275\Desktop\11.jpg');
Image_rgb= Image;
Image_hsv = rgb2hsv(Image);
Image_ycbcr = rgb2ycbcr(Image);
Image_lab = rgb2lab(Image);

rgb_avg = zeros(1,3);
rgb_var = zeros(1,3);
for i = 1:3
    rgb_avg(1,i) = mean2(Image_rgb(:,:,i));
    rgb_var(1,i) = std2(Image_rgb(:,:,i))^2;
end


 
hsv_avg = zeros(1,3);
hsv_var = zeros(1,3);
for i = 1:3
    hsv_avg(1,i) = mean2(Image_hsv(:,:,i));
    hsv_var(1,i) = std2(Image_hsv(:,:,i))^2;
end
 
ycbcr_avg = zeros(1,3);
ycbcr_var = zeros(1,3);
for i = 1:3
    ycbcr_avg(1,i) = mean2(Image_ycbcr(:,:,i));
    ycbcr_var(1,i) = std2(Image_ycbcr(:,:,i))^2;
end
 
lab_avg = zeros(1,3);
lab_var = zeros(1,3);
for i = 1:3
    lab_avg(1,i) = mean2(Image_lab(:,:,i));
    lab_var(1,i) = std2(Image_lab(:,:,i))^2;
end
 
R = Image_rgb(:,:,1);
G = Image_rgb(:,:,2);
B = Image_rgb(:,:,3);
[M,N] = size(R);
Image_O = zeros(M,N,3);
Image_O(:,:,1) = power((R - G),2);
Image_O(:,:,2) = power((R + G - B * 2),6);
Image_O(:,:,3) = power((R + G + B),3);
O_avg = zeros(1,3);
O_var = zeros(1,3);
for i = 1:3
    O_avg(1,i) = mean2(Image_O(:,:,i));
    O_var(1,i) = std2(Image_O(:,:,i))^2;
end

 
 I = zeros(1,30);
 
 I(1,1:3) = rgb_avg;
 I(1,4:6) = rgb_var;
 I(1,7:9) = hsv_avg;
 I(1,10:12) = hsv_var;
 I(1,13:15) = ycbcr_avg;
 I(1,16:18) = ycbcr_var;
 I(1,19:21) = lab_avg;
 I(1,22:24) = lab_var;
 I(1,25:27) = O_avg;
 I(1,28:30) = O_var;
 
 Z = I;
 