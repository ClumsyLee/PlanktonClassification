function models = pca_train(train_sets, norm_size, threshold)
    dim = prod(norm_size);
    models = [];

    for k = 1:length(train_sets)
        disp([num2str(k) '/' num2str(length(train_sets))]);

        train_set = train_sets(k);
        len = length(train_set.imgs);

        x = zeros(dim, len);
        for col = 1:len
            img = imresize(imread(train_set.imgs{col}), norm_size);
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
