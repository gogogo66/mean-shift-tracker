% Tests for Source/compute_weights.m
% w(i,j) = target(bin)/candidate(bin); NaN/Inf clamping to 0.
classdef computeWeightsTest < matlab.unittest.TestCase
    methods (Test)
        function testIdenticalHistogramsGiveUnitWeights(testCase)
            rng(0);
            t = rand(16, 16) + 1; % strictly positive bins
            pixel_bins = ones(4, 5, 2) * 3;
            w = compute_weights(t, t, pixel_bins);
            testCase.verifyEqual(w, ones(4, 5));
        end

        function testZeroCandidateBinGivesZeroWeight(testCase)
            candidate = rand(16, 16) + 1;
            candidate(3, 3) = 0;
            target = rand(16, 16) + 1;
            target(3, 3) = 7;
            w = compute_weights(candidate, target, ones(4, 5, 2) * 3);
            testCase.verifyEqual(w, zeros(4, 5));
        end

        function testZeroTargetBinGivesZeroWeight(testCase)
            candidate = rand(16, 16) + 1;
            candidate(3, 3) = 5;
            target = rand(16, 16) + 1;
            target(3, 3) = 0;
            w = compute_weights(candidate, target, ones(4, 5, 2) * 3);
            testCase.verifyEqual(w, zeros(4, 5));
        end

        function testWeightShapeMatchesPixelBins(testCase)
            rng(0);
            t = rand(16, 16) + 1;
            w = compute_weights(t, t, ones(4, 5, 2) * 3);
            testCase.verifyEqual(size(w), [4 5]);
        end
    end
end