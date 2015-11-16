function model = pca_train(train_imgs, norm_size)
    dim = prod(norm_size);
    len = length(train_imgs);

    x = zeros(dim, len);
    for k = 1:len
        img = imresize(train_imgs{k}, norm_size);
        x(:, k) = img(:);
    end
    [coeff, score, latent] = pca(x);

    model = struct('norm_size', norm_size, ...
                   'coeff', coeff, ...
                   'score', score, ...
                   'latent', latent);
end
