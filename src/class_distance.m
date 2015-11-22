function distance = class_distance(img, model)
    img = imresize(img, model.norm_size);
    img = double(img(:));
    img = img / norm(img);  % Normalize the energy.

    space = model.score(:, model.latent >= model.threshold);
    distance = sqrt(abs(1 - norm(space \ img)));
end
