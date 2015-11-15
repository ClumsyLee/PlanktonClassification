function [coeff, score, latent] = pca_train(train_imgs, norm_size)
    dim = prod(norm_size);
    len = length(train_imgs);

    x = zeros(dim, len);
    for k = 1:len
        img = imresize(train_imgs{k}, norm_size);
        x(:, k) = img(:);
    end
    [coeff, score, latent] = pca(x);

    % Construct sub-space.
    % Keep the whole space for now.
end
