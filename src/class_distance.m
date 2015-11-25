function distance = class_distance(img, model)
    img = imresize(img, model.norm_size);
    img = double(img(:));
    img = img / norm(img);  % Normalize the energy.

    img = img - model.avg;
    distance = sqrt(abs(1 - norm((model.eigenvectors)' * img)));
end
