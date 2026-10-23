% Tests for Source/weight_histogram.m
classdef weightHistogramTest < matlab.unittest.TestCase
    methods (Test)
        function testElementwiseProduct(testCase)
            h = 2 * ones(5, 5);
            k = 3 * ones(5, 5);
            testCase.verifyEqual(weight_histogram(h, k), 6 * ones(5, 5));
        end
    end
end