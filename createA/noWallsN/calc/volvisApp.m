function volvisApp(x,y,z,v)
% volvisApp provides interactive volume visualization
%
% Ex:
% [x,y,z,v] = flow;
% volvisApp(x,y,z,v)



%% Initalize visualization
figure(99);
s = volumeVisualization(x,y,z,v);
s.addSlicePlane(s.zMin,s.xMin,s.yMin,s.zMin,s.xMin,s.yMin);
%s.addSlicePlane(s.xMin);

%% Add uicontrol
hSlider = uicontrol(...
    'Units','normalized', ...
    'Position',[.75 .05 .2 0.05], ...
    'Style','slider', ...
    'Min',s.zMin, ...
    'Max',s.zMax, ...
    'Value',s.zMin, ...
    'Callback',@updateSliderPosition);

hSlider2 = uicontrol(...
    'Units','normalized', ...
    'Position',[.75 .1 .2 .05], ...
    'Style','slider', ...
    'Min',s.xMin, ...
    'Max',s.xMax, ...
    'Value',s.xMin, ...
    'Callback',@updateSliderPosition);
hSlider3 = uicontrol(...
    'Units','normalized', ...
    'Position',[.75 .15 .2 .05], ...
    'Style','slider', ...
    'Min',s.yMin, ...
    'Max',s.yMax, ...
    'Value',s.yMin, ...
    'Callback',@updateSliderPosition);


%% Add uicontrol 2
hSlider4 = uicontrol(...
    'Units','normalized', ...
    'Position',[.75 .2 .2 0.05], ...
    'Style','slider', ...
    'Min',s.zMin, ...
    'Max',s.zMax, ...
    'Value',s.zMin, ...
    'Callback',@updateSliderPosition);

hSlider5 = uicontrol(...
    'Units','normalized', ...
    'Position',[.75 .25 .2 .05], ...
    'Style','slider', ...
    'Min',s.xMin, ...
    'Max',s.xMax, ...
    'Value',s.xMin, ...
    'Callback',@updateSliderPosition);
hSlider6 = uicontrol(...
    'Units','normalized', ...
    'Position',[.75 .3 .2 .05], ...
    'Style','slider', ...
    'Min',s.yMin, ...
    'Max',s.yMax, ...
    'Value',s.yMin, ...
    'Callback',@updateSliderPosition);





%%
    function updateSliderPosition(varargin)
        s.deleteLastSlicePlane();
        zloc = get(hSlider,'Value');
        xloc = get(hSlider2,'Value');
        yloc = get(hSlider3,'Value');
        
        zloc_ = get(hSlider4,'Value');
        xloc_ = get(hSlider5,'Value');
        yloc_ = get(hSlider6,'Value');
        
        
        
        tit = ['(',num2str(round(xloc)),'mm ,',num2str(round(yloc)),'mm ,',num2str(round(zloc)),'mm) ', '(',num2str(round(xloc_)),'mm ,',num2str(round(yloc_)),'mm ,',num2str(round(zloc_)),'mm)'];
        title(tit)
        s.addSlicePlane(zloc,xloc,yloc,zloc_,xloc_,yloc_);
    end


    

end
