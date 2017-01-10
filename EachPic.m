%**************************************************************************
%将一张图分块并提取每一块的均值和方差
%function: B = EachPic(Image)
%Image: 输入图像数据
%B: 返回 30:m*n 的矩阵，由每块的30:1向量拼接而成
%**************************************************************************
function B = EachPic(Image,sz) 
% Image = imread('C:\Users\l1275\Desktop\11.jpg');
    [M,N,O] = size(Image);
    m = fix(M/sz);
    n = fix(N/sz);
    k = 1;
    B = zeros(30,n * m);
    for i = 1:m
        for j = 1:n
                B(:,k) = GetAllfv(Image(sz * (i - 1) + 1:sz * i,sz * (j - 1) + 1:sz * j,:));
                k = k + 1;
        end
    end
end