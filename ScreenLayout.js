.pragma library

// Hyprland supplies desktop positions; screen sizes are in logical pixels.
function hotCornerScreens(screens, monitors, position, allDisplays) {
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
        var monitor = null;
        for (var j = 0; j < monitors.length; j++) {
            if (monitors[j] && monitors[j].name === screen.name) {
                monitor = monitors[j];
                break;
            }
        }
        if (!monitor)
            continue;
        var edge = onLeft ? monitor.x : monitor.x + screen.width;
        var vertical = onTop ? monitor.y : monitor.y + screen.height;
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
