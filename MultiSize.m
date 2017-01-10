function Re = MultiSize(number,pathTest)
Data = cell(1,3);
Data{1} = AllPic(number,pathTest,24);
Data{2} = AllPic(number,pathTest,36);
Data{3} = AllPic(number,pathTest,48);
m = size(Data{1},2);
Re = zeros(180,m);
n = 1;
for i = 1:3
    Re(1 + 60 * (i - 1):60 * i,:) = Data{i};
end