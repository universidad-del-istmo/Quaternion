import QtQuick 2.3
import QtQuick.Controls 1.4

Rectangle {
    id: root
    anchors.fill: parent

    signal getNewContent()

    ScrollView {
    anchors.fill: parent

        ListView {
            id: chatView
            anchors.fill: parent
            //width: 200; height: 250

            model: messageModel
            delegate: messageDelegate
            flickableDirection: Flickable.VerticalFlick
            pixelAligned: true

            onContentYChanged: {
                if( (this.contentY - this.originY) < 5 )
                {
                    console.log("get new content!");
                    root.getNewContent()
                }
            }
        }
    }

    Component {
        id: messageDelegate

        Row {
            id: message
            width: parent.width

            Label { text: time.toLocaleString(Qt.locale("de_DE"), "'<'hh:mm:ss'>'"); color: "grey" }
            Label {
                width: 120; elide: Text.ElideRight;
                text: eventType == "message" ? author : "***"
                horizontalAlignment: if( eventType != "message" ) { Text.AlignRight }
                color: if( eventType != "message" ) { "lightgrey" } else { "black" }
            }
            Label { text: content; wrapMode: Text.Wrap; width: parent.width - (x - parent.x) - spacing
                    color: if( eventType != "message" ) { "lightgrey" } else { "black" }
                    ToolTipArea { tip { text: toolTip; color: "#999999"; zParent: message } }
            }
            spacing: 3
        }
    }
}