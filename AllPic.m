%**************************************************************************
%????????????????????????
%function: Res = AllPic(number)
%number:??????????????
%pathTest;??????????????.mat????????
%B: ???? 240:num ????????????????????????????????????
%**************************************************************************
function Res = AllPic(number,pathTest,sz)
 run('.', filesep, 'vlfeat-0.9.19', filesep, 'toolbox', filesep, 'vl_setup');
    m = 0;
    Data = cell(1,number);
    L = zeros(1,number);
    Res = zeros(60,number);
%   load('C:\Users\l1275\Desktop\all_pic.mat');
    load(pathTest);
    for i = 1:number
        pici=eval(strcat('pic',num2str(i)));
        Data{i} = EachPic(pici,sz);
        L(1,i) = size(Data{i},2);
        m = m + size(Data{i},2);
    end
    n = 1;
    Z = zeros(30,m);
    for i = 1:number
        Z(:,n:n + size(Data{i},2) - 1) = Data{i};
        n = n + size(Data{i},2);
    end
    [M,C,P] = vl_gmm(Z,1);
    m = 1;
    for i = 1:number
        Res(:,i) = vl_fisher(Z(:,m:m + L(1,i) - 1),M,C,P);
        m = m + L(1,i);
    end
end