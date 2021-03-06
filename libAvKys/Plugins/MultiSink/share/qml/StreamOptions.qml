/* Webcamoid, webcam capture application.
 * Copyright (C) 2016  Gonzalo Exequiel Pedone
 *
 * Webcamoid is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Webcamoid is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Webcamoid. If not, see <http://www.gnu.org/licenses/>.
 *
 * Web-Site: http://webcamoid.github.io/
 */

import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

GroupBox {
    id: gbxStreamOptions
    title: streamLabel.length > 0?
               qsTr("Stream #%1 (%2)").arg(streamIndex).arg(streamLabel):
               qsTr("Stream #%1").arg(streamIndex)

    property int outputIndex: 0
    property int streamIndex: 0
    property string streamLabel: ""
    property string codecsTextRole: ""
    property variant codecList: ListModel {}
    property string codec: ""
    property int bitrate: 0
    property int videoGOP: 0

    signal streamOptionsChanged(int index, variant options)

    function notifyOptions()
    {
        streamOptionsChanged(outputIndex,
                             {codec: codec,
                              bitrate: bitrate,
                              gop: videoGOP});
    }

    onCodecChanged: {
        for (var i = 0; i < cbxCodec.count; i++)
            if (cbxCodec.model.get(i).codec === codec) {
                cbxCodec.currentIndex = i;

                return;
            }
    }

    GridLayout {
        anchors.fill: parent
        columns: 2

        Label {
            text: qsTr("Codec")
        }
        ComboBox {
            id: cbxCodec
            textRole: gbxStreamOptions.codecsTextRole
            model: gbxStreamOptions.codecList
            Layout.fillWidth: true

            onCurrentIndexChanged: {
                var option = model.get(currentIndex);

                if (option) {
                    gbxStreamOptions.codec = option.codec;
                    notifyOptions();
                    advancedOptions.enabled = MultiSink.codecOptions(outputIndex).length > 0;
                }
            }
        }

        Label {
            id: lblBitRate
            text: qsTr("Bitrate")
            visible: txtBitRate.visible
        }
        TextField {
            id: txtBitRate
            text: gbxStreamOptions.bitrate
            placeholderText: qsTr("Bitrate (bits/secs)")
            validator: RegExpValidator {
                regExp: /\d+/
            }
            visible: false
            Layout.fillWidth: true

            onTextChanged: {
                gbxStreamOptions.bitrate = Number(text);
                notifyOptions();
            }
        }

        Label {
            id: lblVideoGOP
            text: qsTr("Keyframes stride")
            visible: txtVideoGOP.visible
        }
        TextField {
            id: txtVideoGOP
            placeholderText: qsTr("Keyframes stride")
            text: gbxStreamOptions.videoGOP
            validator: RegExpValidator {
                regExp: /\d+/
            }
            visible: false
            Layout.fillWidth: true

            onTextChanged: {
                gbxStreamOptions.videoGOP = Number(text);
                notifyOptions();
            }
        }

        Button {
            id: advancedOptions
            text: qsTr("Advanced Codec Options")
            icon.source: "image://icons/settings"
            Layout.fillWidth: true
            Layout.columnSpan: 2
            enabled: MultiSink.codecOptions(outputIndex).length > 0

            onClicked: {
                codecConfigs.outputIndex = outputIndex;
                codecConfigs.codecName =
                        cbxCodec.model.get(cbxCodec.currentIndex).codec;
                codecConfigs.show();
            }
        }
    }
    states: [
        State {
            name: "audio"

            PropertyChanges {
                target: txtBitRate
                visible: true
            }
        },
        State {
            name: "video"

            PropertyChanges {
                target: txtVideoGOP
                visible: true
            }
            PropertyChanges {
                target: txtBitRate
                visible: true
            }
        }
    ]

    CodecConfigs {
        id: codecConfigs

        onCodecControlsChanged: MultiSink.setCodecOptions(streamIndex,
                                                          controlValues);
    }
}
