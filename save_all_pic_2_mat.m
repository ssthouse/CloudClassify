% input: 
%       root_folder_name: the root folder name of the trained pics
%       dest_mat_file_name: the dest mat file's name(save in the root path on default)
function save_all_pic_2_mat(root_folder_name, dest_mat_file_name)
    fist_param = 1;
    save(dest_mat_file_name, 'fist_param');
    % iterate all pic_folders in the root path
    pic_root_path = strcat(pwd,filesep, root_folder_name);
    pic_folders = dir(pic_root_path);
    begin_name_index = 1;
    % exclude . & .. & .D_STORE 
    for i=3 : 9
        if(size(strfind(pic_folders(i).name, '.')) ~= 0)
            continue
        end
        pic_folder_path = strcat(pic_root_path, filesep, pic_folders(i).name, filesep);
        begin_name_index = save_folder_pics(pic_folder_path, dest_mat_file_name, begin_name_index);
    end
end

function end_name_index = save_folder_pics(pic_folder_path, dest_mat_file_name, begin_name_index)
    pic_path = strcat(pic_folder_path, '*.jpg');
    pic_files = dir(pic_path);
    for i=1 : size(pic_files)
        % generate variable in matlab
        str_variable_name = strcat('pic', num2str(begin_name_index));
        pic_path = strcat(pic_folder_path, filesep, pic_files(i).name);
        str_open_pic = sprintf('%s = imread(pic_path);', str_variable_name);
        eval(str_open_pic);
        % save generated variable to .mat file
        str_append = '-append';
        str_save = 'save(dest_mat_file_name, str_variable_name, str_append)';
        eval(str_save);
        begin_name_index = begin_name_index + 1;
    end
    end_name_index = begin_name_index;
end