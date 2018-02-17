/*
 *  Copyright 2015  Lars Pontoppidan <dev.larpon@gmail.com>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  2.010-1301, USA.
 */

import QtQuick 2.7
import QtQuick.Controls 1.5
import QtQuick.Layouts 1.1

import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

import org.kde.kquickcontrolsaddons 2.0 as KQuickAddons

Item {
    id: root
    //width: units.gridUnit * 2.0
    //height: parent.height

    property alias cfg_interval: intervalSpinBox.value
    property alias cfg_randomize: randomizeCheckBox.checked
    property alias cfg_pauseOnMouseOver: pauseOnMouseOverCheckBox.checked
    property alias cfg_useBackground: useBackgroundCheckBox.checked
    property alias cfg_leftClickOpenImage: leftClickOpenImageCheckBox.checked
    //property alias cfg_showCountdown: showCountdownCheckBox.checked
    property alias cfg_fillMode: root.fillMode

    /*
     * Image.Stretch - the image is scaled to fit
     * Image.PreserveAspectFit - the image is scaled uniformly to fit without cropping
     * Image.PreserveAspectCrop - the image is scaled uniformly to fill, cropping if necessary
     * Image.Tile - the image is duplicated horizontally and vertically
     * Image.TileVertically - the image is stretched horizontally and tiled vertically
     * Image.TileHorizontally - the image is stretched vertically and tiled horizontally
     * Image.Pad - the image is not transformed
     */
    property int fillMode: Image.PreserveAspectFit

    ListModel {
        id: fillModeModel
        
        ListElement {
            text: "Stretch"
            value: Image.Stretch
            description: "The image is scaled to fit"
            }
        
        ListElement {
            text: "Preserve aspect fit"
            value: Image.PreserveAspectFit
            description: "The image is scaled uniformly to fit without cropping"
        }
        
        ListElement {
            text: "Preserve aspect crop"
            value: Image.PreserveAspectCrop
            description: "The image is scaled uniformly to fill, cropping if necessary"
        }
        
        ListElement {
            text: "Tile"
            value: Image.Tile
            description: "The image is duplicated horizontally and vertically"
        }
        
        ListElement {
            text: "Tile vertically"
            value: Image.TileVertically
            description: "The image is stretched horizontally and tiled vertically"
        }
        
        ListElement {
            text: "Tile horizontally"
            value: Image.TileHorizontally
            description: "The image is stretched vertically and tiled horizontally"
        }
        
        ListElement {
            text: "Pad"
            value: Image.Pad
            description: "The image is not transformed"
        }
    }


    ColumnLayout {    
        spacing: 20
        //width: units.gridUnit * 2.0

        Grid {
           // width: units.gridUnit * 2.0
            columns: 2
            rows: 7
            rowSpacing: 20
            columnSpacing: 10
            verticalItemAlignment: Qt.AlignVCenter
            
        
            Label {
                //width: 
                text: i18n("Change picture every")
            }

            // Row 1, Col 2
            SpinBox {
                id: intervalSpinBox
                suffix: i18n("s")
                decimals: 1

                // Once a day should be high enough
                maximumValue: 24*(60*60)
            } // end SpinBox
        
        
        
            
            // Row 2, Col 1
            Label {
                
                //width: 100
                id: fillLabel
                //anchors.fill: parent
                text: i18n("Fill mode:")
            }

                
            // Row 2, Col 2  
             
            ComboBox {
                id: comboBox
                anchors.left: parent
                anchors.right: parent
                width: units.gridUnit * 10
                currentIndex: fillModeToIndex(fillMode)
                model: fillModeModel
                
                    

                onActivated: root.fillMode = fillModeModel.get(index).value

                onCurrentIndexChanged: fillModeDescription.text = fillModeModel.get(currentIndex).description

                function fillModeToIndex(fillMode) {
                    if(fillMode == Image.Stretch)
                        return 0
                    else if(fillMode == Image.PreserveAspectFit)
                        return 1
                    else if(fillMode == Image.PreserveAspectCrop)
                        return 2
                    else if(fillMode == Image.Tile)
                        return 3
                    else if(fillMode == Image.TileVertically)
                        return 4
                    else if(fillMode == Image.TileHorizontally)
                        return 5
                    else if(fillMode == Image.Pad)
                        return 6
                } // end of fillModeToIndex function
            } // end of ComboBox and related functions
            
            
            // Row 3, Col 1 (cheater to fill empty cell)
            Label {
                width: 10
                text: ""
                } 
            

            //Row 3, Col 2
            Label {
                id: fillModeDescription
                text: i18n("The image is scaled uniformly to fit without cropping")
            }
        
        } // end of top section GridLayout
    
        // these CheckBoxes should take over as their own ColumnLayout entries
        CheckBox {
            id: randomizeCheckBox
            text: i18n("Randomize items")
        }

        CheckBox {
            id: pauseOnMouseOverCheckBox
            text: i18n("Pause on mouseover")
        }

        CheckBox {
            id: useBackgroundCheckBox
            text: i18n("Background frame")
        }

        CheckBox {
            id: leftClickOpenImageCheckBox
            text: i18n("Left click image opens in external viewer")
        }

  } // should end ColumnLayout

 }
        



