import QtQuick
import QtTest
import "../ScreenLayout.js" as ScreenLayout

TestCase {
    name: "ScreenLayout"

    function test_outermostDisplay_data() {
        return [
            { tag: "top-left", position: "top-left", expected: "left" },
            { tag: "bottom-left", position: "bottom-left", expected: "left" },
            { tag: "top-right", position: "top-right", expected: "right" },
            { tag: "bottom-right", position: "bottom-right", expected: "right" }
        ];
    }

    function test_outermostDisplay(data) {
        // Mixed scales have already been converted to logical geometry by Qt.
        var screens = [
            { name: "middle", x: 0, y: 0, width: 4096, height: 1152 },
            { name: "right", x: 4096, y: -200, width: 1080, height: 1920 },
            { name: "left", x: -1920, y: 100, width: 1920, height: 1080 }
        ];
        compare(ScreenLayout.hotCornerScreens(screens, data.position, false)[0].name, data.expected);
        compare(ScreenLayout.hotCornerScreens(screens.reverse(), data.position, false)[0].name, data.expected);
    }

    function test_rightmostUsesRightEdge() {
        var wide = { name: "wide", x: 0, y: 0, width: 3000, height: 1000 };
        var narrow = { name: "narrow", x: 1000, y: 1000, width: 1000, height: 1000 };
        compare(ScreenLayout.hotCornerScreens([narrow, wide], "top-right", false), [wide]);
    }

    function test_stackedDisplaysUseChosenVerticalCorner() {
        var upper = { name: "upper", x: 0, y: -1080, width: 1920, height: 1080 };
        var lower = { name: "lower", x: 0, y: 0, width: 1920, height: 1080 };
        for (var side of ["left", "right"]) {
            compare(ScreenLayout.hotCornerScreens([lower, upper], "top-" + side, false), [upper]);
            compare(ScreenLayout.hotCornerScreens([upper, lower], "bottom-" + side, false), [lower]);
        }
    }

    function test_allDisplaysAndHotplug() {
        var left = { name: "left", x: -1920, y: 0, width: 1920, height: 1080 };
        var right = { name: "right", x: 0, y: 0, width: 1920, height: 1080 };
        compare(ScreenLayout.hotCornerScreens([left, right], "top-left", true), [left, right]);
        compare(ScreenLayout.hotCornerScreens([right], "top-left", false), [right]);
        compare(ScreenLayout.hotCornerScreens([], "top-left", false), []);
        right.x = -3840;
        compare(ScreenLayout.hotCornerScreens([left, right], "top-left", false), [right]);
    }
}
