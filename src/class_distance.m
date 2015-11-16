function distance = class_distance(img, model)
    img = imresize(img, model.norm_size);
    img = img(:);

    space = model.score(:, model.latent < model.threshold);
    for col = 1:size(space, 2)
        space(:, col) = space(:, col) / norm(space(:, col));
    end

    distance = norm(space \ double(img));
end
