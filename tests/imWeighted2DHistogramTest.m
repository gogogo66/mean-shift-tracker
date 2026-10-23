% Tests for Source/im_weighted_2D_histogram.m
% Note: on an all-zero input the internal normalisation computes 0/0 and
% produces NaN bin indices, so tests avoid all-zero images.
classdef imWeighted2DHistogramTest < matlab.unittest.TestCase
    methods (Test)
        function testConstantImageFallsInSingleBin(testCase)
            img = 0.5 * ones(3, 3, 3);
            kernel = ones(3, 3);
            [bin_counts, bin_numbers] = im_weighted_2D_histogram(16, img, kernel);
            testCase.verifyEqual(size(bin_counts), [16 16]);
            % 0.5 -> normalised to 1 -> 256 -> bin 16 of 16
            testCase.verifyEqual(bin_counts(16, 16), 9);
            testCase.verifyEqual(sum(bin_counts(:)), 9);
            testCase.verifyEqual(bin_numbers(:, :, 1), 16 * ones(3, 3));
            testCase.verifyEqual(bin_numbers(:, :, 2), 16 * ones(3, 3));
        end

        function testTotalCountEqualsKernelSum(testCase)
            % every pixel contributes kernel(i,j) exactly once
            rng(0);
            img = rand(5, 4, 3);
            kernel = rand(5, 4);
            [bin_counts, ~] = im_weighted_2D_histogram(16, img, kernel);
            testCase.verifyEqual(sum(bin_counts(:)), sum(kernel(:)), 'AbsTol', 1e-10);
        end

        function testBinNumbersInRange(testCase)
            rng(1);
            img = rand(7, 6, 3);
            [~, bin_numbers] = im_weighted_2D_histogram(16, img, ones(7, 6));
            testCase.verifyGreaterThanOrEqual(bin_numbers(:), 1);
            testCase.verifyLessThanOrEqual(bin_numbers(:), 16);
        end
    end
end