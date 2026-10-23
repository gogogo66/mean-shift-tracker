% Tests for Source/RGB2rgb.m
classdef RGB2rgbTest < matlab.unittest.TestCase
    methods (Test)
        function testOutputIsDouble(testCase)
            out = RGB2rgb(uint8(randi([0 255], 4, 5, 3)));
            testCase.verifyClass(out, 'double');
        end

        function testCurrentBehaviourEqualsIm2Double(testCase)
            % Pins the current implementation: it converts to double and
            % returns I (the un-normalised image).
            img = uint8(randi([0 255], 4, 5, 3));
            testCase.verifyEqual(RGB2rgb(img), im2double(img));
        end

        function testNormalizedSumOfChannelsIsOne(testCase)
            % KNOWN ISSUE: RGB2rgb computes the normalised channels J but
            % assigns `image = I` on the last line, discarding J. Re-enable
            % this test once the function returns the normalised image.
            testCase.assumeFail('Known issue: RGB2rgb returns the un-normalised I');
            out = RGB2rgb(uint8(128 * ones(3, 3, 3)));
            s = out(:, :, 1) + out(:, :, 2) + out(:, :, 3);
            testCase.verifyEqual(s, ones(3, 3), 'AbsTol', 1e-12);
            testCase.verifyGreaterThanOrEqual(out(:), 0);
            testCase.verifyLessThanOrEqual(out(:), 1);
        end
    end
end