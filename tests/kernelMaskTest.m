% Tests for Source/kernel_mask.m
% NOTE: kernel_mask calls epanechnikov with its d/cd arguments swapped
% (epanechnikov(dist, cd, d)). These tests pin observable properties (size,
% non-negativity, peak at center, zero corners, symmetry) rather than
% absolute kernel values, so they stay valid either way.
classdef kernelMaskTest < matlab.unittest.TestCase
    methods (Test)
        function testSize(testCase)
            M = kernel_mask(5, 7, 1);
            testCase.verifyEqual(size(M), [7 5 1]);
        end

        function testNonNegative(testCase)
            M = kernel_mask(5, 7, 1);
            testCase.verifyGreaterThanOrEqual(M(:), 0);
        end

        function testPeakAtCenter(testCase)
            M = kernel_mask(5, 7, 1);
            testCase.verifyEqual(max(M(:)), M(4, 3));
        end

        function testCornersZero(testCase)
            M = kernel_mask(5, 7, 1);
            corners = [M(1, 1) M(1, 5) M(7, 1) M(7, 5)];
            testCase.verifyEqual(corners, zeros(1, 4));
        end

        function testSymmetric(testCase)
            M = kernel_mask(5, 7, 1);
            testCase.verifyEqual(M(:, :, 1), M(end:-1:1, end:-1:1, 1));
        end
    end
end