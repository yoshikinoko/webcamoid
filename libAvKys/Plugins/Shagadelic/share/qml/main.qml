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
    function hexToInt(str)
    {
        return str.length < 1? 0: parseInt(str, 16)
    }

    TextField {
        text: "0x" + Shagadelic.mask.toString(16)
        placeholderText: qsTr("Mask")
        validator: RegExpValidator {
            regExp: /(0x)?[0-9a-fA-F]{1,8}/
        }
        Layout.fillWidth: true

        onTextChanged: Shagadelic.mask = hexToInt(text)
    }
}
