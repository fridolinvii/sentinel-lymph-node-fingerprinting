function s = volumeVisualization(x,y,z,v)

%% Create a variable to store pointers to the various planes
hAxis = [];         %initialize handle to axis
hSlicePlanes1 = [];  %initialize handle to slice plane
hSlicePlanes2 = [];  %initialize handle to slice plane
hSlicePlanes3 = [];  %initialize handle to slice plane

hSlicePlanes4 = [];  %initialize handle to slice plane
hSlicePlanes5 = [];  %initialize handle to slice plane
hSlicePlanes6 = [];  %initialize handle to slice plane

hSlicePlanes7 = [];  %initialize handle to slice plane
hSlicePlanes8 = [];  %initialize handle to slice plane
hSlicePlanes9 = [];  %initialize handle to slice plane

%% Create data for generic slice through yz-plane
[yd,xd] = meshgrid(linspace(min(y(:)),max(y(:)),100), ...
    linspace(min(x(:)),max(x(:)),100));
[~,zd] = meshgrid(linspace(min(y(:)),max(y(:)),100), ...
    linspace(min(z(:)),max(z(:)),100));
[zo,~] = meshgrid(linspace(min(z(:)),max(z(:)),100), ...
    linspace(min(y(:)),max(y(:)),100));


%% projection %%
sigmax = 1; sigmay = 1; sigmaz = 1;
[vx,vy,vz] =  projection(v,x,sigmax,sigmay,sigmaz);
vedge = v;
vedge(end,:,:) = vx*max(v(:))/max(vx(:));
vedge(:,end,:) = vy*max(v(:))/max(vy(:));
vedge(:,:,1) = vz*max(v(:))/max(vz(:));
%vedge = vedge.^2;
%vedge = vedge*max(v(:))/max(vedge(:));

%% Plot the volume initially
initDisplay()

