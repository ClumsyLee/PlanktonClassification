function model = pca_train(train_imgs, norm_size, threshold)
    dim = prod(norm_size);
    len = length(train_imgs);

    x = zeros(dim, len);
    for k = 1:len
        img = imresize(train_imgs{k}, norm_size);
        img = double(img(:));
        x(:, k) = img / norm(img);  % Normalize the energy.
    end
    [coeff, score, latent] = pca(x);

    % % Normalize.
    % for k = 1:len
    %     col_len = norm(score(:, k));
    %     score(:, k) = score(:, k) / col_len;
    %     coeff(:, k) = coeff(:, k) * col_len;
    % end

    model = struct('norm_size', norm_size, ...
                   'coeff', coeff, ...
                   'score', score, ...
                   'latent', latent, ...
                   'threshold', threshold);
end
