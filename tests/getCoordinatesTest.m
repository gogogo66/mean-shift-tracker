% Tests for Source/get_coordinates2.m and Source/get_coordinates3.m
classdef getCoordinatesTest < matlab.unittest.TestCase
    methods (Test)
        function testCoordinates2ShapeAndValues(testCase)
            coords = get_coordinates2(10, 20, 4, 6);
            testCase.verifyEqual(size(coords), [7 5 2]);
            % layer 2 holds x coordinates, layer 1 holds y coordinates
            testCase.verifyEqual(coords(1, :, 2), 8:12);
            testCase.verifyEqual(coords(:, 1, 1), (17:23)');
            testCase.verifyEqual(squeeze(coords(4, 3, :))', [20 10]);
        end

        function testCoordinates3CenteredOnOrigin(testCase)
            coords = get_coordinates3(4, 6);
            testCase.verifyEqual(size(coords), [7 5 2]);
            testCase.verifyEqual(squeeze(coords(4, 3, :))', [0 0]);
            % symmetric around 0, so the sums are exactly zero
            testCase.verifyEqual(sum(sum(coords(:, :, 1))), 0);
            testCase.verifyEqual(sum(sum(coords(:, :, 2))), 0);
        end
    end
end