%% Nested Functions

    function addSlicePlane(zLoc,xLoc,yLoc,zLoc_,xLoc_,yLoc_,zLoc__,xLoc__,yLoc__)
        % addSlicePlane   Add a slice plane at specified x-coordinate.
        zd1            = zLoc*ones(size(yd));
        xd1            = xLoc*ones(size(yd));
        yd1            = yLoc*ones(size(zo));
        newSlicePlane1 = slice(hAxis, x, y, z, v, xd, yd, zd1);
        hSlicePlanes1   = [ hSlicePlanes1, newSlicePlane1 ];
        newSlicePlane2 = slice(hAxis, x, y, z, v, xd1, yd, zd);
        hSlicePlanes2   = [ hSlicePlanes2, newSlicePlane2 ];
        newSlicePlane3 = slice(hAxis, x, y, z, v, xd, yd1, zo);
        hSlicePlanes3   = [ hSlicePlanes3, newSlicePlane3 ];

        
        set(newSlicePlane1,'EdgeColor','none','FaceColor','interp','FaceAlpha','interp')
        alpha('color')
        alphamap('rampup')
        % alphamap('increase',.1)
        set(newSlicePlane2,'EdgeColor','none','FaceColor','interp','FaceAlpha','interp')
        alpha('color')
        alphamap('rampup')
        % alphamap('increase',.1)
        set(newSlicePlane3,'EdgeColor','none','FaceColor','interp','FaceAlpha','interp')
        alpha('color')
        alphamap('rampup')
        %         alphamap('increase',0.1-xLoc*1/350)%.1)
        alphamap('increase',0.1)
        
        
        
        
        
        zd1            = zLoc_*ones(size(yd));
        xd1            = xLoc_*ones(size(yd));
        yd1            = yLoc_*ones(size(zo));
        newSlicePlane4 = slice(hAxis, x, y, z, v, xd, yd, zd1);
        hSlicePlanes4   = [ hSlicePlanes4, newSlicePlane4 ];
        newSlicePlane5 = slice(hAxis, x, y, z, v, xd1, yd, zd);
        hSlicePlanes5   = [ hSlicePlanes5, newSlicePlane5 ];
        newSlicePlane6 = slice(hAxis, x, y, z, v, xd, yd1, zo);
        hSlicePlanes6   = [ hSlicePlanes6, newSlicePlane6 ];

        set(newSlicePlane4,'EdgeColor','none','FaceColor','interp','FaceAlpha','interp')
        alpha('color')
        alphamap('rampup')
        % alphamap('increase',.1)
        set(newSlicePlane5,'EdgeColor','none','FaceColor','interp','FaceAlpha','interp')
        alpha('color')
        alphamap('rampup')
        % alphamap('increase',.1)
        set(newSlicePlane6,'EdgeColor','none','FaceColor','interp','FaceAlpha','interp')
        alpha('color')
        alphamap('rampup')
        %         alphamap('increase',0.1-xLoc*1/350)%.1)
        alphamap('increase',0.1)




        zd1            = zLoc__*ones(size(yd));
        xd1            = xLoc__*ones(size(yd));
        yd1            = yLoc__*ones(size(zo));
        newSlicePlane7 = slice(hAxis, x, y, z, v, xd, yd, zd1);
        hSlicePlanes7   = [ hSlicePlanes7, newSlicePlane7 ];
        newSlicePlane8 = slice(hAxis, x, y, z, v, xd1, yd, zd);
        hSlicePlanes8   = [ hSlicePlanes8, newSlicePlane8 ];
        newSlicePlane9 = slice(hAxis, x, y, z, v, xd, yd1, zo);
        hSlicePlanes9   = [ hSlicePlanes9, newSlicePlane9 ];

        
        set(newSlicePlane7,'EdgeColor','none','FaceColor','interp','FaceAlpha','interp')
        alpha('color')
        alphamap('rampup')
        % alphamap('increase',.1)
        set(newSlicePlane8,'EdgeColor','none','FaceColor','interp','FaceAlpha','interp')
        alpha('color')
        alphamap('rampup')
        % alphamap('increase',.1)
        set(newSlicePlane9,'EdgeColor','none','FaceColor','interp','FaceAlpha','interp')
        alpha('color')
        alphamap('rampup')
        %         alphamap('increase',0.1-xLoc*1/350)%.1)
        alphamap('increase',0.1)
        
        
        
        
    end

    function deleteLastSlicePlane()
        if ~isempty(hSlicePlanes1)
            delete(hSlicePlanes1(end));
            hSlicePlanes1 = hSlicePlanes1(1:end-1);
            % hSlicePlanes(end) = [];
        end
        if ~isempty(hSlicePlanes2)
            delete(hSlicePlanes2(end));
            hSlicePlanes2 = hSlicePlanes2(1:end-1);
            % hSlicePlanes(end) = [];
        end
        if ~isempty(hSlicePlanes3)
            delete(hSlicePlanes3(end));
            hSlicePlanes3 = hSlicePlanes3(1:end-1);
            % hSlicePlanes(end) = [];
        end
         if ~isempty(hSlicePlanes4)
            delete(hSlicePlanes4(end));
            hSlicePlanes4 = hSlicePlanes4(1:end-1);
            % hSlicePlanes(end) = [];
        end
        if ~isempty(hSlicePlanes5)
            delete(hSlicePlanes5(end));
            hSlicePlanes5 = hSlicePlanes5(1:end-1);
            % hSlicePlanes(end) = [];
        end
        if ~isempty(hSlicePlanes6)
            delete(hSlicePlanes6(end));
            hSlicePlanes6 = hSlicePlanes6(1:end-1);
            % hSlicePlanes(end) = [];
        end

         if ~isempty(hSlicePlanes7)
            delete(hSlicePlanes7(end));
            hSlicePlanes7 = hSlicePlanes7(1:end-1);
            % hSlicePlanes(end) = [];
        end
        if ~isempty(hSlicePlanes8)
            delete(hSlicePlanes8(end));
            hSlicePlanes8 = hSlicePlanes8(1:end-1);
            % hSlicePlanes(end) = [];
        end
        if ~isempty(hSlicePlanes9)
            delete(hSlicePlanes9(end));
            hSlicePlanes9 = hSlicePlanes9(1:end-1);
            % hSlicePlanes(end) = [];
        end
    end

    function initDisplay()
        % initDisplay  Initialize Display
        
        % Draw back and bottom walls
        if isempty(hAxis) || ~ishandle(hAxis)
            hAxis = gca;
            hold on;
            hAxis.BoxStyle = 'full';
        end
        
        
        %% show projection on the sides
        %          hx = slice(hAxis, x, y, z, vedge,max(x(:)),       [],       []) ;
        %          hy = slice(hAxis, x, y, z, vedge,       [],max(y(:)),       []) ;
        %          hz = slice(hAxis, x, y, z, vedge,       [],       [],min(z(:))) ;
        % %
        %% no projection on the sides
        hx = slice(hAxis, x, y, z, v,max(x(:)),       [],       []) ;
        hy = slice(hAxis, x, y, z, v,       [],max(y(:)),       []) ;
        hz = slice(hAxis, x, y, z, v,       [],       [],min(z(:))) ;
        
        
        %%
        
        %Make everything look nice
        %         set([hz hy hx],'FaceColor','interp','EdgeColor','none')
        set([hz hy hx],'EdgeColor','none','FaceColor','interp','FaceAlpha','interp')
        alpha('color')
        alphamap('rampup')
        % alphamap('increase',0.1)
        set(hAxis,'FontSize',18,'FontWeight','Bold');
        xlabel('Y'); ylabel('X');  zlabel('Z')
        daspect([1,1,1])
        axis tight
        box on
        view(-38.5,16)
        colormap (jet(128))
    end
%% final code
s.addSlicePlane    = @addSlicePlane    ;
s.deleteLastSlicePlane = @deleteLastSlicePlane;
s.zMin             = min(z(:))        ;
s.zMax             = max(z(:))        ;
s.xMin             = min(x(:))        ;
s.xMax             = max(x(:))        ;
s.yMin             = min(y(:))        ;
s.yMax             = max(y(:))        ;
end
