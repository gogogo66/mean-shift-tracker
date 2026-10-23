% Tests for Source/epanechnikov.m
% Declared contract: y = 0.5 * cd^(-1) * (d+2) * (1-x) for x <= 1, else 0.
% NOTE: kernel_mask.m currently calls it as epanechnikov(dist, cd, d) with
% the d/cd arguments swapped; these tests pin the contract declared in
% epanechnikov.m itself.
classdef epanechnikovTest < matlab.unittest.TestCase
    methods (Test)
        function testZeroOutsideSupport(testCase)
            testCase.verifyEqual(epanechnikov(1.5, 2, pi), 0);
        end

        function testZeroAtUnitRadius(testCase)
            testCase.verifyEqual(epanechnikov(1, 2, pi), 0);
        end

        function testValueInsideSupport(testCase)
            % 0.5 * (1/pi) * (2+2) * (1-0.5) = 1/pi
            testCase.verifyEqual(epanechnikov(0.5, 2, pi), 1/pi, 'AbsTol', 1e-12);
        end

        function testPeakAtOrigin(testCase)
            % 0.5 * (1/pi) * (2+2) * 1 = 2/pi
            testCase.verifyEqual(epanechnikov(0, 2, pi), 2/pi, 'AbsTol', 1e-12);
        end

        function testVectorInput(testCase)
            % x > 1 entry gets clamped to 0 in the else branch
            expected = [0 1/pi];
            testCase.verifyEqual(epanechnikov([1.5 0.5], 2, pi), expected, 'AbsTol', 1e-12);
        end
    end
end