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

import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

ColumnLayout {
    TextField {
        text: Photocopy.brightness
        placeholderText: qsTr("Brightness")
        validator: RegExpValidator {
            regExp: /-?(\d+\.\d+|\d+\.|\.\d+|\d+)/
        }
        Layout.fillWidth: true

        onTextChanged: Photocopy.brightness = text
    }
    TextField {
        text: Photocopy.contrast
        placeholderText: qsTr("Contrast")
        validator: RegExpValidator {
            regExp: /-?(\d+\.\d+|\d+\.|\.\d+|\d+)/
        }
        Layout.fillWidth: true

        onTextChanged: Photocopy.contrast = text
    }
}
