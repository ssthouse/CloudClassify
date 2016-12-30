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


global image_vector;

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
vector = GetAllfv(imread([path_name, file_name]));
disp([path_name, file_name]);
Piliangchuli(path_name, path_name);
disp(vector);

% disp(image_vector)
% disp(file_name);

% --------------------------------------------------------------------
function menu_open_dir_Callback(hObject, eventdata, handles)
% hObject    handle to menu_open_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%1. open dir chooser
folder_name = uigetdir();
if(isequal(folder_name, 0))
    iterate_all_mat();
    return; 
end
%2. generate .mat file for every pic
path_name = strcat(folder_name, '/');
Piliangchuli(path_name, path_name);
disp(path_name);

%Iterate all the folder to get all mat files
function train_instance_matrix = iterate_all_mat()
    result = [];
    pic_path = strcat(pwd, '/pic');
    pic_folders = dir(pic_path);
    row_index = 1;
    for i = 1 : size(pic_folders)
        % get pic path one by one
        folder_name = pic_folders(i).name;
        if(size(strfind(folder_name, '.')) ~= 0)
            continue;
        end
        cur_pic_dir = strcat(pic_path, '/', folder_name);
        % disp(cur_pic_dir)
        % iterate each mat file in the pic path
        mat_path = strcat(cur_pic_dir, '/*.mat');
        mat_files = dir(mat_path);
        for j = 1 : size(mat_files)
            file_path = strcat(cur_pic_dir, '/', mat_files(j).name);
            disp(file_path);
            disp(row_index);
            result = cat(1, result, get_mat_vector(file_path));
            row_index = row_index +1;
        end
    end
    disp(result);
    train_instance_matrix = result;

% Get a .mat file vector
function mat_vector = get_mat_vector(file_path)
    load(file_path);
    mat_vector = Z;
  disp(mat_vector);

% --- Executes on button press in btn_detect.
function btn_detect_Callback(hObject, eventdata, handles)
% hObject    handle to btn_detect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
