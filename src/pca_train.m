function models = pca_train(train_sets, norm_size, threshold)
    % Create a ellipse mask.
    [x_in_img y_in_img] = meshgrid(1:norm_size(2), 1:norm_size(1));
    a = floor(norm_size(2) / 2);
    b = floor(norm_size(1) / 2);
    x_center = (norm_size(2) + 1) / 2;
    y_center = (norm_size(1) + 1) / 2;
    mask = (x_in_img - x_center).^2 / a^2 + (y_in_img - y_center).^2 / b^2 <= 1;
    mask = uint8(mask);

    dim = prod(norm_size);
    models = [];

    for k = 1:length(train_sets)
        disp([num2str(k) '/' num2str(length(train_sets))]);

        train_set = train_sets(k);
        len = length(train_set.imgs);

        x = zeros(dim, len);
        for col = 1:len
            img = extract_obj(imread(train_set.imgs{col}));  % Extract object.
            img = imresize(img, norm_size) .* mask;  % Normalize size & crop.
            img = double(img(:));
            x(:, col) = img / norm(img);  % Normalize the energy.
        end

        avg = mean(x')';
        x = x - repmat(avg, [1, len]);

        [u, d, v] = svd(x);

        eigenvalues = diag(d).^2;
        eigenvalues = eigenvalues(1:min(length(eigenvalues), threshold));
        eigenvectors = u(:, 1:length(eigenvalues));
        models = [
            models
            struct('name', train_set.name, ...
                   'norm_size', norm_size, ...
                   'avg', avg, ...
                   'eigenvalues', eigenvalues, ...
                   'eigenvectors', eigenvectors, ...
                   'threshold', threshold)
        ];
    end
end
