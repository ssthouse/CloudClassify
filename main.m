function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 25-Dec-2016 22:35:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --------------------------------------------------------------------
function menu_open_pic_Callback(hObject, eventdata, handles)
% hObject    handle to menu_open_pic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    % 1.get file name & path
    [file_name, path_name] = uigetfile({'*.jpg;*.png', 'Image Files'; '*.*', 'All FIles'}, 'Choose a pic');
    if(isequal(file_name, 0) || isequal(path_name, 0))
        return
    end
    % 2.open the file to axes
    axes(handles.axes_disp)
    imshow(imread([path_name, file_name]));

% Generate all .mat files
function generate_test_and_train_mat(train_folder_name, test_folder_name)
    base_pic_dir = strcat(pwd, filesep, train_folder_name, filesep);
    generate_mat_files(base_pic_dir)
    base_pic_dir = strcat(pwd, filesep, test_folder_name, filesep);
    generate_mat_files(base_pic_dir)
    
function generate_mat_files(pic_root_path)
    %iterate the specific pic_folder in the root_path
    pic_files = dir(pic_root_path);
    for i = 1 : size(pic_files)
        %exclude the sys files
        if(size(strfind(pic_files(i).name, '.')) ~= 0)
            continue;
        end
        %use Piliangchuli to generate all the .mat files
        pic_path = strcat(pic_root_path, pic_files(i).name, filesep);
        Piliangchuli(pic_path, pic_path);
    end

% --------------------------------------------------------------------
function menu_open_dir_Callback(hObject, eventdata, handles)
% hObject    handle to menu_open_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    %1. open dir chooser
    folder_name = uigetdir();
    if(isequal(folder_name, 0))
        return; 
    end

% Get all train instance's label vector
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

% ???? mat ???? vector
function mat_vector = get_mat_vector(file_path)
    load(file_path);
    mat_vector = Z;
    %disp(mat_vector);
    
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

% --- Executes on button press in btn_detect.
function btn_detect_Callback(hObject, eventdata, handles)
% hObject    handle to btn_detect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    test_both();
    
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