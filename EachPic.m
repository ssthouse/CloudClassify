%**************************************************************************
%��һ��ͼ�ֿ鲢��ȡÿһ��ľ�ֵ�ͷ���
%function: B = EachPic(Image)
%Image: ����ͼ������
%B: ���� 30:m*n �ľ�����ÿ���30:1����ƴ�Ӷ���
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