.pragma library

// ScreenInfo geometry is already in logical pixels, including scale/rotation.
function hotCornerScreens(screens, position, allDisplays) {
    var onLeft = position.indexOf("-left") !== -1;
    var onTop = position.indexOf("top-") === 0;
    var result = [];
    var selected = null;
    var selectedEdge = 0;
    var selectedVertical = 0;
    for (var i = 0; i < screens.length; i++) {
        var screen = screens[i];
        if (!screen)
            continue;
        if (allDisplays) {
            result.push(screen);
            continue;
        }
        var edge = onLeft ? screen.x : screen.x + screen.width;
        var vertical = onTop ? screen.y : screen.y + screen.height;
        if (!selected
                || (onLeft ? edge < selectedEdge : edge > selectedEdge)
                || (edge === selectedEdge && (onTop ? vertical < selectedVertical : vertical > selectedVertical))
                || (edge === selectedEdge && vertical === selectedVertical && screen.name < selected.name)) {
            selected = screen;
            selectedEdge = edge;
            selectedVertical = vertical;
        }
    }
    if (selected)
        result.push(selected);
    return result;
}
