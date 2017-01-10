% Get all train instance's label vector
load('M_sum.mat');
    train_matrix_left = double(M_sum');
    load('color_matrix_train.mat');
    train_matrix_right = double(ans');
    train_matrix = [train_matrix_left, train_matrix_right];
    
    train_label = generate_train_label(24);
    model = svmtrain(train_matrix, train_label);
    
    test_label = generate_test_label_vector(8);
    load('M_sum_test.mat');
    test_matrix_left = double(M_sum_test');
    load('color_matrix_test.mat');
    test_matrix_right = double(ans');
    test_matrix = [test_matrix_left, test_matrix_right];
    result_label = svmpredict(test_label, test_matrix, model);
    disp(result_label);
    
    
function train_instance_label = generate_train_label(sample_size)
    train_sample_sum = sample_size;
    result = zeros(train_sample_sum * 6, 1);
    row_index = 1;
    for j = 1 : 6    
        for i = 1 : train_sample_sum
            result(row_index, 1) = double(j);
            row_index = row_index + 1;
        end
    end
    %disp(result);
    train_instance_label = result;
end
%Iterate all the folder to get all mat files
function train_instance_matrix = get_train_instance_matrix()
    result = zeros(24*6, 30);
    pic_path = strcat(pwd, filesep, 'train');
    pic_folders = dir(pic_path);
    row_index = 1;
    for i = 1 : size(pic_folders)
        % get pic path one by one
        folder_name = pic_folders(i).name;
        if(size(strfind(folder_name, '.')) ~= 0)
            continue;
        end
        cur_pic_dir = strcat(pic_path, filesep, folder_name);
        % disp(cur_pic_dir)
        % iterate each mat file in the pic path
        mat_path = strcat(cur_pic_dir, filesep, '*.mat');
        mat_files = dir(mat_path);
        for j = 1 : size(mat_files)
            file_path = strcat(cur_pic_dir, filesep, mat_files(j).name);
            %disp(file_path);
            %disp(row_index);
            %result = cat(1, result, get_mat_vector(file_path));
            result(row_index, :) = get_mat_vector(file_path);
            row_index = row_index +1;
        end
    end
    %disp(result);
    train_instance_matrix = result;
end
% ???? mat ???? vector
function mat_vector = get_mat_vector(file_path)
    load(file_path);
    mat_vector = Z;
    %disp(mat_vector);
end
%use generated mat files to classify pics
function begin_pic_detect()
    %generate model
    train_label_vector = generate_train_label(24);
    train_instance_matrix = get_train_instance_matrix();
    model = svmtrain(train_label_vector, train_instance_matrix);
    disp(model);
    % test result
    test_label_vector = generate_test_label_vector(8);
    test_instance_matrix = get_test_instance_matrix();
    disp(size(test_label_vector))
    disp(size(test_instance_matrix))
    result = svmpredict(test_label_vector, test_instance_matrix, model);
    disp(result);
end
%generate label vector
function test_label_vector = generate_test_label_vector(sample_size)
    size = sample_size;
    result = zeros(size * 6, 1);
    row_index = 1;
    for j = 1 : 6    
        for i = 1 : size
            result(row_index, 1) = double(j);
            row_index = row_index + 1;
        end
    end
    %disp(result);
    test_label_vector = result;
end
%generate instance matrix by color
function test_instance_matrix = get_test_instance_matrix()
    result = [];
    pic_path = strcat(pwd, filesep, 'test', filesep);
    pic_folders = dir(pic_path);
    row_index = 1;
    for i = 1 : size(pic_folders)
        % get pic path one by one
        folder_name = pic_folders(i).name;
        if(size(strfind(folder_name, '.')) ~= 0)
            continue;
        end
        cur_pic_dir = strcat(pic_path, filesep, folder_name);
        % disp(cur_pic_dir)
        % iterate each mat file in the pic path
        mat_path = strcat(cur_pic_dir, filesep, '*.mat');
        mat_files = dir(mat_path);
        for j = 1 : size(mat_files)
            file_path = strcat(cur_pic_dir, filesep, mat_files(j).name);
            %disp(file_path);
            %disp(row_index);
            result = cat(1, result, get_mat_vector(file_path));
            row_index = row_index +1;
        end
    end
    %disp(result);
    test_instance_matrix = result;
end
% --- Executes on button press in btn_detect.
function btn_detect_Callback(hObject, eventdata, handles)
% hObject    handle to btn_detect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    %test_all();

    %test_enhanced_hanyu();

    test_enhanced_gaojie();
end
    
%generate shift bases matrix and save to mat file : "shift.mat"
function generate_shift_feature_mat_file(folder_name, result_file_name)
    mat_file_path = strcat(pwd,filesep, result_file_name);
    %generate matrix
    result = [];
    pic_path = strcat(pwd, filesep, folder_name);
    pic_folders = dir(pic_path);
    row_index = 1;
    for i = 1 : size(pic_folders)
        % get pic path one by one
        folder_name = pic_folders(i).name;
        if(size(strfind(folder_name, '.')) ~= 0)
            continue;
        end
        cur_pic_dir = strcat(pic_path, filesep, folder_name);
        % disp(cur_pic_dir)
        % iterate each mat file in the pic path
        mat_path = strcat(cur_pic_dir, filesep, '*.jpg');
        mat_files = dir(mat_path);
        for j = 1 : size(mat_files)
            file_path = strcat(cur_pic_dir, filesep, mat_files(j).name);
            %disp(file_path);
            %disp(row_index);
            result = cat(1, result, GetDsiftVector(file_path));
            %result(row_index, :) = get_mat_vector(file_path);
            row_index = row_index +1;
        end
    end
    disp(result);
    save(mat_file_path, 'result');
end
%test using shift feature to classify pics
function test_shift_detet()
    load('shift.mat');
    train_instance_matrix = result;
    train_label_vector = generate_train_label(24);
    model = svmtrain(train_label_vector, train_instance_matrix);
    disp(model);
    % get test vector
    load('test.mat')
    test_instance_matrix = result;
    test_label_vector = generate_test_label_vector(8);
    result_label = svmpredict(test_label_vector, test_instance_matrix, model);
    disp(result_label);
end
%use shift and color feature to classify pics
function test_both()
    load('shift.mat');
    train_instance_matrix_left = result;
    train_instance_matrix_right = get_train_instance_matrix();
    train_matrix = [train_instance_matrix_left, train_instance_matrix_right];
    
    train_label_vector = generate_train_label(24);
    model = svmtrain(train_label_vector, train_matrix);
    %disp(model);
    %disp(train_label_vector);
    
    %test predict
    load('test.mat')
    test_instance_matrix_left = result;
    test_instance_matrix_right = get_test_instance_matrix();
    test_instance_matrix = [test_instance_matrix_left, test_instance_matrix_right];
    test_instance_label = generate_test_label_vector(8);
    predicted_label = svmpredict(test_instance_label, test_instance_matrix, model);
 
    disp(predicted_label);
    %disp(test_instance_label);
end
    
function test_enhanced_gaojie()
    load('M_sum.mat');
    train_matrix = double(M_sum');
    train_label = generate_train_label(24);
    model = svmtrain(train_label, train_matrix);
    
    load('M_sum_test.mat');
    test_label = generate_test_label_vector(8);
    test_matrix = double(M_sum_test');
    result_label = svmpredict(test_label, test_matrix, model);
    disp(result_label);
end
    
function test_enhanced_hanyu()
    load('color_matrix_train.mat');
    train_matrix = double(ans');
    train_label = generate_train_label(24);
    model = svmtrain(train_label, train_matrix);
    
    load('color_matrix_test.mat');
    test_label = generate_test_label_vector(8);
    test_matrix = double(ans');
    result_label = svmpredict(test_label, test_matrix, model);
    disp(result_label);
end
    
function test_all()
    load('M_sum.mat');
    train_matrix_left = double(M_sum');
    load('color_matrix_train.mat');
    train_matrix_right = double(ans');
    train_matrix = [train_matrix_right, train_matrix_left];
    
    train_label = generate_train_label(24);
    model = svmtrain(train_label, train_matrix);
    
    test_label = generate_test_label_vector(8);
    load('M_sum_test.mat');
    test_matrix_left = double(M_sum_test');
    load('color_matrix_test.mat');
    test_matrix_right = double(ans');
    test_matrix = [test_matrix_right, test_matrix_left];
    result_label = svmpredict(test_label, test_matrix, model);
    disp(result_label);
end