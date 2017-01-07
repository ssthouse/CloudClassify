function pic_sift_vector= GetDsiftVector(image_path)
    run(strcat('.', filesep, 'vlfeat-0.9.19', filesep, 'toolbox', filesep, 'vl_setup'));
    shift_image = imread(image_path);
    m=rgb2gray(shift_image) ;
    %figure,imshow(m);
    %????????????????128????????????
    sift_pic_11 =  mysiftvector(m);
    %??????????????????????????????????
    pic_4=sort_picture(m,2);
    for y=1:4
        eval([' sift_pic_4',num2str(y),'=',' mysiftvector(pic_4{y})',';']);
    end

    %??????????????????????????????????
    pic_9=sort_picture(m,3);
    for z=1:9
        eval([' sift_pic_9',num2str(z),'=',' mysiftvector(pic_9{z})',';']);
    end
    func_pic_sift_vector=[sift_pic_11, sift_pic_41,...
        sift_pic_42, sift_pic_43, sift_pic_44, sift_pic_91, sift_pic_92, sift_pic_93,...
        sift_pic_94,sift_pic_95,sift_pic_96,sift_pic_97,sift_pic_98,sift_pic_99];
    pic_sift_vector = reshape(func_pic_sift_vector,1,128*14);
end
    
%??????????m*n????????
function  pic = sort_picture(gray_pic,pic_number)
    [a,b,c]=size(gray_pic)
    pic_m=(a-26)/pic_number;
    pic_n=(b-26)/pic_number;
    B={};
    for i=1:a/pic_m
        for j=1:b/pic_n

            B=[B {gray_pic((i-1)*pic_m+1:pic_m*i,(j-1)*pic_n+1:j*pic_n,:)}];

        end
    end
    pic = B;
end

%????????d-sift????????????????????????128????????????
function siftvector = mysiftvector(gray_pic)
    %figure,imshow(gray_pic);
    binSize = 8 ;
    magnif = 3 ;
    I=single(gray_pic);
    Is = vl_imsmooth(I, sqrt((binSize/magnif)^2 - .25)) ;
    [f, d] = vl_dsift(Is, 'size', binSize) ;
    sift_mn= size(d);
    sift_m = sift_mn(1,1);
    sift_n = sift_mn(1,2);
    for x_m=1:sift_m
        sift_n_number = 0;
        sift_n_number_avg =0;
         for x_n=1:sift_n
            sift_n_number = sift_n_number+ double(d(x_m,x_n )); % ??????????
         end
         sift_n_number_avg = sift_n_number/sift_n;
         sift_pic(x_m,1) =  sift_n_number_avg; % ??????????
    end
    siftvector=sift_pic;
end
 
 



