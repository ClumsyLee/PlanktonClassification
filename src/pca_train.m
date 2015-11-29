function models = pca_train(train_sets, norm_size, threshold)
    dim = prod(norm_size);
    models = [];

    total_imgs = 0;
    for k = 1:length(train_sets)
        total_imgs = total_imgs + length(train_sets(k).imgs);
    end

    imgs_now = 0;
    for k = 1:length(train_sets)
        disp([num2str(imgs_now) '/' num2str(total_imgs)]);

        train_set = train_sets(k);
        len = length(train_set.imgs);
        imgs_now = imgs_now + len;

        x = zeros(dim, len);
        for col = 1:len
            img = extract_obj(imread(train_set.imgs{col}));  % Extract object.
            img = imresize(img, norm_size);  % Normalize size.
            img = double(img(:));
            x(:, col) = img / norm(img);  % Normalize the energy.
        end

        avg = mean(x, 2);
        x = x - repmat(avg, [1, len]);

        [u, d, ~] = svd(x);

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
