function distance = class_distance(img, model)
    img = imresize(img, model.norm_size);
    img = double(img(:));
    img = img / norm(img);  % Normalize the energy.

    img = img - model.avg;
    last_dim = find(model.eigenvalues >= model.threshold, 1, 'last');
    if length(last_dim) == 0
        last_dim = 0;
    end

    space = model.eigenvectors(:, last_dim+1:end);
    distance = norm(space' * img);
end
