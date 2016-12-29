function varargout = fist_gui(varargin)
% FIST_GUI MATLAB code for fist_gui.fig
%      FIST_GUI, by itself, creates a new FIST_GUI or raises the existing
%      singleton*.
%
%      H = FIST_GUI returns the handle to a new FIST_GUI or the handle to
%      the existing singleton*.
%
%      FIST_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIST_GUI.M with the given input arguments.
%
%      FIST_GUI('Property','Value',...) creates a new FIST_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fist_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fist_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fist_gui

% Last Modified by GUIDE v2.5 21-Dec-2016 11:24:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fist_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @fist_gui_OutputFcn, ...
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


% --- Executes just before fist_gui is made visible.
function fist_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fist_gui (see VARARGIN)

% Choose default command line output for fist_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fist_gui wait for user response (see UIRESUME)
% uiwait(handles.figure_main);

setappdata(handles.figure_main, 'img_src', 0);

% --- Outputs from this function are returned to the command line.
function varargout = fist_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
set(handles.menu_pic_2b, 'Enable', 'off');


% --------------------------------------------------------------------
function menu_file_Callback(hObject, eventdata, handles)
% hObject    handle to menu_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    

% --------------------------------------------------------------------
function menu_open_Callback(hObject, eventdata, handles)
% hObject    handle to menu_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    [file_name, path_name] = uigetfile({'*.bmp;*.jpg;*.png;*.jpeg', 'Image Files (*.bmp, *.jpg, *.png, *.jpeg)'; ...
'*.*', 'All Files (*.*)'}, 'Pick an image');
    fpath = [path_name, file_name];
    if(isequal(file_name, 0) || isequal(path_name, 0))
        return 
    end
    axes(handles.axes_src);
    im = imread(fpath);
    setappdata(handles.figure_main,'img_src', im);
    imshow(im);
    %enable the menu 2b pic
    set(handles.menu_pic_2b, 'Enable', 'on');

% --------------------------------------------------------------------
function menu_save_Callback(hObject, eventdata, handles)
% hObject    handle to menu_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    im = getappdata(handles.figure_main, 'img_src');
    [file_name, path_name] = uiputfile({'*.bmp', 'BMP Files'; '*.jpg', 'JPG Files'}, 'Pick a Pic');
    if(isequal(file_name, 0) || isequal(path_name, 0))
        return
    else
        fpath = [path_name, file_name];
        imwrite(im, fpath);
    end
    
% --------------------------------------------------------------------
function menu_exit_Callback(hObject, eventdata, handles)
% hObject    handle to menu_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    close(handles.figure_main);


% --------------------------------------------------------------------
function menu_pic_handle_Callback(hObject, eventdata, handles)
% hObject    handle to menu_pic_handle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    


% --------------------------------------------------------------------
function menu_pic_2b_Callback(hObject, eventdata, handles)
% hObject    handle to menu_pic_2b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
        sli = slider;
