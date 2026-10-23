% Tests for Source/get_center.m
% The function is not referenced by main.m or mean_shift.m (dead code), and
% its convention subtracts half the box size instead of adding it (the
% convention main.m uses). These tests pin current behaviour so any future
% change is deliberate.
classdef getCenterTest < matlab.unittest.TestCase
    methods (Test)
        function testCurrentBehaviour(testCase)
            [yc, xc] = get_center([10 20 4 6]);
            testCase.verifyEqual([yc xc], [17 8]);
        end

        function testRoundedInputs(testCase)
            [yc, xc] = get_center([10.4 20.6 4 6]);
            testCase.verifyEqual([yc xc], [18 8]);
        end
    end
end