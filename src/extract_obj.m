function part = extract_obj(img)
    h = size(img, 1);
    w = size(img, 2);

    bw = edge(img, 'Prewitt');
    row = any(bw);
    col = any(bw');

    if ~any(row)  % Not a single edge.
        upper_left = [1 1];
        lower_right = [size(img, 2) size(img, 1)];
    else
        upper_left = [find(row, 1), find(col, 1)];
        lower_right = [find(row, 1, 'last'), find(col, 1, 'last')];
    end
    ROI_size = lower_right - upper_left + [1 1];

        % 'ThresholdDelta', 4, ...
        % 'ROI', [upper_left, lower_right - upper_left + [1 1]]);
        % 'MaxAreaVariation', 0.1, ...
    regions = detectMSERFeatures(img, ...
        'RegionAreaRange', [100, floor(prod(ROI_size) * pi / 4)]);
    areas = prod(regions.Axes, 2);
    [value, index] = sort(areas);

    % Here we can analyse `value` to decide which one to pick.
    % Now we'll just pick the largest one.
    region = regions(index(end));
    x = region.Location(1);
    y = region.Location(2);
    theta = region.Orientation;
    img = imrotate(img, -theta / pi * 180, 'bicubic');

    if theta < 0
        new_x = x * cos(theta) - y * sin(theta);
        new_y = (x - w) * sin(theta) + y * cos(theta);
    else
        new_x = x * cos(theta) + (h - y) * sin(theta);
        new_y = x * sin(theta) + y * cos(theta);
    end

    x_min = max(1, round(new_x - region.Axes(1) / 2));
    x_max = min(size(img, 2), round(new_x + region.Axes(1) / 2));
    y_min = max(1, round(new_y - region.Axes(2) / 2));
    y_max = min(size(img, 1), round(new_y + region.Axes(2) / 2));
    part = img(y_min:y_max, x_min:x_max);
end
