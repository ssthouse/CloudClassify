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

% Last Modified by GUIDE v2.5 14-Feb-2017 19:01:23

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
    % 1.get file name & path
    [file_name, path_name] = uigetfile({'*.jpg;*.png', 'Image Files'; '*.*', 'All FIles'}, 'Choose a pic');
    if(isequal(file_name, 0) || isequal(path_name, 0))
        return
    end
    % 2.open the file to axes
    axes(handles.axes_disp)
    imshow(imread([path_name, file_name]));

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

% detect a single pic 
function btn_detect_single_pic_Callback(hObject, eventdata, handles)
    test_all();
    
% depresed
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
    
% depresed
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
    
% to detect all the test folder pics using the .mat data
function detect_label_vector = test_all()
    % combine the color & texture data from train samples
    load('M_sum.mat');
    train_matrix_left = double(M_sum');
    load('color_matrix_train.mat');
    train_matrix_right = double(ans');
    train_matrix = [train_matrix_left, train_matrix_right];
    
    % train the svm model
    train_label = generate_train_label(24);
    model = svmtrain(train_label, train_matrix);
    
    % combine the color & texture data from test samples
    test_label = generate_test_label_vector(8);
    load('M_sum_test.mat');
    test_matrix_left = double(M_sum_test');
    load('color_matrix_test.mat');
    test_matrix_right = double(ans');
    test_matrix = [test_matrix_left, test_matrix_right];
    
    % use the svm model to detect cloud types
    detect_label_vector = svmpredict(test_label, test_matrix, model);

% detect all the cloud type in test folder
function btn_detect_all_test_files_Callback(hObject, eventdata, handles)
    detect_label_vector = test_all();
    % TODO disp the result in the tbale UI 
    all_cloud_names = {'Altocumulus', 'Cirrocumulus', 'Cirrus', 'Cumulus', 'Sky', 'Stratus'};
    total_length = length(detect_label_vector);
    table_data = {};
    disp(table_data);
    for i = 1 : total_length
        index = (i - mod(i, 8))/8+ 1;
        if mod(i, 8) == 0
            index = index - 1;
        end
        table_data{i, 1} = all_cloud_names{index};
        table_data{i, 2} = all_cloud_names{detect_label_vector(i, 1)};
        table_data{i, 3} =  strcmp(table_data{i, 1}, table_data{i, 2});
    end
    handles.table_all_pic_result.Data = table_data;
    
