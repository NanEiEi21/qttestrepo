import QtQuick 2.12
import QtQuick.Window 2.12
import QtQml.Models 2.1
Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    property int sourceidx:0

    /* //Eg1
    ListModel{
        id:  testmodel

        ListElement {
            name: "Jim Williams"
            portrait: "file:///home/nanei/Desktop/berry/userboardimages/icons8-image-96"
        }
        ListElement {
            name: "John Brown"
            portrait: "file:///home/nanei/Desktop/berry/userboardimages/icons8-image-96.png"
        }
        ListElement {
            name: "Bill Smyth"
            portrait: "file:///home/nanei/Desktop/berry/userboardimages/icons8-image-96.png"
        }
        ListElement {
            name: "Sam Wise"
            portrait: "file:///home/nanei/Desktop/berry/userboardimages/icons8-image-96.png"
        }
        ListElement {
            name: "Jasmine"
            portrait: "file:///home/nanei/Desktop/berry/userboardimages/icons8-image-96.png"
        }
        ListElement {
            name: "Sally Tan"
            portrait: "file:///home/nanei/Desktop/berry/userboardimages/icons8-image-96.png"
        }
        ListElement {
            name: "Alex"
            portrait: "file:///home/nanei/Desktop/berry/userboardimages/icons8-image-96.png"
        }
    }*/


    //DelegateModel
    DelegateModel{
     id:  testmodel
    model: ListModel {
        ListElement {
            name: "Jim Williams"
            portrait: "file:///home/nanei/Desktop/berry/userboardimages/icons8-image-96"
        }
        ListElement {
            name: "John Brown"
            portrait: "file:///home/nanei/Desktop/berry/userboardimages/icons8-image-96.png"
        }
        ListElement {
            name: "Bill Smyth"
            portrait: "file:///home/nanei/Desktop/berry/userboardimages/icons8-image-96.png"
        }
        ListElement {
            name: "Sam Wise"
            portrait: "file:///home/nanei/Desktop/berry/userboardimages/icons8-image-96.png"
        }
        ListElement {
            name: "Jasmine"
            portrait: "file:///home/nanei/Desktop/berry/userboardimages/icons8-image-96.png"
        }
        ListElement {
            name: "Sally Tan"
            portrait: "file:///home/nanei/Desktop/berry/userboardimages/icons8-image-96.png"
        }
        ListElement {
            name: "Alex"
            portrait: "file:///home/nanei/Desktop/berry/userboardimages/icons8-image-96.png"
        }
    }
    delegate: dragDelegate
    }

    Rectangle{

        width: 900; height: 600
        x: 200

        id: testarea
        //test starts
        Component {
            id: dragDelegate
            MouseArea {
                id: dragArea
                property bool held: false
                anchors{top: parent.top; bottom: parent.bottom}
                width: content.width
                drag.target: held ? content : undefined
                drag.axis: Drag.XAxis
                onPressAndHold: {

                    held = true
                    sourceidx = index

                }
                onReleased: {
                    held = false

                }
                Rectangle {
                    id: content
                    anchors{
                        horizontalCenter: parent.horizontalCenter
                        verticalCenter: parent.verticalCenter
                    }
                    width: row.implicitWidth; height: 140 //dragArea.height
                    color: dragArea.held ? "lightsteelblue" : "transparent"
                    radius: 7
                    Drag.active: dragArea.held
                    Drag.source: dragArea
                    Drag.hotSpot.x: width / 2
                    Drag.hotSpot.y: height / 2
                    states: State {
                        when: dragArea.held
                        ParentChange { target: content; parent: testarea }
                        AnchorChanges {
                            target: content
                            anchors { horizontalCenter: undefined; verticalCenter: undefined }
                        }
                    }
                    Row
                    {
                        id:row
                        spacing: 25
                        anchors{fill:parent; margins: 2}
                        Image
                        {
                            source: portrait
                            id: imgicon
                            Text{
                                id:icontext
                                text: name;anchors.top: imgicon.bottom
                                anchors.horizontalCenter: parent.horizontalCenter
                                color: "#00ddd1";
                                font.family: "Helvetica-Normal"
                                font.pixelSize: 12
                            }

                        }


                    }


                }//end of Rectangle
                DropArea {
                    anchors { fill: parent; margins: 10 }
                    onEntered: {
                        testmodel.items.move(
                                    drag.source.DelegateModel.itemsIndex,
                                    dragArea.DelegateModel.itemsIndex)

                     // Eg1
                      //  testmodel.move(sourceidx,index, 1)

                    }

                    onDropped:
                    {
                        console.log('droparea')
                    }
                    onExited: {

                        var oldindex = sourceidx
                        var newindex = index
                        console.log('get exit'+ 'sourceidx='+ oldindex+ 'newindex'+ newindex)
                        //testmodel.move(oldindex,newindex,1)
                    }
                    onPositionChanged:
                    {
                        // console.log('get positionchagned')
                    }
                }
            }//end of mouse
        }

        //Eg1
//        ListView{
//            id: listviewnew
//            anchors.fill: parent
//            model: testmodel
//            orientation: Qt.Horizontal
//            currentIndex: 0
//            delegate: dragDelegate
//        }

        //Eg2 with DelegateModel
        ListView{
            id: listviewnew
            anchors.fill: parent
            model: testmodel
            orientation: Qt.Horizontal
            currentIndex: 0

        }


    }
}
