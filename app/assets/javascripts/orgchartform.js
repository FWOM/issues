$(window).load(function () {
    var panel = jQuery("#panel");
    var orgchartform = panel.find("[name=orgchartform]");
    var orgchart = panel.find("[name=orgchart]");
    var treeItems = {};

    var options = new primitives.orgdiagram.Config();

    var items = [
        new primitives.orgdiagram.ItemConfig({
            id: 0,
            parent: null,
            titl: "Title 4",
            description: "Description",
            image: "/assets/a.png"
        })
    ];

    var id = 1;
    for (var index = 0; index < 4; index++) {
        items.push(new primitives.orgdiagram.ItemConfig({
            id: ++id,
            parent: 0,
            title: id.toString() + " Title",
            description: id.toString() + " Description",
            image: "/assets/c.png"
        }));
        var parent = id;
        for (var index2 = 0; index2 < 2; index2++) {
            items.push(new primitives.orgdiagram.ItemConfig({
                id: ++id,
                parent: parent,
                title: id.toString() + " Title",
                description: id.toString() + " Description",
                image: "/assets/c.png"
            }));
        }
    }

    /* store ItemConfig-s in hash by id*/
    for (var index = 0, len = items.length; index < len; index += 1) {
        treeItems[items[index].id] = items[index];
    }

    options.items = items;
    options.cursorItem = 0;
    options.buttonsPanelSize = 48;
    options.pageFitMode = primitives.orgdiagram.PageFitMode.Auto;
    options.graphicsType = primitives.common.GraphicsType.Auto;
    options.hasSelectorCheckbox = primitives.common.Enabled.True;
    options.hasButtons = primitives.common.Enabled.True;
    options.leavesPlacementType = primitives.orgdiagram.ChildrenPlacementType.Matrix;

    orgchart.orgDiagram(options);

    /* Select single item */
    panel.find("[name=buttonsingle]").click(function (e) {
        var itemConfig = null;
        orgchartform.dialog({
            autoOpen: false,
            minWidth: 640,
            minHeight: 480,
            modal: true,
            title: "Select item",
            buttons: {
                "Select": function () {
                    var cursorItem = orgchart.orgDiagram("option", "cursorItem");
                    var itemConfig = treeItems[cursorItem];
                    panel.find("[name=message]").empty().append("Selected item title=" + itemConfig.title)
                    jQuery(this).dialog("close");
                },
                Cancel: function () {
                    jQuery(this).dialog("close");
                }
            },
            resizeStop: function (event, ui) {
                var panelSize = new primitives.common.Rect(0, 0, orgchartform.outerWidth(), orgchartform.outerHeight());
                orgchart.css(panelSize.getCSS());
                orgchart.orgDiagram("update", primitives.orgdiagram.UpdateMode.Recreate);
            },
            open: function (event, ui) {
                var panelSize = new primitives.common.Rect(0, 0, orgchartform.outerWidth(), orgchartform.outerHeight());
                orgchart.css(panelSize.getCSS());
                /* Chart is already created, so in regular situation we have to use Refresh update mode,
                 but here jQuery removes dialog contents and adds them back, so that procedure invalidates
                 invalidates VML in IE6 mode, so when we open dialog we use full Redraw update mode. */
                orgchart.orgDiagram("update", primitives.orgdiagram.UpdateMode.Recreate);
            }
        }).dialog("open");
    })

    /* Check multiple items */
    panel.find("[name=buttonmultiple]").click(function (e) {
        var itemConfig = null;
        orgchartform.dialog({
            autoOpen: false,
            minWidth: 640,
            minHeight: 480,
            modal: true,
            title: "Check multiple items",
            buttons: {
                "Select": function () {
                    var selectedItems = orgchart.orgDiagram("option", "selectedItems");
                    var message = "";
                    for (var index = 0; index < selectedItems.length; index++) {
                        var itemConfig = treeItems[selectedItems[index]];
                        if (message != "") {
                            message += ", ";
                        }
                        message += "<b>'" + itemConfig.title + "'</b>";
                    }
                    panel.find("[name=message]").empty().append("User selected next items: " + message);
                    jQuery(this).dialog("close");
                },
                Cancel: function () {
                    jQuery(this).dialog("close");
                }
            },
            resizeStop: function (event, ui) {
                var panelSize = new primitives.common.Rect(0, 0, orgchartform.outerWidth(), orgchartform.outerHeight());
                orgchart.css(panelSize.getCSS());
                orgchart.orgDiagram("update", primitives.orgdiagram.UpdateMode.Refresh);
            },
            open: function (event, ui) {
                var panelSize = new primitives.common.Rect(0, 0, orgchartform.outerWidth(), orgchartform.outerHeight());
                orgchart.css(panelSize.getCSS());
                /* Chart is already created, so in regular situation we have to use Refresh update mode,
                 but here jQuery removes dialog contents and adds them back, so that procedure invalidates
                 invalidates VML in IE6 mode, so when we open dialog we use full Redraw update mode. */
                orgchart.orgDiagram("update", primitives.orgdiagram.UpdateMode.Recreate);
            }
        }).dialog("open");
    })

});/**
 * Created with JetBrains RubyMine.
 * User: fwom_000
 * Date: 03/04/14
 * Time: 19:56
 * To change this template use File | Settings | File Templates.
 */
