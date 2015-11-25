function name = classify_img(img, models)
    kinds = length(models);
    distances = zeros(kinds, 1);

    for k = 1:kinds
        distances(k) = class_distance(img, models(k));
    end

    [~, index] = min(distances);
    name = models(index).name;
end
