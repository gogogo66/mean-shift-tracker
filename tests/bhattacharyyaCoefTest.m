% Tests for Source/bhattacharyya_coef.m
% coef = sum(sum(sqrt(h1 .* h2)))
classdef bhattacharyyaCoefTest < matlab.unittest.TestCase
    methods (Test)
        function testSelfSimilarity(testCase)
            rng(0);
            q = rand(16, 16);
            testCase.verifyEqual(bhattacharyya_coef(q, q), sum(q(:)), 'AbsTol', 1e-10);
        end

        function testSymmetry(testCase)
            rng(1);
            a = rand(16, 16);
            b = rand(16, 16);
            testCase.verifyEqual(bhattacharyya_coef(a, b), bhattacharyya_coef(b, a), 'AbsTol', 1e-10);
        end

        function testZeroHistogram(testCase)
            rng(2);
            b = rand(16, 16);
            testCase.verifyEqual(bhattacharyya_coef(zeros(16, 16), b), 0);
        end

        function testNonNegative(testCase)
            rng(3);
            a = rand(16, 16);
            b = rand(16, 16);
            testCase.verifyGreaterThanOrEqual(bhattacharyya_coef(a, b), 0);
        end
    end
end