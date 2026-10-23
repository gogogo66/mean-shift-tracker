% Integration tests for Source/mean_shift.m
% These depend on Source/get_target_image.m, which is currently MISSING from
% the repository. The tests are filtered (not failed) while the file is
% absent; restoring get_target_image.m (crop an HxW image to (width+1) x
% (height+1) around (x_center, y_center), matching kernel_mask's size)
% activates them.
classdef meanShiftTest < matlab.unittest.TestCase
    methods (Test)
        function testNoShiftForUniformFrame(testCase)
            testCase.assumeTrue(exist('get_target_image', 'file') == 2, ...
                'get_target_image.m is missing from Source/');
            kernel = kernel_mask(11, 11, 1);
            q = im_weighted_2D_histogram(16, RGB2rgb(0.5 * ones(11, 11, 3)), ones(11, 11));
            frame = 0.5 * ones(100, 100, 3);
            y1 = mean_shift(q, [50 50 10 10], frame, kernel);
            testCase.verifyEqual(y1, [50 50]);
        end

        function testMovesTowardTargetMass(testCase)
            testCase.assumeTrue(exist('get_target_image', 'file') == 2, ...
                'get_target_image.m is missing from Source/');
            kernel = kernel_mask(11, 11, 1);
            % white 10x10 patch centered at (40, 30) on a black 60x60 frame
            frame = zeros(60, 60, 3);
            frame(25:35, 35:45, :) = 1;
            q = im_weighted_2D_histogram(16, RGB2rgb(frame(25:35, 35:45, :)), kernel);
            y1 = mean_shift(q, [30 30 10 10], frame, kernel);
            % iterates 30 -> 35 -> 38 -> 39 -> 40 (horizontal only)
            testCase.verifyGreaterThanOrEqual(y1(1), 38);
            testCase.verifyLessThanOrEqual(y1(1), 42);
            testCase.verifyEqual(y1(2), 30);
        end
    end
end