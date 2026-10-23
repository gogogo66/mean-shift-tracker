% Tests for Source/hist_back_propagate.m
classdef histBackPropagateTest < matlab.unittest.TestCase
    methods (Test)
        function testOutputShape(testCase)
            img = rand(10, 12, 3);
            out = hist_back_propagate(img, reshape(1:256, 16, 16));
            testCase.verifyEqual(size(out), [10 12]);
        end

        function testBinAssignment(testCase)
            img = zeros(10, 12, 3);
            img(:, :, 1) = 0.5;  % r bin = ceil(0.5*16) = 8
            img(:, :, 2) = 0.25; % g bin = ceil(0.25*16) = 4
            img(:, :, 3) = 0;    % third channel is not used
            bin_counts = reshape(1:256, 16, 16);
            out = hist_back_propagate(img, bin_counts);
            % column-major layout: bin_counts(8,4) = 8 + 16*(4-1) = 56
            testCase.verifyEqual(out, 56 * ones(10, 12));
        end
    end
end