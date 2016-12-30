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
Image_cie = rgb2xyz(Image);

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
 
cie_avg = zeros(1,3);
cie_var = zeros(1,3);
for i = 1:3
    cie_avg(1,i) = mean2(Image_cie(:,:,i));
    cie_var(1,i) = std2(Image_cie(:,:,i))^2;
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
 I(1,25:27) = cie_avg;
 I(1,28:30) = cie_var;
 
 Z = I;
 